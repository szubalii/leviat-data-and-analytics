-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <08.08.2019>
-- Description:	<Ermitteln <Umsatz für Ancon Germany>
-- =============================================
--
CREATE PROCEDURE [int_axbi].[up_ReadSales_ANDE] 
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
	,@lPackingslipID nvarchar(20)
	,@lQty numeric(28,12)
	,@lLineAmountMST numeric(28,12)

	,@lSalesBalance numeric(28,12)
	,@lcounter smallint

    -- Insert statements for procedure here

	--  Ancon DE 

	delete from [CUSTINVOICETRANS] where DATAAREAID = 'ANDE' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and datepart(MM, ACCOUNTINGDATE) = @P_Month

	Select t.DATAAREAID as DATAAREAID, 
	t.INVOICEID as INVOICEID, 
	t.ORIGSALESID as ORIGSALESID, 
	t.INVENTTRANSID as INVENTTRANSID, 
	t.LINENUM as LINENUM, 
	i.DATEFINANCIAL as datefinancial, 
	i.PACKINGSLIPID as packingslipid, 
	sum(i.COSTAMOUNT) as costamount 
	into #inventtrans_ANDE
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [TX_CRH_2_DWH_UAT].dbo.DIM_CUSTINVOICEJOUR as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join [TX_CRH_1_STG_UAT].[dbo].[AX_CRH_A_dbo_INVENTTRANS] as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'ande' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	group by t.DATAAREAID, t.INVOICEID, t.ORIGSALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID 
	order by t.DATAAREAID, t.INVOICEID, t.ORIGSALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID;

	-- Doppelte Sätze löschen. Geht leider ein Datefinancial und eine PackingslipID verloren, dafür werden die Zahlen richtig.
	-- Obwohl wir in der COMMON TABLE EXPRESSION table löschen, werden die doppelten Sätze in der temporären Tabelle #inventtrans_ANDE gelöscht.
	WITH CTE_inventtrans AS
	(
		SELECT DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM, ROW_NUMBER() 
		OVER(PARTITION BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM 
			ORDER BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM ) RowNumber
		FROM #inventtrans_ANDE
	)
	DELETE FROM CTE_inventtrans WHERE RowNumber > 1

	insert custinvoicetrans
	select
	'ANDE',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'ANDE-' + j.ORDERACCOUNT,
	'ANDE-' + t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST,
	0,
	0,
	t.LINEAMOUNTMST * [dbo].[uf_get_CashDiscPct](u.cashdisc) / 100 * (-1),
	t.LINEAMOUNTMST * [dbo].[uf_get_CashDiscPct](u.cashdisc) / 100 * (-1),
	0, -- Sales 100 für Ancon DE später addieren
	0,
	t.lineamountmst * 0.034 * (-1), -- Interne Fracht 3,4 %
	t.lineamountmst * 0.034 * (-1),
	i.costamount,
	i.costamount
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTTABLE] as u
	on t.DATAAREAID = u.DATAAREAID and
	   t.INVOICEACCOUNT = u.ACCOUNTNUM
	inner join [TX_CRH_2_DWH_UAT].dbo.DIM_CUSTINVOICEJOUR as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANDE as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'ande' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and t.ITEMID not in ('DIENST', 'FRACHT', 'MINDERMENGE', 'POSZU') 

	-- other sales

	DECLARE OtherSalesCursor CURSOR FAST_FORWARD FOR

	select 'ANDE',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	j.ORDERACCOUNT,
	t.ITEMID,
	ISNULL(t.dlvcountryregionid,' '),
	ISNULL(i.packingslipid,' '),
	t.qty,
	t.lineamountmst
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [TX_CRH_2_DWH_UAT].dbo.DIM_CUSTINVOICEJOUR as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANDE as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'ande' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and t.ITEMID in ('DIENST', 'FRACHT', 'MINDERMENGE', 'POSZU')

	OPEN OtherSalesCursor FETCH NEXT FROM OtherSalesCursor INTO	@lDataAreaID
	,@lOrigSalesID
	,@lInvoiceID
	,@lLineNum
	,@lInventtransID
	,@lDatefinancial
	,@lOrderAccount
	,@lItemID
	,@lDlvcountryregionid
	,@lPackingslipID
	,@lQty
	,@lLineAmountMST

	-- now loop cursor rows...
	WHILE @@FETCH_STATUS = 0 
	BEGIN -- do row specific stuff here
	
	set @lcounter = 0

	select @lSalesBalance = ISNULL(sum(t.PRODUCTSALESLOCAL),0), @lcounter = count(*) from [CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANDE' and t.INVOICEID = @lInvoiceID and t.ITEMID not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')

	IF @lSalesBalance <> 0
	BEGIN
	-- Falls reguläre Postionen mit Umsatz vorhanden
	update CUSTINVOICETRANS
	set CUSTINVOICETRANS.OTHERSALESLOCAL += @lLineAmountMST * t.PRODUCTSALESLOCAL/@lSalesBalance,
	    CUSTINVOICETRANS.OTHERSALESEUR   += @lLineAmountMST * t.PRODUCTSALESEUR/@lSalesBalance
	from [CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANDE' and t.INVOICEID = @lInvoiceID and t.ITEMID not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
	END 
	ELSE
	BEGIN
	If @lcounter > 0
	BEGIN
	-- Falls Positionen vorhanden, aber ohne Umsatz
	update CUSTINVOICETRANS
	set CUSTINVOICETRANS.OTHERSALESLOCAL += @lLineAmountMST / @lcounter,
	    CUSTINVOICETRANS.OTHERSALESEUR   += @lLineAmountMST / @lcounter
	from [CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANDE' and t.INVOICEID = @lInvoiceID and t.ITEMID not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
	END
	ELSE
	BEGIN
	-- Falls keine Positionen vorhanden, aber Miscellaneous Charges vorhanden, dann Position für die Miscellaneous Charge anlegen
	insert custinvoicetrans
	select
	@lDataAreaID
	,@lOrigSalesID
	,@lInvoiceID
	,@lLineNum
	,@lInventtransID
	,@lDatefinancial
	,'ANDE-' + @lOrderAccount
	,'ANDE-' + @lItemID
	,@lDlvcountryregionid
	,@lPackingslipID
	,@lQty
	,0
	,0
	,@lLineAmountMST
	,@lLineAmountMST
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
	,@lPackingslipID
	,@lQty
	,@lLineAmountMST
	END

	-- clean cursor 
	CLOSE OtherSalesCursor 
	DEALLOCATE OtherSalesCursor

	-- SALES100 aufbauen
	update CUSTINVOICETRANS
	set CUSTINVOICETRANS.SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    CUSTINVOICETRANS.SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from CUSTTABLE as c
	inner join [CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'ANDE' and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month
	
	-- Fehlendes DUMMY Lieferland eintragen 
	update CUSTINVOICETRANS
	set DELIVERYCOUNTRYID = 'DE'
	where DATAAREAID = 'ANDE' and DELIVERYCOUNTRYID = ' '

	Drop table #inventtrans_ANDE

END