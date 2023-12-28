-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <12.07.2019>
-- Description:	<Ermitteln Sales Plaka Belgien>
-- =============================================

CREATE PROCEDURE [intm_axbi].[up_ReadSales_PLAKA_BE] 
(
@P_Year [smallint],
@P_Month [tinyint],
@P_DelNotInv [nvarchar](1),
@t_jobId varchar(36),
@t_jobDtm datetime, 
@t_jobBy nvarchar(128)
 )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	declare @lTecDlvNotInv datetime
	
	select @lTecDlvNotInv = CALENDARDATE from [base_dw_halfen_0_hlp].[CALENDAR] where DATAAREAID = '5300' and YEAR = @P_Year and MONTH = @P_Month and DATEFLAG = 'W' and WORKDAY_ACT = 1

	--  Plaka BE 

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where DATAAREAID = 'PLBE' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and datepart(MM, ACCOUNTINGDATE) = @P_Month

	Select t.DATAAREAID as DATAAREAID, 
	t.INVOICEID as INVOICEID, 
	t.ORIGSALESID as ORIGSALESID, 
	t.INVENTTRANSID as INVENTTRANSID, 
	t.LINENUM as LINENUM, 
	max(i.DATEFINANCIAL) as DATEFINANCIAL, 
	max(i.PACKINGSLIPID) as PACKINGSLIPID, 
	sum(i.CostAmount) as COSTAMOUNT 
	into #inventtrans_PLBE
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTRANS] as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'plb' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	group by t.DATAAREAID, t.INVOICEID, t.ORIGSALESID, t.INVENTTRANSID, t.LINENUM; 

	-- Doppelte Sätze löschen. Geht leider ein Datefinancial und eine PackingslipID verloren, dafür werden die Zahlen richtig.
	-- Obwohl wir haben in COMMON TABLE EXPRESSION table löschen, werden die doppelten Sätze in der temporären Tabelle #inventtrans_PLBE gelöscht.
	/*SELECT 
    DATAAREAID, 
	INVOICEID, 
	ORIGSALESID, 
	INVENTTRANSID, 
	LINENUM, 
	DATEFINANCIAL, 
	PACKINGSLIPID, 
    COSTAMOUNT
	into #inventtrans_PLBE
	FROM 
	(SELECT 
	DATAAREAID, 
	INVOICEID, 
	ORIGSALESID, 
	INVENTTRANSID, 
	LINENUM, 
	DATEFINANCIAL, 
	PACKINGSLIPID, 
    COSTAMOUNT,
	ROW_NUMBER() 
		OVER(PARTITION BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM 
			ORDER BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM ) RowNumber
	from #inventtrans_PLBE_dup
	) d
	where d.RowNumber=1*/
	

	--insert main sales
	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	(DATAAREAID
    ,SALESID
    ,INVOICEID
    ,LINENUM
    ,INVENTTRANSID
    ,ACCOUNTINGDATE
    ,CUSTOMERNO
    ,ITEMID
    ,DELIVERYCOUNTRYID
    ,PACKINGSLIPID
    ,QTY
    ,PRODUCTSALESLOCAL
    ,PRODUCTSALESEUR
    ,OTHERSALESLOCAL
    ,OTHERSALESEUR
    ,ALLOWANCESLOCAL
    ,ALLOWANCESEUR
    ,SALES100LOCAL
    ,SALES100EUR
    ,FREIGHTLOCAL
    ,FREIGHTEUR
    ,COSTAMOUNTLOCAL
    ,COSTAMOUNTEUR
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select
	'PLBE',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'PLBE-' + j.INVOICEACCOUNT,
	'PLBE-' + t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)), -- Sales 100 für PLAKA BE später addieren
	CAST(0 as [DECIMAL](38, 12)),
	t.LINEAMOUNTMST * 0.034 * (-1), -- Interne Fracht 3,4 %
	t.LINEAMOUNTMST * 0.034 * (-1),
	i.COSTAMOUNT,
	i.COSTAMOUNT,
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join [base_tx_crh_2_dwh].[DIM_INVENTTABLE] as g
	on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
	   t.ITEMID = g.ITEMID
	inner join #inventtrans_PLBE as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'plb' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and g.ADUASCHWITEMGROUP4 <> 'EL' 

	-- Auftrag SO/2026711 mit Rechnungsnummer SIN/2013953 wieder löschen.

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where DATAAREAID = 'PLBE' and SALESID = 'SO/2026711' and INVOICEID = 'SIN/2013953'

	--
	-- Geliefert nicht fakturiert
	If @P_DelNotInv = 'Y'
	Begin

	-- Erster Wochentag des Monats lesen; für nicht fakturierte Lieferscheine aus den Vormonaten, das ACCOUNTINGDATE auf den ersten Tag des aktuellen Monats legen  


	Select 
	i.DATAAREAID as DATAAREAID, 
	a.SALESID as SALESID, 
	'9999999999999' as INVOICEID, 
	999 as LINENUM, 
	i.INVENTTRANSID as INVENTTRANSID,
	i.DATEPHYSICAL as DATEPHYSICAL, 
	i.INVOICEACCOUNT as INVOICEACCOUNT, 
	i.ITEMID as ITEMID,
	a.DELIVERYCOUNTRYREGIONID as DELIVERYCOUNTRYREGIONID,  
	i.PACKINGSLIPID as PACKINGSLIPID,
	sum(i.QTY) * (-1) as QTY, 
	sum(i.ValueCalc) as PRODUCTSALESLOCAL, 
	sum(i.CostAmount) as COSTAMOUNT,
	i.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	i.t_extractionDtm as t_extractionDtm
	into #cust_delivered_not_invoiced_PLBE
	from [base_tx_crh_2_dwh].[FACT_INVENTRANS_NOT_INVOICED] as i
	inner join [base_tx_crh_2_dwh].[FACT_SALESLINE] as a
	on lower(i.DATAAREAID) = lower(a.DATAAREAID) and
	   i.TRANSREFID    = a.SALESID and
	   i.INVENTTRANSID = a.INVENTTRANSID
	where lower(i.DATAAREAID) = 'plb' 
	and Datepart(yyyy, i.DATEPHYSICAL) = @P_Year
	and Datepart(mm, i.DATEPHYSICAL) = @P_Month
	and i.ValueCalc is not null 
	group by i.DATAAREAID, a.SALESID, i.INVENTTRANSID, i.DATEPHYSICAL, i.INVOICEACCOUNT, i.ITEMID, a.DELIVERYCOUNTRYREGIONID, i.PACKINGSLIPID, i.t_applicationId, i.t_extractionDtm 

	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	(DATAAREAID
    ,SALESID
    ,INVOICEID
    ,LINENUM
    ,INVENTTRANSID
    ,ACCOUNTINGDATE
    ,CUSTOMERNO
    ,ITEMID
    ,DELIVERYCOUNTRYID
    ,PACKINGSLIPID
    ,QTY
    ,PRODUCTSALESLOCAL
    ,PRODUCTSALESEUR
    ,OTHERSALESLOCAL
    ,OTHERSALESEUR
    ,ALLOWANCESLOCAL
    ,ALLOWANCESEUR
    ,SALES100LOCAL
    ,SALES100EUR
    ,FREIGHTLOCAL
    ,FREIGHTEUR
    ,COSTAMOUNTLOCAL
    ,COSTAMOUNTEUR
	,t_applicationId
    ,t_jobId 
    ,t_jobDtm 
    ,t_jobBy
    ,t_extractionDtm)
	select
	'PLBE',
	SALESID,
	INVOICEID,
	LINENUM,
	ISNULL(INVENTTRANSID,' '),
	case 
	when DATEPHYSICAL < @lTecDlvNotInv
	then @lTecDlvNotInv
	else DATEPHYSICAL 
	end, -- für nicht fakturierte Lieferscheine aus den Vormonaten, das ACCOUNTINGDATE auf den ersten Tag des aktuellen Monats legen, sonst das Lieferdatum
	'PLBE-' + INVOICEACCOUNT,
	'PLBE-' + ITEMID,
	ISNULL(DELIVERYCOUNTRYREGIONID,' '),
	ISNULL(PACKINGSLIPID,' '),
	QTY,
	PRODUCTSALESLOCAL,
	PRODUCTSALESLOCAL,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)), -- Sales 100 für PLAKA BE später addieren
	CAST(0 as [DECIMAL](38, 12)),
	PRODUCTSALESLOCAL * 0.034 * (-1), -- Interne Fracht 3,4 %
	PRODUCTSALESLOCAL * 0.034 * (-1),
	COSTAMOUNT * (-1),
	COSTAMOUNT * (-1),
	t_applicationId,
    t_jobId,
    t_jobDtm,
    t_jobBy,
    t_extractionDtm 
	from #cust_delivered_not_invoiced_PLBE
	End

	-- PLAKA Verpackungsartikel MB15066 nach OtherSales übertragen 

	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	(DATAAREAID
    ,SALESID
    ,INVOICEID
    ,LINENUM
    ,INVENTTRANSID
    ,ACCOUNTINGDATE
    ,CUSTOMERNO
    ,ITEMID
    ,DELIVERYCOUNTRYID
    ,PACKINGSLIPID
    ,QTY
    ,PRODUCTSALESLOCAL
    ,PRODUCTSALESEUR
    ,OTHERSALESLOCAL
    ,OTHERSALESEUR
    ,ALLOWANCESLOCAL
    ,ALLOWANCESEUR
    ,SALES100LOCAL
    ,SALES100EUR
    ,FREIGHTLOCAL
    ,FREIGHTEUR
    ,COSTAMOUNTLOCAL
    ,COSTAMOUNTEUR
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select
	'PLBE',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'PLBE-' + j.INVOICEACCOUNT,
	'PLBE-' + t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)), -- Sales 100 für PLAKA BE später addieren
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	i.COSTAMOUNT,
	i.COSTAMOUNT,
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_PLBE as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'plb' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	and t.ITEMID = 'MB15066'

	-- Sales ohne Kunde in Kundenstamm löschen 
	delete from t from [intm_axbi].[fact_CUSTINVOICETRANS] as t
		     left outer join [intm_axbi].[dim_CUSTTABLE] as c
			 on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
				t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(t.DATAAREAID) = 'PLBE' and c.ACCOUNTNUM is null

	-- Fehlendes DUMMY Lieferland eintragen 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'BE'
	where upper(DATAAREAID) = 'PLBE' and DELIVERYCOUNTRYID = ' '

	-- PLAKA Customer Bonus nach Allowances übertragen 

	-- BAM 2,55 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0255 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0255 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and c.COMPANYCHAINID = 'BAM'
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month


	-- PMO 4,25 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0425 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0425 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and (c.COMPANYCHAINID like 'PMO %' or c.COMPANYCHAINID like '% PMO %') 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- ALLMAT 6,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0650 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0650 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and (c.COMPANYCHAINID like 'ALLMAT %' or c.COMPANYCHAINID like '% ALLMAT %') 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- GEDIMAT 3,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0350 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0350 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and c.COMPANYCHAINID = 'GEDIMAT' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month


	-- TOUT FAIRE 4,34 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0434 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0434 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and c.COMPANYCHAINID = 'TOUT FAIRE CMEM' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month
	

	-- BINJE ACKERMANS 5,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.05 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.05 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and (c.COMPANYCHAINID like 'BINJE ACKERMANS %' or c.COMPANYCHAINID like '% BINJE ACKERMANS %') 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- GROUP VANDERSTRAETEN 0,32 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0032 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0032 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' and c.COMPANYCHAINID = 'VANDERSTRAETEN' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month


	-- LO.VE.MAT 1,40 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0140 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0140 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and (c.COMPANYCHAINID like 'LO.VE.MAT %' or c.COMPANYCHAINID like '% LO.VE.MAT %') 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- JAN DE NUL 0,37 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0037 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0037 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and (c.COMPANYCHAINID like 'JAN DE NUL %' or c.COMPANYCHAINID like '% JAN DE NUL %' or c.COMPANYCHAINID like 'DE NUL JAN%' or c.COMPANYCHAINID like '% DE NUL JAN %') 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- BESIX - QPRODOR 0,00%

	-- MBG-CFE BOUW VLAANDEREN 1,78 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0178 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0178 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLBE' 
	and c.COMPANYCHAINID = 'MBG CFE BOUW VLAANDE' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

