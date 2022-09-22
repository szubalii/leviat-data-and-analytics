-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <07.08.2019>
-- Description:	<Ermitteln Sales France>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_PLAKA_FR] 
	-- Add the parameters for the stored procedure here
(
	@P_Year smallint,
	@P_Month tinyint,
	@P_DelNotInv nvarchar(1)
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
	,@lITEMID nvarchar(20)
	,@lDlvcountryregionid nvarchar(20)
	,@lPackingslipid nvarchar(20)
	,@lQTY numeric(28,12)
	,@lLINEAMOUNTMST numeric(28,12)

	,@lSalesBalance numeric(28,12)
	,@lcounter smallint

	,@lTecDlvNotInv datetime

    -- Insert statements for procedure here

	--  Plaka FR 

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where DATAAREAID = 'PLFR' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and datepart(MM, ACCOUNTINGDATE) = @P_Month

	Select t.DATAAREAID as DATAAREAID, t.INVOICEID as INVOICEID, t.ORIGSALESID as ORIGSALESID, t.INVENTTRANSID as INVENTTRANSID, t.LINENUM as LINENUM, i.DATEFINANCIAL as DATEFINANCIAL, i.PACKINGSLIPID as PACKINGSLIPID, sum(i.CostAmount) as CostAmount into #inventtrans_PLFR
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTRANS] as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'plf' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	group by t.DATAAREAID, t.INVOICEID, t.ORIGSALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID 
	order by t.DATAAREAID, t.INVOICEID, t.ORIGSALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID; 

	-- Doppelte Sätze löschen. Geht leider ein Datefinancial und eine PackingslipID verloren, dafür werden die Zahlen richtig.
	-- Obwohl wir haben in COMMON TABLE EXPRESSION table löschen, werden die doppelten Sätze in der temporären Tabelle #inventtrans_PLFR gelöscht.
	WITH CTE_inventtrans AS
	(
		SELECT DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM, ROW_NUMBER() 
		OVER(PARTITION BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM 
			ORDER BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM ) RowNumber
		FROM #inventtrans_PLFR
	)
	DELETE FROM CTE_inventtrans WHERE RowNumber > 1

	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	select
	'PLFR',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'PLFR-' + j.orderaccount,
	'PLFR-' + t.ITEMID,
	ISNULL(t.dlvcountryregionid,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST,
	0,
	0,
	0,
	0,
	0, -- Sales 100 für PLAKA FR später addieren
	0,
	case
	when t.dimension = 'SFCA' then ISNULL(t.LINEAMOUNTMST * 0.080,0) * (-1)
	when t.dimension = 'SFLI' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.dimension = 'SFLY' then ISNULL(t.LINEAMOUNTMST * 0.080,0) * (-1)
	when t.dimension = 'SFNA' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.dimension = 'SFPA' then ISNULL(t.LINEAMOUNTMST * 0.056,0) * (-1)
	when t.dimension = 'SFRO' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.dimension = 'SFTL' then ISNULL(t.LINEAMOUNTMST * 0.061,0) * (-1)
	when t.dimension = 'SFTO' then ISNULL(t.LINEAMOUNTMST * 0.078,0) * (-1)
	else
	ISNULL(t.LINEAMOUNTMST * 0.068,0) * (-1)
	end,
	case
	when t.dimension = 'SFCA' then ISNULL(t.LINEAMOUNTMST * 0.080,0) * (-1)
	when t.dimension = 'SFLI' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.dimension = 'SFLY' then ISNULL(t.LINEAMOUNTMST * 0.080,0) * (-1)
	when t.dimension = 'SFNA' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.dimension = 'SFPA' then ISNULL(t.LINEAMOUNTMST * 0.056,0) * (-1)
	when t.dimension = 'SFRO' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.dimension = 'SFTL' then ISNULL(t.LINEAMOUNTMST * 0.061,0) * (-1)
	when t.dimension = 'SFTO' then ISNULL(t.LINEAMOUNTMST * 0.078,0) * (-1)
	else
	ISNULL(t.LINEAMOUNTMST * 0.068,0) * (-1)
	end,
	i.CostAmount,
	i.CostAmount
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join [base_tx_crh_2_dwh].[DIM_INVENTTABLE] as g
	on t.DATAAREAID = g.DATAAREAID and
	   t.ITEMID = g.ITEMID
	inner join #inventtrans_PLFR as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'plf' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and g.ADUASCHWITEMGROUP4 <> 'EL' 

	-- Geliefert nicht fakturiert
	If @P_DelNotInv = 'Y'
	Begin

	-- Erster Wochentag des Monats lesen; für nicht fakturierte Lieferscheine aus den Vormonaten, das ACCOUNTINGDATE auf den ersten Tag des aktuellen Monats legen  
	select @lTecDlvNotInv = CALENDARDATE from [base_dw_halfen_0_hlp].[CALENDAR] where DATAAREAID = '5300' and YEAR = @P_Year and MONTH = @P_Month and DATEFLAG = 'W' and WORKDAY_ACT = 1

	Select i.DATAAREAID as DATAAREAID, a.SALESID as SALESID, '9999999999999' as INVOICEID, 999 as LINENUM, i.INVENTTRANSID as INVENTTRANSID,
	       i.DATEPHYSICAL as DATEPHYSICAL, i.INVOICEACCOUNT as INVOICEACCOUNT, i.ITEMID as ITEMID,
		   a.DELIVERYCOUNTRYREGIONID as deliverycountryregionid,  i.PACKINGSLIPID as PACKINGSLIPID, i.Dimension as dimension,
		   sum(i.QTY) * (-1) as QTY, sum(i.ValueCalc) as PRODUCTSALESLOCAL, sum(i.CostAmount) as CostAmount into #cust_delivered_not_invoiced_PLFR
	from [base_tx_crh_2_dwh].[FACT_INVENTRANS_NOT_INVOICED] as i
	inner join [base_tx_crh_2_dwh].[FACT_SALESLINE] as a
	on i.DATAAREAID    = a.DATAAREAID and
	   i.TRANSREFID    = a.SALESID and
	   i.INVENTTRANSID = a.INVENTTRANSID
	where i.DATAAREAID = 'plf' and Datepart(yyyy, i.DATEPHYSICAL) = @P_Year and Datepart(mm, i.DATEPHYSICAL) = @P_Month and i.ValueCalc is not null 
	group by i.DATAAREAID, a.SALESID, i.INVENTTRANSID, i.DATEPHYSICAL, i.INVOICEACCOUNT, i.ITEMID, a.DELIVERYCOUNTRYREGIONID, i.PACKINGSLIPID, i.Dimension 
	order by i.DATAAREAID, a.SALESID, i.INVENTTRANSID, i.DATEPHYSICAL, i.INVOICEACCOUNT, i.ITEMID, a.DELIVERYCOUNTRYREGIONID, i.PACKINGSLIPID, i.Dimension 

	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	select
	'PLFR',
	SALESID,
	INVOICEID,
	LINENUM,
	ISNULL(INVENTTRANSID,' '),
	case when DATEPHYSICAL < @lTecDlvNotInv then @lTecDlvNotInv else DATEPHYSICAL end, -- für nicht fakturierte Lieferscheine aus den Vormonaten, das ACCOUNTINGDATE auf den ersten Tag des aktuellen Monats legen, sonst das Lieferdatum
	'PLFR-' + INVOICEACCOUNT,
	'PLFR-' + ITEMID,
	ISNULL(deliverycountryregionid,' '),
	ISNULL(PACKINGSLIPID,' '),
	QTY,
	PRODUCTSALESLOCAL,
	PRODUCTSALESLOCAL,
	0,
	0,
	0,
	0,
	0, -- Sales 100 für PLAKA FR später addieren
	0,
	case
	when dimension = 'SFCA' then ISNULL(PRODUCTSALESLOCAL * 0.080,0) * (-1)
	when dimension = 'SFLI' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when dimension = 'SFLY' then ISNULL(PRODUCTSALESLOCAL * 0.080,0) * (-1)
	when dimension = 'SFNA' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when dimension = 'SFPA' then ISNULL(PRODUCTSALESLOCAL * 0.056,0) * (-1)
	when dimension = 'SFRO' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when dimension = 'SFTL' then ISNULL(PRODUCTSALESLOCAL * 0.061,0) * (-1)
	when dimension = 'SFTO' then ISNULL(PRODUCTSALESLOCAL * 0.078,0) * (-1)
	else
	ISNULL(PRODUCTSALESLOCAL * 0.068,0) * (-1)
	end,
	case
	when dimension = 'SFCA' then ISNULL(PRODUCTSALESLOCAL * 0.080,0) * (-1)
	when dimension = 'SFLI' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when dimension = 'SFLY' then ISNULL(PRODUCTSALESLOCAL * 0.080,0) * (-1)
	when dimension = 'SFNA' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when dimension = 'SFPA' then ISNULL(PRODUCTSALESLOCAL * 0.056,0) * (-1)
	when dimension = 'SFRO' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when dimension = 'SFTL' then ISNULL(PRODUCTSALESLOCAL * 0.061,0) * (-1)
	when dimension = 'SFTO' then ISNULL(PRODUCTSALESLOCAL * 0.078,0) * (-1)
	else
	ISNULL(PRODUCTSALESLOCAL * 0.068,0) * (-1)
	end,
	CostAmount * (-1),
	CostAmount * (-1)
	from #cust_delivered_not_invoiced_PLFR
	End

	-- PLAKA Verpackungsartikel MB15066 nach OtherSales übertragen 

	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	select
	'PLFR',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'PLFR-' + j.orderaccount,
	'PLFR-' + t.ITEMID,
	ISNULL(t.dlvcountryregionid,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	0,
	0,
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST,
	0,
	0,
	0, -- Sales 100 für PLAKA FR später addieren
	0,
	0,
	0,
	i.CostAmount,
	i.CostAmount
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_PLFR as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'plf' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and t.ITEMID = 'MB15066'

	-- Sales ohne Kunde in Kundenstamm löschen 
	delete from t from [intm_axbi].[fact_CUSTINVOICETRANS] as t
		     left outer join [intm_axbi].[dim_CUSTTABLE] as c
			 on t.DATAAREAID = c.DATAAREAID and
				t.CUSTOMERNO = c.ACCOUNTNUM
	where t.DATAAREAID = 'PLFR' and c.ACCOUNTNUM is null

	-- Fehlendes DUMMY Lieferland eintragen 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'FR'
	where DATAAREAID = 'PLFR' and DELIVERYCOUNTRYID = ' '

	-- PLAKA Customer Bonus nach Allowances übertragen 

	-- BOUYGUES 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'BOUYGUES' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- CGC CONSTRUCTIONS 1,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0150 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0150 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'CGC CONSTRUCTIONS' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- CHAUSSON 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'CHAUSSON' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- CHAZELLE 1,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0100 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0100 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'CHAZELLE' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- COSTANTINI FRANCE 4,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0450 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0450 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'COSTANTINI FRANCE' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- CRH IDF DISTRIBUTION 1,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0100 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0100 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and (c.COMPANYCHAINID like 'CRH %' or c.COMPANYCHAINID like '% CRH %') and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- C. S A M 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID like '% S A M %' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- DEMATHIEU 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID like '%DEMATHIEU%' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- DESCOURS 1,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0150 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0150 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID like '%DESCOURS%' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- EIFFAGE 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'EIFFAGE' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- FAYAT 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and c.COMPANYCHAINID = 'FAYAT' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- FORBAT SARL 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'FORBAT SARL' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- GAGNEREAU 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'GAGNEREAU' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- GB FINANCE 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'GB FINANCE' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- ENTREPRISE GUENO 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'ENTREPRISE GUENO' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- JOUVENT 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'JOUVENT' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- GROUPE LB 3,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0350 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0350 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'GROUPE LB' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- LEGROS 1,70 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0170 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0170 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'LEGROS' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- GROSSE 3,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0350 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0350 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'GROSSE' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- REVILLON 1,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0100 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0100 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'REVILLON' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- MDO 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'MDO' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- MAZAUD ENTR GENERALE SAS 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'MAZAUD ENTR GENERALE SAS' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- MBC 4,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0400 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0400 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'MBC' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- POINT P 4,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0450 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0450 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID like '%POINT P%' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- RABOT 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'RABOT' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- RAMERY 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'RAMERY' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- SAMSE 6,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0650 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0650 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'SAMSE' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- SAVOIE SAS 1,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0100 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0100 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'SAVOIE SAS' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- SRB CONSTRUCTION 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'SRB CONSTRUCTION' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- VINCI 4,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0450 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0450 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'PLFR' and c.COMPANYCHAINID = 'VINCI' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- other sales

	DECLARE OtherSalesCursor CURSOR FAST_FORWARD FOR

	select 'PLFR',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	j.orderaccount,
	t.ITEMID,
	ISNULL(t.dlvcountryregionid,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	t.LINEAMOUNTMST
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join [base_tx_crh_2_dwh].[DIM_INVENTTABLE] as g
	on t.DATAAREAID = g.DATAAREAID and
	   t.ITEMID = g.ITEMID
	inner join #inventtrans_PLFR as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'plf' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and datepart(MM, i.DATEFINANCIAL) = @P_Month and t.ITEMID <> 'MB15066'  and g.ADUASCHWITEMGROUP4 = 'EL'

	OPEN OtherSalesCursor FETCH NEXT FROM OtherSalesCursor INTO	@lDataAreaID
	,@lOrigSalesID
	,@lInvoiceID
	,@lLineNum
	,@lInventtransID
	,@lDatefinancial
	,@lOrderAccount
	,@lITEMID
	,@lDlvcountryregionid
	,@lPackingslipid
	,@lQTY
	,@lLINEAMOUNTMST

	-- now loop cursor rows...
	WHILE @@FETCH_STATUS = 0 
	BEGIN -- do row specific stuff here

	set @lcounter = 0

	select @lSalesBalance = ISNULL(sum(t.PRODUCTSALESLOCAL),0), @lcounter = count(*) from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	                                                                                 inner join [intm_axbi].[dim_ITEMTABLE] as g
																					 on t.DATAAREAID = g.DATAAREAID and
																					    t.ITEMID = g.ITEMID  
	where t.DATAAREAID = 'PLFR' and t.INVOICEID = @lInvoiceID and g.ITEMGROUPID <> 'PLFR-EL'

	IF @lSalesBalance <> 0
	BEGIN
	-- Falls reguläre Postionen mit Umsatz vorhanden
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += @lLINEAMOUNTMST * t.PRODUCTSALESLOCAL/@lSalesBalance,
	    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += @lLINEAMOUNTMST * t.PRODUCTSALESEUR/@lSalesBalance
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
    inner join [intm_axbi].[dim_ITEMTABLE] as g
	on t.DATAAREAID = g.DATAAREAID and
	   t.ITEMID     = g.ITEMID  
	where t.DATAAREAID = 'PLFR' and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year and datepart(MM, t.ACCOUNTINGDATE) = @P_Month and t.INVOICEID = @lInvoiceID and g.ITEMGROUPID <> 'PLFR-EL'
	END 
	ELSE
	BEGIN
	If @lcounter > 0
	BEGIN
	-- Falls Positionen vorhanden, aber ohne Umsatz
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += @lLINEAMOUNTMST / @lcounter,
	    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += @lLINEAMOUNTMST / @lcounter
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
    inner join [intm_axbi].[dim_ITEMTABLE] as g
	on t.DATAAREAID = g.DATAAREAID and
	   t.ITEMID     = g.ITEMID  
	where t.DATAAREAID = 'PLFR' and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year and datepart(MM, t.ACCOUNTINGDATE) = @P_Month and t.INVOICEID = @lInvoiceID and g.ITEMGROUPID <> 'PLFR-EL'
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
	,'PLFR-' + @lOrderAccount
	,'PLFR-' + @lITEMID
	,@lDlvcountryregionid
	,@lPackingslipid
	,@lQTY
	,0
	,0
	,@lLINEAMOUNTMST
	,@lLINEAMOUNTMST
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
	,@lITEMID
	,@lDlvcountryregionid
	,@lPackingslipid
	,@lQTY
	,@lLINEAMOUNTMST
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
	where c.DATAAREAID = 'PLFR' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month
END