-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <09.08.2019>
-- Description:	<Ermitteln Sales Ancon Helifix Australia>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_ANAH] 
	-- Add the parameters for the stored procedure here
(
	@P_Year smallint,
	@P_Month tinyint
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- take-up variables from the cursor:
	DECLARE
	 @lDataAreaID nvarchar(8)
	,@lOrigSalesID nvarchar(20)
	,@lInvoiceID nvarchar(20)
	,@lLineNum numeric(28,12)
	,@lInventtransID nvarchar(20)
	,@lDatefinancial datetime
	,@lOrderAccount nvarchar(20)
	,@lItemID nvarchar(20)
	,@lDlvcountryregionid nvarchar(20)
	,@lPackingslipid nvarchar(20)
	,@lQty numeric(28,12)
	,@lLineAmountMST numeric(28,12)
	,@lLineAmountEUR numeric(28,12)

	,@lSalesBalance numeric(28,12)
	,@lSalesBalanceEUR numeric(28,12)
	,@lcurrencycode nvarchar(3)
	,@lcounter smallint

	,@I_Currentdate datetime = convert(date, getdate())

    -- Insert statements for procedure here

	--  Ancon Australia 

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where DATAAREAID = 'ANAH' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and datepart(MM, ACCOUNTINGDATE) = @P_Month

	Select 
	t.DATAAREAID as DATAAREAID, 
	t.INVOICEID as INVOICEID, 
	t.SALESID as salesid, 
	t.INVENTTRANSID as inventtransid, 
	t.LINENUM as linenum, 
	i.DATEFINANCIAL as datefinancial, 
	i.PACKINGSLIPID as packingslipid, 
	sum(i.COSTAMOUNTPOSTED) as costamountposted,  
	sum(i.COSTAMOUNTADJUSTMENT) as costamountadjustment 
	into #inventtrans_ANAH
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join [base_ancon_australia_2_dwh].[FACT_INVENTTRANS] as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'hlau' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and i.DATEFINANCIAL < @I_Currentdate
	group by t.DATAAREAID, t.INVOICEID, t.SALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID 
	order by t.DATAAREAID, t.INVOICEID, t.SALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID; 

	-- Doppelte Sätze löschen. Geht leider ein Datefinancial und eine PackingslipID verloren, dafür werden die Zahlen richtig.
	-- Obwohl wir in der COMMON TABLE EXPRESSION table löschen, werden die doppelten Sätze in der temporären Tabelle #inventtrans_ANAH gelöscht.
	WITH CTE_inventtrans AS
	(
		SELECT DATAAREAID, INVOICEID, SALESID, INVENTTRANSID, LINENUM, ROW_NUMBER() 
		OVER(PARTITION BY DATAAREAID, INVOICEID, SALESID, INVENTTRANSID, linenum 
			ORDER BY DATAAREAID, INVOICEID, SALESID, INVENTTRANSID, LINENUM ) RowNumber
		FROM #inventtrans_ANAH
	)
	DELETE FROM CTE_inventtrans WHERE RowNumber > 1

	insert custinvoicetrans
	select
	'ANAH',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'ANAH-' + j.ORDERACCOUNT,
	'ANAH-' + t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST / c.CRHRATE,
	0,
	0,
	0,
	0,
	0, -- Sales 100 für Ancon AU später addieren
	0,
	t.LINEAMOUNTMST * 0.036 * (-1), -- Interne Fracht 3,6 %
	t.LINEAMOUNTMST * 0.036 * (-1) / c.CRHRATE,
	i.COSTAMOUNTPOSTED + i.COSTAMOUNTADJUSTMENT,
	(i.COSTAMOUNTPOSTED + i.COSTAMOUNTADJUSTMENT) / c.CRHRATE
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANAH as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] as c
	on Datepart(YYYY, i.DATEFINANCIAL) = c.year and
	   'AUD' = c.CURRENCY
	where t.DATAAREAID = 'hlau' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and t.ITEMID not in ('FRA', 'MISC', 'RESTOCK')

	-- other sales

	DECLARE OtherSalesCursor CURSOR FAST_FORWARD FOR

	select 'ANAH',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	j.ORDERACCOUNT,
	t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.qty,
	t.LINEAMOUNTMST
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANAH as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'hlau' and Datepart(yyyy, i.datefinancial) = @P_Year and Datepart(mm, i.datefinancial) = @P_Month and t.ITEMID in ('FRA', 'MISC', 'RESTOCK')

	OPEN OtherSalesCursor FETCH NEXT FROM OtherSalesCursor INTO	@lDataAreaID
	,@lOrigSalesID
	,@lInvoiceID
	,@lLineNum
	,@lInventtransID
	,@lDatefinancial
	,@lOrderAccount
	,@lItemID
	,@lDlvcountryregionid
	,@lPackingslipid
	,@lQty
	,@lLineAmountMST

	-- now loop cursor rows...
	WHILE @@FETCH_STATUS = 0 
	BEGIN -- do row specific stuff here
	
	set @lcounter = 0

	select @lSalesBalance = ISNULL(sum(t.PRODUCTSALESLOCAL),0), @lSalesBalanceEUR = ISNULL(sum(t.PRODUCTSALESEUR),0), @lcounter = count(*) from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANAH' and t.INVOICEID = @lInvoiceID and t.ITEMID not in ('ANAH-FRA', 'ANAH-MISC', 'ANAH-RESTOCK')

	-- LineamountMST nach EUR umrechnen
	select @lLineAmountEUR = @lLineAmountMST / CRHRATE from [dbo].[CRHCURRENCY] where year = Datepart(YYYY, @lDatefinancial) and CURRENCY = 'AUD'

	IF @lSalesBalance <> 0
	BEGIN
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set CUSTINVOICETRANS.OTHERSALESLOCAL += @lLineAmountMST * t.PRODUCTSALESLOCAL/@lSalesBalance,
	    CUSTINVOICETRANS.OTHERSALESEUR   += @lLineAmountEUR * t.PRODUCTSALESEUR/@lSalesBalanceEUR
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANAH' and t.INVOICEID = @lInvoiceID and t.ITEMID not in ('ANAH-FRA', 'ANAH-MISC', 'ANAH-RESTOCK')
	END 
	ELSE
	BEGIN
	If @lcounter > 0
	BEGIN
	-- Falls Positionen vorhanden, aber ohne Umsatz
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set CUSTINVOICETRANS.OTHERSALESLOCAL += @lLineAmountMST / @lcounter,
	    CUSTINVOICETRANS.OTHERSALESEUR   += @lLineAmountEUR / @lcounter
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANAH' and t.INVOICEID = @lInvoiceID and t.ITEMID not in ('ANAH-FRA', 'ANAH-MISC', 'ANAH-RESTOCK')
	END
	ELSE
	BEGIN
	-- Falls keine Positionen vorhanden, aber Miscellaneous Charges vorhanden, dann Position für die Miscellaneous Charge anlegen
	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	select
	@lDataAreaID
	,@lOrigSalesID
	,@lInvoiceID
	,@lLineNum
	,@lInventtransID
	,@lDatefinancial
	,'ANAH-' + @lOrderAccount
	,'ANAH-' + @lItemID
	,@lDlvcountryregionid
	,@lPackingslipid
	,@lQty
	,0
	,0
	,@lLineAmountMST
	,@lLineAmountEUR
	,0
	,0
	,0
	,0
	,0
	,0
	,0
	,0
	END
	END

	FETCH NEXT FROM OtherSalesCursor INTO 	@lDataAreaID
	,@lOrigSalesID
	,@lInvoiceID
	,@lLineNum
	,@lInventtransID
	,@lDatefinancial
	,@lOrderAccount
	,@lItemID
	,@lDlvcountryregionid
	,@lPackingslipid
	,@lQty
	,@lLineAmountMST
	END

	-- clean cursor 
	CLOSE OtherSalesCursor 
	DEALLOCATE OtherSalesCursor

	-- SALES100 aufbauen
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set CUSTINVOICETRANS.SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    CUSTINVOICETRANS.SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'ANAH' and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- update deliverycountryregion = AU, if ' '
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'AU'
	where DATAAREAID = 'ANAH' and DELIVERYCOUNTRYID = ' ' and Datepart(yyyy, ACCOUNTINGDATE) = @P_Year and Datepart(mm, ACCOUNTINGDATE) = @P_Month

Drop table #inventtrans_ANAH

END

