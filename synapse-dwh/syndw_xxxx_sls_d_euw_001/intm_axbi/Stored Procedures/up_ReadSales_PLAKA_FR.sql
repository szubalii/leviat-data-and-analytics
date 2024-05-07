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
	@P_DelNotInv nvarchar(1),
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
	
	select @lTecDlvNotInv = CALENDARDATE 
    from [base_dw_halfen_0_hlp].[CALENDAR] 
    where DATAAREAID = '5300' and YEAR = @P_Year 
    and MONTH = @P_Month and DATEFLAG = 'W' and WORKDAY_ACT = 1


	--  Plaka FR 

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where DATAAREAID = 'PLFR' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and datepart(MM, ACCOUNTINGDATE) = @P_Month

	Select t.DATAAREAID as DATAAREAID, 
	t.INVOICEID as INVOICEID, 
	t.ORIGSALESID as ORIGSALESID, 
	t.INVENTTRANSID as INVENTTRANSID, 
	t.LINENUM as LINENUM, 
	i.DATEFINANCIAL as DATEFINANCIAL, 
	i.PACKINGSLIPID as PACKINGSLIPID, 
	sum(i.CostAmount) as CostAmount 
	into #inventtrans_PLFR_dup
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTRANS] as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'plf' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	group by t.DATAAREAID, t.INVOICEID, t.ORIGSALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID; 

	-- Doppelte Sätze löschen. Geht leider ein Datefinancial und eine PackingslipID verloren, dafür werden die Zahlen richtig.
	-- Obwohl wir haben in COMMON TABLE EXPRESSION table löschen, werden die doppelten Sätze in der temporären Tabelle #inventtrans_PLFR gelöscht.
	SELECT 
    DATAAREAID, 
	INVOICEID, 
	ORIGSALESID, 
	INVENTTRANSID, 
	LINENUM, 
	DATEFINANCIAL, 
	PACKINGSLIPID, 
    CostAmount
	into #inventtrans_PLFR
	FROM 
	(SELECT 
	DATAAREAID, 
	INVOICEID, 
	ORIGSALESID, 
	INVENTTRANSID, 
	LINENUM, 
	DATEFINANCIAL, 
	PACKINGSLIPID, 
    CostAmount,
	ROW_NUMBER() 
		OVER(PARTITION BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM 
			ORDER BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM ) RowNumber
	from #inventtrans_PLFR_dup
	) d
	where d.RowNumber=1
	

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
	'PLFR',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'PLFR-' + j.ORDERACCOUNT,
	'PLFR-' + t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)), -- Sales 100 für PLAKA FR später addieren
	CAST(0 as [DECIMAL](38, 12)),
	case
	when t.DIMENSION = 'SFCA' then ISNULL(t.LINEAMOUNTMST * 0.080,0) * (-1)
	when t.DIMENSION = 'SFLI' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.DIMENSION = 'SFLY' then ISNULL(t.LINEAMOUNTMST * 0.080,0) * (-1)
	when t.DIMENSION = 'SFNA' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.DIMENSION = 'SFPA' then ISNULL(t.LINEAMOUNTMST * 0.056,0) * (-1)
	when t.DIMENSION = 'SFRO' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.DIMENSION = 'SFTL' then ISNULL(t.LINEAMOUNTMST * 0.061,0) * (-1)
	when t.DIMENSION = 'SFTO' then ISNULL(t.LINEAMOUNTMST * 0.078,0) * (-1)
	else
	ISNULL(t.LINEAMOUNTMST * 0.068,0) * (-1)
	end,
	case
	when t.DIMENSION = 'SFCA' then ISNULL(t.LINEAMOUNTMST * 0.080,0) * (-1)
	when t.DIMENSION = 'SFLI' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.DIMENSION = 'SFLY' then ISNULL(t.LINEAMOUNTMST * 0.080,0) * (-1)
	when t.DIMENSION = 'SFNA' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.DIMENSION = 'SFPA' then ISNULL(t.LINEAMOUNTMST * 0.056,0) * (-1)
	when t.DIMENSION = 'SFRO' then ISNULL(t.LINEAMOUNTMST * 0.077,0) * (-1)
	when t.DIMENSION = 'SFTL' then ISNULL(t.LINEAMOUNTMST * 0.061,0) * (-1)
	when t.DIMENSION = 'SFTO' then ISNULL(t.LINEAMOUNTMST * 0.078,0) * (-1)
	else
	ISNULL(t.LINEAMOUNTMST * 0.068,0) * (-1)
	end,
	i.CostAmount,
	i.CostAmount,
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
	inner join #inventtrans_PLFR as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'plf' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month 
	and g.ADUASCHWITEMGROUP4 <> 'EL' 

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
	i.Dimension as DIMENSION,
	sum(i.QTY) * (-1) as QTY, 
	sum(i.ValueCalc) as PRODUCTSALESLOCAL, 
	sum(i.CostAmount) as CostAmount,
	i.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	i.t_extractionDtm as t_extractionDtm
	into #cust_delivered_not_invoiced_PLFR
	from [base_tx_crh_2_dwh].[FACT_INVENTRANS_NOT_INVOICED] as i
	inner join [base_tx_crh_2_dwh].[FACT_SALESLINE] as a
	on lower(i.DATAAREAID)  = lower(a.DATAAREAID) and
	   i.TRANSREFID    = a.SALESID and
	   i.INVENTTRANSID = a.INVENTTRANSID
	where lower(i.DATAAREAID) = 'plf' 
	and Datepart(yyyy, i.DATEPHYSICAL) = @P_Year 
	and Datepart(mm, i.DATEPHYSICAL) = @P_Month 
	and i.ValueCalc is not null 
	group by i.DATAAREAID, a.SALESID, i.INVENTTRANSID, i.DATEPHYSICAL, i.INVOICEACCOUNT, i.ITEMID, a.DELIVERYCOUNTRYREGIONID, i.PACKINGSLIPID, i.Dimension, i.t_applicationId, i.t_extractionDtm

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
	'PLFR',
	SALESID,
	INVOICEID,
	LINENUM,
	ISNULL(INVENTTRANSID,' '),
	case when DATEPHYSICAL < @lTecDlvNotInv
	then @lTecDlvNotInv else DATEPHYSICAL end, -- für nicht fakturierte Lieferscheine aus den Vormonaten, das ACCOUNTINGDATE auf den ersten Tag des aktuellen Monats legen, sonst das Lieferdatum
	'PLFR-' + INVOICEACCOUNT,
	'PLFR-' + ITEMID,
	ISNULL(DELIVERYCOUNTRYREGIONID,' '),
	ISNULL(PACKINGSLIPID,' '),
	QTY,
	PRODUCTSALESLOCAL,
	PRODUCTSALESLOCAL,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)), -- Sales 100 für PLAKA FR später addieren
	CAST(0 as [DECIMAL](38, 12)),
	case
	when DIMENSION = 'SFCA' then ISNULL(PRODUCTSALESLOCAL * 0.080,0) * (-1)
	when DIMENSION = 'SFLI' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when DIMENSION = 'SFLY' then ISNULL(PRODUCTSALESLOCAL * 0.080,0) * (-1)
	when DIMENSION = 'SFNA' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when DIMENSION = 'SFPA' then ISNULL(PRODUCTSALESLOCAL * 0.056,0) * (-1)
	when DIMENSION = 'SFRO' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when DIMENSION = 'SFTL' then ISNULL(PRODUCTSALESLOCAL * 0.061,0) * (-1)
	when DIMENSION = 'SFTO' then ISNULL(PRODUCTSALESLOCAL * 0.078,0) * (-1)
	else
	ISNULL(PRODUCTSALESLOCAL * 0.068,0) * (-1)
	end,
	case
	when DIMENSION = 'SFCA' then ISNULL(PRODUCTSALESLOCAL * 0.080,0) * (-1)
	when DIMENSION = 'SFLI' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when DIMENSION = 'SFLY' then ISNULL(PRODUCTSALESLOCAL * 0.080,0) * (-1)
	when DIMENSION = 'SFNA' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when DIMENSION = 'SFPA' then ISNULL(PRODUCTSALESLOCAL * 0.056,0) * (-1)
	when DIMENSION = 'SFRO' then ISNULL(PRODUCTSALESLOCAL * 0.077,0) * (-1)
	when DIMENSION = 'SFTL' then ISNULL(PRODUCTSALESLOCAL * 0.061,0) * (-1)
	when DIMENSION = 'SFTO' then ISNULL(PRODUCTSALESLOCAL * 0.078,0) * (-1)
	else
	ISNULL(PRODUCTSALESLOCAL * 0.068,0) * (-1)
	end,
	CostAmount * (-1),
	CostAmount * (-1),
	t_applicationId,
    t_jobId,
    t_jobDtm,
    t_jobBy,
    t_extractionDtm 
	from #cust_delivered_not_invoiced_PLFR
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
	'PLFR',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'PLFR-' + j.ORDERACCOUNT,
	'PLFR-' + t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)), -- Sales 100 für PLAKA FR später addieren
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	i.CostAmount,
	i.CostAmount,
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_PLFR as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'plf' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month 
	and t.ITEMID = 'MB15066'

	-- Sales ohne Kunde in Kundenstamm löschen 
	delete from t from [intm_axbi].[fact_CUSTINVOICETRANS] as t
		     left outer join [intm_axbi].[dim_CUSTTABLE] as c
			 on lower(t.DATAAREAID) = lower(c.DATAAREAID) and
				t.CUSTOMERNO = c.ACCOUNTNUM
	where upper(t.DATAAREAID) = 'PLFR' and c.ACCOUNTNUM is null

	-- Fehlendes DUMMY Lieferland eintragen 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'FR'
	where upper(DATAAREAID) = 'PLFR' and DELIVERYCOUNTRYID = ' '

	-- PLAKA Customer Bonus nach Allowances übertragen 

	-- BOUYGUES 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'BOUYGUES' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- CGC CONSTRUCTIONS 1,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0150 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0150 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'CGC CONSTRUCTIONS' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- CHAUSSON 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'CHAUSSON' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- CHAZELLE 1,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0100 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0100 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'CHAZELLE' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- COSTANTINI FRANCE 4,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0450 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0450 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'COSTANTINI FRANCE' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- CRH IDF DISTRIBUTION 1,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0100 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0100 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and (c.COMPANYCHAINID like 'CRH %' or c.COMPANYCHAINID like '% CRH %') 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- C. S A M 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID like '% S A M %' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- DEMATHIEU 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID like '%DEMATHIEU%' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- DESCOURS 1,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0150 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0150 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID like '%DESCOURS%' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- EIFFAGE 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'EIFFAGE' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- FAYAT 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and datepart(YYYY, ACCOUNTINGDATE) = @P_Year 
	and c.COMPANYCHAINID = 'FAYAT' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- FORBAT SARL 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'FORBAT SARL' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- GAGNEREAU 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'GAGNEREAU' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- GB FINANCE 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'GB FINANCE' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- ENTREPRISE GUENO 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'ENTREPRISE GUENO' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- JOUVENT 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'JOUVENT' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- GROUPE LB 3,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0350 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0350 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'GROUPE LB' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- LEGROS 1,70 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0170 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0170 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'LEGROS' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- GROSSE 3,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0350 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0350 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'GROSSE' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- REVILLON 1,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0100 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0100 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'REVILLON' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- MDO 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'MDO' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- MAZAUD ENTR GENERALE SAS 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'MAZAUD ENTR GENERALE SAS' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- MBC 4,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0400 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0400 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'MBC' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- POINT P 4,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0450 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0450 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID like '%POINT P%' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- RABOT 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'RABOT' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- RAMERY 3,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0300 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0300 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'RAMERY' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- SAMSE 6,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0650 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0650 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'SAMSE' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- SAVOIE SAS 1,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0100 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0100 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'SAVOIE SAS' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- SRB CONSTRUCTION 2,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0250 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0250 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'SRB CONSTRUCTION' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- VINCI 4,50 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0450 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0450 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' 
	and c.COMPANYCHAINID = 'VINCI' 
	and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- other sales
	select 'PLFR' as DATAAREAID,
	t.ORIGSALESID as SALESID,
	t.INVOICEID as INVOICEID,
	t.LINENUM as LINENUM,
	ISNULL(t.INVENTTRANSID,' ') as INVENTTRANSID,
	i.DATEFINANCIAL as ACCOUNTINGDATE,
	j.ORDERACCOUNT as CUSTOMERNO,
	t.ITEMID as ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' ') as DELIVERYCOUNTRYID,
	ISNULL(i.PACKINGSLIPID,' ') as PACKINGSLIPID,
	t.QTY as QTY,
	t.LINEAMOUNTMST LINEAMOUNTMST_OS,--,
	--count(t.INVOICEID) over (partition by t.INVOICEID) cnt_inv
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	into #inventtrans_PLFR_OS
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join [base_tx_crh_2_dwh].[DIM_INVENTTABLE] as g
	on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
	   t.ITEMID = g.ITEMID
	inner join #inventtrans_PLFR as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'plf' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and datepart(MM, i.DATEFINANCIAL) = @P_Month 
	and t.ITEMID <> 'MB15066'  
	and g.ADUASCHWITEMGROUP4 = 'EL'

	--salesbalance calculation
	select 
	t.INVOICEID,
	ISNULL(sum(t.PRODUCTSALESLOCAL),0) salesbalance,
    count (*) lcounter
	into #inventtrans_PLFR_SB
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join [intm_axbi].[dim_ITEMTABLE] as g
	on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
	t.ITEMID = g.ITEMID
	--inner join #inventtrans_PLFR_OS os
	--on t.INVOICEID = os.INVOICEID 
	where upper(t.DATAAREAID) = 'PLFR' 
	and g.ITEMGROUPID <> 'PLFR-EL'
  --  and EXISTS (
		--	SELECT 1
		--	FROM #inventtrans_PLFR_OS os
		--	WHERE t.INVOICEID = os.INVOICEID 
		--)
	group by t.INVOICEID;