-- other sales

	select 'PLBE' as DATAAREAID,
	t.ORIGSALESID as SALESID,
	t.INVOICEID as INVOICEID,
	t.LINENUM as LINENUM,
	ISNULL(t.INVENTTRANSID,' ') as INVENTTRANSID,
	i.DATEFINANCIAL as ACCOUNTINGDATE,
	j.INVOICEACCOUNT as CUSTOMERNO,
	t.ITEMID as ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' ') as DELIVERYCOUNTRYID,
	ISNULL(i.PACKINGSLIPID,' ') as PACKINGSLIPID,
	t.QTY,
	t.LINEAMOUNTMST LINEAMOUNTMST_OS,
	count(t.INVOICEID) over (partition by t.INVOICEID) cnt_inv,
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	into #inventtrans_PLBE_OS
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join [base_tx_crh_2_dwh].[DIM_INVENTTABLE] as g
	on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
	   t.ITEMID = g.ITEMID
	inner join #inventtrans_PLBE as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID 
	where lower(t.DATAAREAID) = 'plb' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	and t.ITEMID <> 'MB15066' 
	and g.ADUASCHWITEMGROUP4 = 'EL' 

	
--salesbalance calculation
	select 
	t.INVOICEID,
	ISNULL(sum(t.PRODUCTSALESLOCAL),0) salesbalance
	into #inventtrans_PLBE_SB
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join [intm_axbi].[dim_ITEMTABLE] as g
	on lower(t.DATAAREAID) = lower(g.DATAAREAID) 
	and	t.ITEMID = g.ITEMID
	inner join #inventtrans_PLBE_OS os
	on t.INVOICEID = os.INVOICEID 
	where upper(t.DATAAREAID) = 'PLBE' 
	and g.ITEMGROUPID <> 'PLBE-EL'
	group by t.INVOICEID


