-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <08.08.2019>
-- Description:	<Ermitteln <Umsatz für Ancon Germany>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_ANDE] 
	-- Add the parameters for the stored procedure here
(
	@P_Year smallint,
	@P_Month tinyint,
	@t_jobId varchar(36),
	@t_jobDtm datetime, 
	@t_jobBy nvarchar(128) 
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--clear the table for reporting date
delete from [intm_axbi].[fact_CUSTINVOICETRANS]
where DATAAREAID = 'ANDE' 
and datepart(YYYY, ACCOUNTINGDATE) = @P_Year
and datepart(MM, ACCOUNTINGDATE) = @P_Month

--create a temp table with all invoices for reporting period
Select 
    t.DATAAREAID as DATAAREAID, 
	t.INVOICEID as INVOICEID, 
	t.ORIGSALESID as ORIGSALESID, 
	t.INVENTTRANSID as INVENTTRANSID, 
	t.LINENUM as LINENUM, 
	i.DATEFINANCIAL as datefinancial, 
	i.PACKINGSLIPID as packingslipid, 
	sum(i.CostAmount) as costamount  into 
#inventtrans_ANDE_dup
from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
    on LOWER(t.DATAAREAID) = LOWER(j.DATAAREAID)
   and t.INVOICEID = j.INVOICEID
inner join [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTRANS] as i
	on LOWER(t.DATAAREAID) = LOWER(i.DATAAREAID) 
   and t.INVOICEID = i.INVOICEID 
   and t.INVENTTRANSID = i.INVENTTRANSID
	where LOWER(t.DATAAREAID) = 'ande' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	group by t.DATAAREAID, t.INVOICEID, t.ORIGSALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID;


--remove duplicates, non-determenistic set
	SELECT 
	DATAAREAID, 
	INVOICEID, 
	ORIGSALESID, 
	INVENTTRANSID, 
	LINENUM, 
	datefinancial, 
	packingslipid, 
    costamount
	into #inventtrans_ANDE
	FROM 
	(SELECT 
	DATAAREAID, 
	INVOICEID, 
	ORIGSALESID, 
	INVENTTRANSID, 
	LINENUM, 
	datefinancial, 
	packingslipid, 
    costamount,
	ROW_NUMBER() 
		OVER(PARTITION BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM
			 ORDER BY DATAAREAID, INVOICEID, ORIGSALESID, INVENTTRANSID, LINENUM ) RowNumber
	from #inventtrans_ANDE_dup
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
    'ANDE' as DATAAREAID,
	t.ORIGSALESID as SALESID,
	t.INVOICEID as INVOICEID,
	t.LINENUM as LINENUM,
	ISNULL(t.INVENTTRANSID,' ') as INVENTTRANSID,
	i.datefinancial as ACCOUNTINGDATE,
	'ANDE-' + j.ORDERACCOUNT as CUSTOMERNO,
	'ANDE-' + t.ITEMID as ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' ') as DELIVERYCOUNTRYID,
	ISNULL(i.packingslipid,' ') as PACKINGSLIPID,
	t.QTY as QTY,
	t.LINEAMOUNTMST as PRODUCTSALESLOCAL,
	t.LINEAMOUNTMST as PRODUCTSALESEUR,
	0 as OTHERSALESLOCAL,
	0 as OTHERSALESEUR,
	t.LINEAMOUNTMST * [intm_axbi].[uf_get_CashDiscPct](u.CASHDISC) / 100 * (-1) as ALLOWANCESLOCAL,
	t.LINEAMOUNTMST * [intm_axbi].[uf_get_CashDiscPct](u.CASHDISC) / 100 * (-1) as ALLOWANCESEUR,
	0 as SALES100LOCAL, -- Sales 100 für Ancon DE später addieren
	0 as SALES100EUR,
	t.LINEAMOUNTMST * 0.034 * (-1) as FREIGHTLOCAL, -- Interne Fracht 3,4 %
	t.LINEAMOUNTMST * 0.034 * (-1) as FREIGHTEUR,
	i.costamount as COSTAMOUNTLOCAL,
	i.costamount as COSTAMOUNTEUR,
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTTABLE] as u
	on LOWER(t.DATAAREAID) = LOWER(u.DATAAREAID) and
	   t.INVOICEACCOUNT = u.ACCOUNTNUM
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on LOWER(t.DATAAREAID) = LOWER(j.DATAAREAID)
	and t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANDE as i
	on LOWER(t.DATAAREAID) = LOWER(i.DATAAREAID) 
	and t.INVOICEID = i.INVOICEID 
	and t.INVENTTRANSID = i.INVENTTRANSID
	where LOWER(t.DATAAREAID) = 'ande' 
	and Datepart(yyyy, i.datefinancial) = @P_Year
	and Datepart(mm, i.datefinancial) = @P_Month
	and t.ITEMID not in ('DIENST', 'FRACHT', 'MINDERMENGE', 'POSZU') 