--lineamountmst sum calculation
	--select INVOICEID,
	--sum(LINEAMOUNTMST_OS) lineamountmst_os_sum
	--into #inventtrans_PLFR_LA
	--from #inventtrans_PLFR_OS
	--group by INVOICEID
	
--lcounter calculation	
	--select INVOICEID, 
	--count (*) lcounter
 --   into #inventtrans_PLFR_cnt
 --   from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	--inner join [intm_axbi].[dim_ITEMTABLE] as g
	--on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
	--t.ITEMID = g.ITEMID
 --   where upper(t.DATAAREAID) = 'PLFR' 
	--and g.ITEMGROUPID <> 'PLFR-EL'
	--group by t.INVOICEID;
	
	--update #1
/*update [intm_axbi].[fact_CUSTINVOICETRANS]
set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += (la.lineamountmst_os_sum * t.PRODUCTSALESLOCAL/ sb.salesbalance) * os.cnt_inv,
    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += (la.lineamountmst_os_sum * t.PRODUCTSALESEUR/sb.salesbalance) * os.cnt_inv
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
 inner join [intm_axbi].[dim_ITEMTABLE] as g
on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
   t.ITEMID     = g.ITEMID 
inner join #inventtrans_PLFR_OS os
on t.INVOICEID  = os.INVOICEID  
inner join #inventtrans_PLFR_SB sb
on t.INVOICEID =sb.INVOICEID 
inner join #inventtrans_PLFR_LA la
on t.INVOICEID =la.INVOICEID 
where upper(t.DATAAREAID) = 'PLFR' 
and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year 
and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
and g.ITEMGROUPID <> 'PLFR-EL'
and sb.salesbalance<>0*/