--lineamountmst sum calculation
	select INVOICEID,
	sum(LINEAMOUNTMST_OS) lineamountmst_os_sum
	into #inventtrans_PLBE_LA
	from #inventtrans_PLBE_OS
	group by INVOICEID
	
--lcounter calculation	
	select INVOICEID, 
	count (*) lcounter
    into #inventtrans_PLBE_cnt
    from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join [intm_axbi].[dim_ITEMTABLE] as g
	on lower(t.DATAAREAID) = lower(g.DATAAREAID) 
	and	t.ITEMID = g.ITEMID
	where upper(t.DATAAREAID) = 'PLBE' 
	and g.ITEMGROUPID <> 'PLBE-EL'
	group by INVOICEID


--update #1
update [intm_axbi].[fact_CUSTINVOICETRANS]
set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += (la.lineamountmst_os_sum * t.PRODUCTSALESLOCAL/ sb.salesbalance) * os.cnt_inv,
    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += (la.lineamountmst_os_sum * t.PRODUCTSALESEUR/sb.salesbalance) * os.cnt_inv
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
 inner join [intm_axbi].[dim_ITEMTABLE] as g
on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
   t.ITEMID     = g.ITEMID 
inner join #inventtrans_PLBE_OS os
on t.INVOICEID  = os.INVOICEID  
inner join #inventtrans_PLBE_SB sb
on t.INVOICEID =sb.INVOICEID 
inner join #inventtrans_PLBE_LA la
on t.INVOICEID =la.INVOICEID 
where upper(t.DATAAREAID) = 'PLBE' 
and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
and g.ITEMGROUPID <> 'PLBE-EL'
and sb.salesbalance<>0


