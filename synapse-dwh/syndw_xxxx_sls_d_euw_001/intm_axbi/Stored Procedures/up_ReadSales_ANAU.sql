﻿-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <09.08.2019>
-- Description:	<Ermitteln Sales Ancon Australia>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_ANAU] 
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
	 @lDATAAREAID nvarchar(8)
	,@lOrigSALESID nvarchar(20)
	,@lINVOICEID nvarchar(20)
	,@lLINENUM numeric(28,12)
	,@lINVENTTRANSID nvarchar(20)
	,@lDATEFINANCIAL datetime
	,@lOrderAccount nvarchar(20)
	,@lItemID nvarchar(20)
	,@lDlvcountryregionid nvarchar(20)
	,@lPACKINGSLIPID nvarchar(20)
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

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where DATAAREAID = 'ANAU' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and datepart(MM, ACCOUNTINGDATE) = @P_Month

	Select 
	t.DATAAREAID as DATAAREAID, 
	t.INVOICEID as INVOICEID, 
	t.SALESID as SALESID, 
	t.INVENTTRANSID as INVENTTRANSID, 
	t.LINENUM as LINENUM, 
	i.DATEFINANCIAL as DATEFINANCIAL, 
	i.PACKINGSLIPID as PACKINGSLIPID, 
	sum(i.COSTAMOUNTPOSTED) as COSTAMOUNTPOSTED,  
	sum(i.COSTAMOUNTADJUSTMENT) as COSTAMOUNTADJUSTMENT 
	into #inventtrans_ANAU
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join [base_ancon_australia_2_dwh].[FACT_INVENTTRANS] as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'anau' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and i.DATEFINANCIAL < @I_Currentdate
	group by t.DATAAREAID, t.INVOICEID, t.SALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID 
	order by t.DATAAREAID, t.INVOICEID, t.SALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID; 

	-- Doppelte Sätze löschen. Geht leider ein DATEFINANCIAL und eine PACKINGSLIPID verloren, dafür werden die Zahlen richtig.
	-- Obwohl wir in der COMMON TABLE EXPRESSION table löschen, werden die doppelten Sätze in der temporären Tabelle #inventtrans_ANAH gelöscht.
	WITH CTE_inventtrans AS
	(
		SELECT DATAAREAID, INVOICEID, SALESID, INVENTTRANSID, LINENUM, ROW_NUMBER() 
		OVER(PARTITION BY DATAAREAID, INVOICEID, SALESID, INVENTTRANSID, LINENUM 
			ORDER BY DATAAREAID, INVOICEID, SALESID, INVENTTRANSID, LINENUM ) RowNumber
		FROM #inventtrans_ANAU
	)
	DELETE FROM CTE_inventtrans WHERE RowNumber > 1

	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	select
	'ANAU',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'ANAU-' + j.ORDERACCOUNT,
	'ANAU-' + t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.qty,
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST / c.CRHRATE,
	0,
	0,
	0,
	0,
	0, -- Sales 100 für Ancon AU später addieren
	0,
	t.LINEAMOUNTMST * 0.036 * (-1), -- Interne Fracht 3,6 %
	t.LINEAMOUNTMST / c.CRHRATE * 0.036 * (-1),
	i.COSTAMOUNTPOSTED + i.COSTAMOUNTADJUSTMENT,
	(i.COSTAMOUNTPOSTED + i.COSTAMOUNTADJUSTMENT) / c.CRHRATE
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANAU as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] as c
	on Datepart(YYYY, i.DATEFINANCIAL) = c.year and
	   'AUD' = c.CURRENCY
	where t.DATAAREAID = 'anau' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and t.ITEMID not in ('AIR', 'DHL', 'FRA', 'FRA1KG', 'FRA3KG', 'FRA5KG', 'MISC')

	-- ANCON AUSTRALIA Customer Bonus nach Allowances übertragen 

	-- customer 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'ANAU' and c.ACCOUNTNUM in ('ANAU-3865', 'ANAU-4063', 'ANAU-4128', 'ANAU-8381') and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- other sales

	DECLARE OtherSalesCursor CURSOR FAST_FORWARD FOR

	select 'ANAU',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	j.ORDERACCOUNT,
	t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	i.PACKINGSLIPID,
	t.QTY,
	t.LINEAMOUNTMST
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join [base_ancon_australia_2_dwh].[FACT_INVENTTRANS] as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'anau' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and t.ITEMID in ('AIR', 'DHL', 'FRA', 'FRA1KG', 'FRA3KG', 'FRA5KG', 'MISC')

	OPEN OtherSalesCursor FETCH NEXT FROM OtherSalesCursor INTO	@lDATAAREAID
	,@lOrigSALESID
	,@lINVOICEID
	,@lLINENUM
	,@lINVENTTRANSID
	,@lDATEFINANCIAL
	,@lOrderAccount
	,@lItemID
	,@lDlvcountryregionid
	,@lPACKINGSLIPID
	,@lQty
	,@lLineAmountMST

	-- now loop cursor rows...
	WHILE @@FETCH_STATUS = 0 
	BEGIN -- do row specific stuff here

	set @lcounter = 0

	select @lSalesBalance = ISNULL(sum(t.PRODUCTSALESLOCAL),0), @lSalesBalanceEUR = ISNULL(sum(t.PRODUCTSALESEUR),0), @lcounter = count(*) from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANAU' and t.INVOICEID = @lINVOICEID and t.ITEMID not in ('ANAU-AIR', 'ANAU-DHL', 'ANAU-FRA', 'ANAU-FRA1KG', 'ANAU-FRA3KG', 'ANAU-FRA5KG', 'ANAU-MISC')

	-- LineamountMST nach EUR umrechnen
	select @lLineAmountEUR = @lLineAmountMST / CRHRATE from [base_tx_ca_0_hlp].[CRHCURRENCY] where YEAR = Datepart(YYYY, @lDATEFINANCIAL) and CURRENCY = 'AUD'

	IF @lSalesBalance <> 0
	BEGIN
	-- Falls reguläre Postionen mit Umsatz vorhanden
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += @lLineAmountMST * t.PRODUCTSALESLOCAL/@lSalesBalance,
	    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += @lLineAmountEUR * t.PRODUCTSALESEUR/@lSalesBalanceEUR
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANAU' and t.INVOICEID = @lINVOICEID and t.ITEMID not in ('ANAU-AIR', 'ANAU-DHL', 'ANAU-FRA', 'ANAU-FRA1KG', 'ANAU-FRA3KG', 'ANAU-FRA5KG', 'ANAU-MISC')
	END 
	ELSE
	BEGIN
	If @lcounter > 0
	BEGIN
	-- Falls Positionen vorhanden, aber ohne Umsatz
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += @lLineAmountMST / @lcounter,
	    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += @lLineAmountEUR / @lcounter
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	where t.DATAAREAID = 'ANAU' and t.INVOICEID = @lINVOICEID and t.ITEMID not in ('ANAU-AIR', 'ANAU-DHL', 'ANAU-FRA', 'ANAU-FRA1KG', 'ANAU-FRA3KG', 'ANAU-FRA5KG', 'ANAU-MISC')
	END
	ELSE
	BEGIN
	-- Falls keine Positionen vorhanden, aber Miscellaneous Charges vorhanden, dann Position für die Miscellaneous Charge anlegen
	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	select
	@lDATAAREAID
	,@lOrigSALESID
	,@lINVOICEID
	,@lLINENUM
	,@lINVENTTRANSID
	,@lDATEFINANCIAL
	,'ANAU-' + @lOrderAccount
	,'ANAU-' + @lItemID
	,@lDlvcountryregionid
	,@lPACKINGSLIPID
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

	FETCH NEXT FROM OtherSalesCursor INTO 	@lDATAAREAID
	,@lOrigSALESID
	,@lINVOICEID
	,@lLINENUM
	,@lINVENTTRANSID
	,@lDATEFINANCIAL
	,@lOrderAccount
	,@lItemID
	,@lDlvcountryregionid
	,@lPACKINGSLIPID
	,@lQty
	,@lLineAmountMST
	END

	-- clean cursor 
	CLOSE OtherSalesCursor 
	DEALLOCATE OtherSalesCursor

	-- SALES100 aufbauen
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    [intm_axbi].[fact_CUSTINVOICETRANS].SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'ANAU' and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- update deliverycountryregion = AU, if ' '
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'AU'
	where DATAAREAID = 'ANAU' and DELIVERYCOUNTRYID = ' ' and Datepart(yyyy, ACCOUNTINGDATE) = @P_Year and Datepart(mm, ACCOUNTINGDATE) = @P_Month

	Drop table #inventtrans_ANAU

END