WITH PCC AS (
		SELECT t.SALESID
			,t.INVOICEID
			,t.LINENUM
			,SUM((os.LINEAMOUNTMST_OS * t.PRODUCTSALESLOCAL/ sb.salesbalance) /* * os.cnt_inv*/) as l_sum
	    	,SUM((os.LINEAMOUNTMST_OS * t.PRODUCTSALESEUR/sb.salesbalance)/* * os.cnt_inv */) as e_sum
    	FROM [intm_axbi].[fact_CUSTINVOICETRANS] AS t
        inner join [intm_axbi].[dim_ITEMTABLE] as g
        on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
           t.ITEMID     = g.ITEMID 
        inner join #inventtrans_PLFR_OS os
        on t.INVOICEID  = os.INVOICEID  
        inner join #inventtrans_PLFR_SB sb
        on t.INVOICEID =sb.INVOICEID 
        --inner join #inventtrans_PLFR_LA la
        --on t.INVOICEID =la.INVOICEID 
        where upper(t.DATAAREAID) = 'PLFR' 
        and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year 
        and datepart(MM, t.ACCOUNTINGDATE) = @P_Month
        and g.ITEMGROUPID <> 'PLFR-EL'
        and sb.salesbalance<>0
    	GROUP BY t.SALESID,t.INVOICEID, t.LINENUM
	)