--create temp table with other sales (obsolete cursor)
select     
    'ANDE' as DATAAREAID,
	t.ORIGSALESID as SALESID,
	t.INVOICEID as INVOICEID,
	t.LINENUM as LINENUM,
	ISNULL(t.INVENTTRANSID,' ') as INVENTTRANSID,
	i.datefinancial as ACCOUNTINGDATE,
	j.ORDERACCOUNT as CUSTOMERNO,
	t.ITEMID as ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' ') as DELIVERYCOUNTRYID,
	ISNULL(i.packingslipid,' ') as PACKINGSLIPID,
	t.QTY as QTY,
	t.LINEAMOUNTMST as LINEAMOUNTMST_os,
	count(t.INVOICEID) over (partition by t.INVOICEID) cnt_inv,
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	into #inventtrans_ANDE_OS
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on LOWER(t.DATAAREAID) = LOWER(j.DATAAREAID) 
	and t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANDE as i
	on LOWER(t.DATAAREAID) = LOWER(i.DATAAREAID)
	and t.INVOICEID = i.INVOICEID 
	and t.INVENTTRANSID = i.INVENTTRANSID
	where LOWER(t.DATAAREAID) = 'ande' 
	and Datepart(yyyy, i.datefinancial) = @P_Year
	and Datepart(mm, i.datefinancial) = @P_Month
	and t.ITEMID in ('DIENST', 'FRACHT', 'MINDERMENGE', 'POSZU')


--salesbalance calculation
	select 
	t.INVOICEID,
	ISNULL(sum(t.PRODUCTSALESLOCAL),0) salesbalance
	into #inventtrans_ANDE_SB
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join #inventtrans_ANDE_OS os
	on t.INVOICEID = os.INVOICEID 
	where upper(t.DATAAREAID) = 'ANDE' and t.ITEMID not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
	group by t.INVOICEID

--LINEAMOUNTMST sum calculation
	select INVOICEID,
	sum(LINEAMOUNTMST_os) LINEAMOUNTMST_os_sum
	into #inventtrans_ANDE_LA
	from #inventtrans_ANDE_OS
	group by INVOICEID

--lcounter calculation	
	select INVOICEID , count (*) lcounter
    into #inventtrans_ANDE_cnt
    from [intm_axbi].[fact_CUSTINVOICETRANS]
    where upper(DATAAREAID) = 'ANDE'
    and ITEMID not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
    group by INVOICEID

--update #1
update [intm_axbi].[fact_CUSTINVOICETRANS]
set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += (la.LINEAMOUNTMST_os_sum * t.PRODUCTSALESLOCAL/ sb.salesbalance) * os.cnt_inv,
    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += (la.LINEAMOUNTMST_os_sum * t.PRODUCTSALESEUR/sb.salesbalance) * os.cnt_inv
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join #inventtrans_ANDE_OS os
on t.INVOICEID  = os.INVOICEID  
inner join #inventtrans_ANDE_SB sb
on t.INVOICEID =sb.INVOICEID 
inner join #inventtrans_ANDE_LA la
on t.INVOICEID =la.INVOICEID 
where upper(t.DATAAREAID) = 'ANDE'  and t.ITEMID not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
and sb.salesbalance<>0


--update #2
update [intm_axbi].[fact_CUSTINVOICETRANS]
   set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += la.LINEAMOUNTMST_os_sum / cnt.lcounter,
	   [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += la.LINEAMOUNTMST_os_sum / cnt.lcounter
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join #inventtrans_ANDE_SB sb
on t.INVOICEID =sb.INVOICEID 
inner join #inventtrans_ANDE_LA la
on t.INVOICEID =la.INVOICEID 
inner join #inventtrans_ANDE_cnt cnt
on t.INVOICEID =cnt.INVOICEID 
where upper(t.DATAAREAID) = 'ANDE'  and t.ITEMID not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
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
	'ANDE-' + CUSTOMERNO,
	'ANDE-' + ITEMID,
	DELIVERYCOUNTRYID,
	PACKINGSLIPID,
	QTY,
	0,
	0,
	LINEAMOUNTMST_os,
	LINEAMOUNTMST_os,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	t_applicationId,
    t_jobId,
    t_jobDtm,
    t_jobBy,
    t_extractionDtm 
	from #inventtrans_ANDE_OS
	where INVOICEID  not in (select INVOICEID from [intm_axbi].[fact_CUSTINVOICETRANS]
	where upper(DATAAREAID) = 'ANDE'  and ITEMID not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU'))


--update SALES100 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	   set [intm_axbi].[fact_CUSTINVOICETRANS].SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	       [intm_axbi].[fact_CUSTINVOICETRANS].SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'ANDE' 
	and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month


-- Enter missing DUMMY delivery country
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'DE'
	where upper(DATAAREAID) = 'ANDE' and DELIVERYCOUNTRYID = ' '

--drop temp tables
drop table #inventtrans_ANDE_dup
drop table #inventtrans_ANDE
drop table #inventtrans_ANDE_OS
drop table #inventtrans_ANDE_SB
drop table #inventtrans_ANDE_LA
drop table #inventtrans_ANDE_cnt

END