--update #2
update [intm_axbi].[fact_CUSTINVOICETRANS]
   set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += la.lineamountmst_os_sum / cnt.lcounter,
	   [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += la.lineamountmst_os_sum / cnt.lcounter
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join [intm_axbi].[dim_ITEMTABLE] as g
on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
t.ITEMID = g.ITEMID  
inner join #inventtrans_PLBE_SB sb
on t.INVOICEID =sb.INVOICEID 
inner join #inventtrans_PLBE_LA la
on t.INVOICEID =la.INVOICEID 
inner join #inventtrans_PLBE_cnt cnt
on t.INVOICEID =cnt.INVOICEID 
where upper(t.DATAAREAID) = 'PLBE' 
and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
and g.ITEMGROUPID <> 'PLBE-EL'
and sb.salesbalance = 0


--insert for other sales
insert [intm_axbi].[fact_CUSTINVOICETRANS]
   (DATAAREAID
   ,SALESID
   ,INVOICEID
   ,LINENUM
   ,INVENTTRANSID
   ,ACCOUNTINGDATE
   ,CUSTOMERNO
   ,ITEMID
   ,DELIVERYCOUNTRYID
   ,PACKINGSLIPID
   ,QTY
   ,PRODUCTSALESLOCAL
   ,PRODUCTSALESEUR
   ,OTHERSALESLOCAL
   ,OTHERSALESEUR
   ,ALLOWANCESLOCAL
   ,ALLOWANCESEUR
   ,SALES100LOCAL
   ,SALES100EUR
   ,FREIGHTLOCAL
   ,FREIGHTEUR
   ,COSTAMOUNTLOCAL
   ,COSTAMOUNTEUR
   ,t_applicationId
   ,t_jobId 
   ,t_jobDtm 
   ,t_jobBy
   ,t_extractionDtm)
	select
	DATAAREAID,
	SALESID,
	INVOICEID,
	LINENUM,
	INVENTTRANSID,
	ACCOUNTINGDATE,
	'PLBE-' + CUSTOMERNO,
	'PLBE-' + ITEMID,
	DELIVERYCOUNTRYID,
	PACKINGSLIPID,
	QTY,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	LINEAMOUNTMST_OS,
	LINEAMOUNTMST_OS,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	t_applicationId,
    t_jobId,
    t_jobDtm,
    t_jobBy,
    t_extractionDtm 
	from #inventtrans_PLBE_OS
	where INVOICEID  not in 
	(select t.INVOICEID from [intm_axbi].[fact_CUSTINVOICETRANS] as t
     inner join [intm_axbi].[dim_ITEMTABLE] as g
     on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
     t.ITEMID = g.ITEMID 
	where upper(t.DATAAREAID) = 'PLBE' 
    and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
    and g.ITEMGROUPID <> 'PLBE-EL')


	-- SALES100 aufbauen
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].SALES100LOCAL = ISNULL(i.PRODUCTSALESLOCAL,0) + ISNULL(i.OTHERSALESLOCAL,0) + ISNULL(i.ALLOWANCESLOCAL,0),
	    [intm_axbi].[fact_CUSTINVOICETRANS].SALES100EUR   = ISNULL(i.PRODUCTSALESEUR,0) + ISNULL(i.OTHERSALESEUR,0) + ISNULL(i.ALLOWANCESEUR,0)
	from [intm_axbi].[fact_CUSTINVOICETRANS] as i
	where upper(i.DATAAREAID) = 'PLBE' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- für die Item Group ACT und Cost Amount = 0 and 3P customer, Cost amount rechnen, so daß Marge 40%
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.6 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.6 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	inner join [intm_axbi].[dim_CUSTTABLE] as c
	on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
	   t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMGROUPID = 'PLBE-ACT' 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0 
	and c.COMPANYCHAINID <> 'PLAKA FRANCE'

	-- für die Item Group ACT und Cost Amount = 0 and Intercompany customer, Cost amount rechnen so daß Marge 33%
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.67 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.67 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	inner join [intm_axbi].[dim_CUSTTABLE] as c
	on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
	   t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMGROUPID = 'PLBE-ACT' 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0 
	and c.COMPANYCHAINID = 'PLAKA FRANCE'

	-- für die Items “KORG”, “KORI2”, “KORSBS“, “KORSGS“ und Cost Amount = 0 and 3P customer, Cost amount rechnen so daß 55% Marge
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.45 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.45 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	inner join [intm_axbi].[dim_CUSTTABLE] as c
	on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
	   t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMID in ('PLBE-KORG', 'PLBE-KORI2', 'PLBE-KORSBS', 'PLBE-KORSGS') 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0 
	and c.COMPANYCHAINID <> 'PLAKA FRANCE'

	-- für die Items “KORG”, “KORI2”, “KORSBS“, “KORSGS“ und Cost Amount = 0 and Intercompany customer, Cost amount rechnen so daß 33% Marge
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.67 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.67 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	inner join [intm_axbi].[dim_CUSTTABLE] as c
	on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
	   t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMID in ('PLBE-KORG', 'PLBE-KORI2', 'PLBE-KORSBS', 'PLBE-KORSGS') 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0 
	and c.COMPANYCHAINID = 'PLAKA FRANCE'

	-- für die Items “KORSI2S”, “KORSI4S” und Cost Amount = 0,  Cost amount rechnen so daß 67% Marge
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.33 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.33 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMID in ('PLBE-KORI', 'PLBE-KORSI2S', 'PLBE-KORSI4S') 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0

	-- für Item “KORCOM” und Cost Amount = 0, Cost amount rechnen so daß 5€ Marge pro M
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = Case when t.SALES100LOCAL <> 0 Then (t.SALES100LOCAL - (t.QTY * 5)) * (-1) Else 0 End, -- QTY is MT and per MT 5 €
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = Case when t.SALES100EUR <> 0 Then (t.SALES100EUR - (t.QTY * 5)) * (-1) Else 0 End -- QTY is MT and per MT 5 €
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMID = 'PLBE-KORCOM' 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0

	-- für die Items “VGATERAND”, “PSSPEC” und Cost Amount = 0 and 3P Customer, Cost amount rechnen so daß 39.4% Marge
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.606 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.606 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	inner join [intm_axbi].[dim_CUSTTABLE] as c
	on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
	   t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMID in ('PLBE-VGATERAND', 'PLBE-PSSPEC') 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0 
	and c.COMPANYCHAINID <> 'PLAKA FRANCE'

	-- für die Items “VGATERAND”, “PSSPEC” und Cost Amount = 0 and Intercompany Customer, Cost amount rechnen so daß 28,5% Marge
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.715 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.715 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	inner join [intm_axbi].[dim_CUSTTABLE] as c
	on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
	   t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMID in ('PLBE-VGATERAND', 'PLBE-PSSPEC') 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0 
	and c.COMPANYCHAINID = 'PLAKA FRANCE'

	-- für die Items “LASER” und Cost Amount = 0 and 3P customer, Cost amount rechnen so daß 37.5% Marge
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.625 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.625 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	inner join [intm_axbi].[dim_CUSTTABLE] as c
	on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
	   t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMID = 'PLBE-LASER' 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0 
	and c.COMPANYCHAINID <> 'PLAKA FRANCE'

	-- für die Items “LASER” und Cost Amount = 0 and Intercompany customer, Cost amount rechnen so daß 37% marge
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTLOCAL = t.SALES100LOCAL * 0.63 * (-1),
	    [intm_axbi].[fact_CUSTINVOICETRANS].COSTAMOUNTEUR   = t.SALES100EUR * 0.63 * (-1)
	from [intm_axbi].[dim_ITEMTABLE] as i
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as t
	on lower(i.DATAAREAID) = lower(t.DATAAREAID) and
	   i.ITEMID     = t.ITEMID
	inner join [intm_axbi].[dim_CUSTTABLE] as c
	on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
	   t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(i.DATAAREAID) = 'PLBE' 
	and i.ITEMID = 'PLBE-LASER' 
	and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
	and t.COSTAMOUNTLOCAL = 0 
	and c.COMPANYCHAINID = 'PLAKA FRANCE'

--drop temp tables
--drop table #inventtrans_PLBE_dup
drop table #inventtrans_PLBE
drop table #inventtrans_PLBE_OS
drop table #inventtrans_PLBE_SB
drop table #inventtrans_PLBE_LA
IF OBJECT_ID(N'tempdb..#cust_delivered_not_invoiced_PLBE') IS NOT NULL
BEGIN
DROP TABLE #cust_delivered_not_invoiced_PLBE
END
drop table #inventtrans_PLBE_cnt

End