UPDATE [intm_axbi].[fact_CUSTINVOICETRANS]
SET OTHERSALESLOCAL += PCC.l_sum,
    OTHERSALESEUR   += PCC.e_sum
FROM [intm_axbi].[fact_CUSTINVOICETRANS] as t
INNER JOIN PCC
	ON t.SALESID=PCC.SALESID AND t.INVOICEID=PCC.INVOICEID AND t.LINENUM=PCC.LINENUM;


--update #2
--update [intm_axbi].[fact_CUSTINVOICETRANS]
--   set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += la.lineamountmst_os_sum / cnt.lcounter,
--	   [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += la.lineamountmst_os_sum / cnt.lcounter
--from [intm_axbi].[fact_CUSTINVOICETRANS] as t
--inner join [intm_axbi].[dim_ITEMTABLE] as g
--on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
--t.ITEMID = g.ITEMID  
--inner join #inventtrans_PLFR_SB sb
--on t.INVOICEID =sb.INVOICEID 
--inner join #inventtrans_PLFR_LA la
--on t.INVOICEID =la.INVOICEID 
--inner join #inventtrans_PLFR_cnt cnt
--on t.INVOICEID =cnt.INVOICEID 
--where upper(t.DATAAREAID) = 'PLFR' 
--and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year 
--and datepart(MM, t.ACCOUNTINGDATE) = @P_Month 
--and g.ITEMGROUPID <> 'PLFR-EL'
--and lcounter>0
--and salesbalance = 0

WITH PCC AS (
		SELECT t.SALESID
			,t.INVOICEID
			,t.LINENUM
			,SUM(os.LINEAMOUNTMST_OS / sb.lcounter) as l_sum
	    	,SUM(os.LINEAMOUNTMST_OS / sb.lcounter) as e_sum
    	FROM [intm_axbi].[fact_CUSTINVOICETRANS] AS t
        inner join [intm_axbi].[dim_ITEMTABLE] as g
        on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
        t.ITEMID = g.ITEMID
        inner join #inventtrans_PLFR_OS os
        on t.INVOICEID  = os.INVOICEID  
        inner join #inventtrans_PLFR_SB sb
        on t.INVOICEID =sb.INVOICEID 
        --inner join #inventtrans_PLFR_LA la
        --on t.INVOICEID =la.INVOICEID 
        --inner join #inventtrans_PLFR_cnt cnt
        --on t.INVOICEID =cnt.INVOICEID 
        where upper(t.DATAAREAID) = 'PLFR' 
        and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year 
        and datepart(MM, t.ACCOUNTINGDATE) = @P_Month 
        and g.ITEMGROUPID <> 'PLFR-EL'
        and lcounter>0
        and salesbalance = 0
    	GROUP BY t.SALESID,t.INVOICEID, t.LINENUM
	)
UPDATE [intm_axbi].[fact_CUSTINVOICETRANS]
SET OTHERSALESLOCAL += PCC.l_sum,
    OTHERSALESEUR   += PCC.e_sum
FROM [intm_axbi].[fact_CUSTINVOICETRANS] as t
INNER JOIN PCC
	ON t.SALESID=PCC.SALESID AND t.INVOICEID=PCC.INVOICEID AND t.LINENUM=PCC.LINENUM;


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
	'PLFR-' + CUSTOMERNO,
	'PLFR-' + ITEMID,
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
	from #inventtrans_PLFR_OS
	where INVOICEID  not in 
	(select t.INVOICEID from [intm_axbi].[fact_CUSTINVOICETRANS] as t
     inner join [intm_axbi].[dim_ITEMTABLE] as g
     on lower(t.DATAAREAID) = lower(g.DATAAREAID) and
     t.ITEMID = g.ITEMID  
	 where upper(t.DATAAREAID) = 'PLFR' 
     and datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year 
     and datepart(MM, t.ACCOUNTINGDATE) = @P_Month 
     and g.ITEMGROUPID <> 'PLFR-EL')


	-- SALES100 aufbauen
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    [intm_axbi].[fact_CUSTINVOICETRANS].SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'PLFR' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	--drop temp tables
drop table #inventtrans_PLFR_dup
drop table #inventtrans_PLFR
drop table #inventtrans_PLFR_OS
drop table #inventtrans_PLFR_SB
--drop table #inventtrans_PLFR_LA
IF OBJECT_ID(N'tempdb..#cust_delivered_not_invoiced_PLFR') IS NOT NULL
BEGIN
DROP TABLE #cust_delivered_not_invoiced_PLFR
END
--drop table #inventtrans_PLFR_cnt

END