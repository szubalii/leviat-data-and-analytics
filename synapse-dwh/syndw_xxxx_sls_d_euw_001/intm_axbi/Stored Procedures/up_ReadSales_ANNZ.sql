-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <09.08.2019>
-- Description:	<Ermitteln Sales Ancon New Zealand>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_ANNZ] 
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

    -- Insert statements for procedure here

	--  Ancon New Zealand 
    IF OBJECT_ID(N'tempdb..#inventtrans_ANNZ_dup') IS NOT NULL
    BEGIN
        DROP TABLE #inventtrans_ANNZ_dup
    END 

    IF OBJECT_ID(N'tempdb..#inventtrans_ANNZ') IS NOT NULL
    BEGIN
        DROP TABLE #inventtrans_ANNZ
    END  

    IF OBJECT_ID(N'tempdb..#inventtrans_ANNZ_OS') IS NOT NULL
    BEGIN
        DROP TABLE #inventtrans_ANNZ_OS
    END  

    IF OBJECT_ID(N'tempdb..#inventtrans_ANNZ_SB') IS NOT NULL
    BEGIN
        DROP TABLE #inventtrans_ANNZ_SB
    END  

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where DATAAREAID = 'ANNZ' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and datepart(MM, ACCOUNTINGDATE) = @P_Month

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
	into #inventtrans_ANNZ_dup
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join [base_ancon_australia_2_dwh].[FACT_INVENTTRANS] as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'hlnz' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and i.DATEFINANCIAL < convert(date, getdate())
	group by t.DATAAREAID, t.INVOICEID, t.SALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID; 

	-- Doppelte Sätze löschen. Geht leider ein Datefinancial und eine PackingslipID verloren, dafür werden die Zahlen richtig.
	-- Obwohl wir in der COMMON TABLE EXPRESSION table löschen, werden die doppelten Sätze in der temporären Tabelle #inventtrans_ANNZ gelöscht.
	SELECT 
    DATAAREAID, 
	INVOICEID, 
	SALESID, 
	INVENTTRANSID, 
	LINENUM, 
	DATEFINANCIAL, 
	PACKINGSLIPID, 
    COSTAMOUNTPOSTED,  
	COSTAMOUNTADJUSTMENT
	into #inventtrans_ANNZ
	FROM 
	(SELECT 
	DATAAREAID, 
	INVOICEID, 
	SALESID, 
	INVENTTRANSID, 
	LINENUM, 
	DATEFINANCIAL, 
	PACKINGSLIPID, 
    COSTAMOUNTPOSTED,  
	COSTAMOUNTADJUSTMENT,
	ROW_NUMBER() 
		OVER(PARTITION BY DATAAREAID, INVOICEID, SALESID, INVENTTRANSID, LINENUM 
			ORDER BY DATAAREAID, INVOICEID, SALESID, INVENTTRANSID, LINENUM ) RowNumber
	from #inventtrans_ANNZ_dup
	) d
	where d.RowNumber=1
	

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
	'ANNZ',
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' '),
	i.DATEFINANCIAL,
	'ANNZ-' + j.ORDERACCOUNT,
	'ANNZ-' + t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' '),
	ISNULL(i.PACKINGSLIPID,' '),
	t.QTY,
	t.LINEAMOUNTMST,
	t.LINEAMOUNTMST / c.CRHRATE,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)), -- Sales 100 für Ancon NZ später addieren
	CAST(0 as [DECIMAL](38, 12)),
	t.LINEAMOUNTMST * 0.025 * (-1), -- Interne Fracht 2,5 %
	t.LINEAMOUNTMST * 0.025 * (-1) / c.CRHRATE,
	i.COSTAMOUNTPOSTED + i.COSTAMOUNTADJUSTMENT,
	(i.COSTAMOUNTPOSTED + i.COSTAMOUNTADJUSTMENT) / c.CRHRATE,
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANNZ as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] as c
	on Datepart(YYYY, i.DATEFINANCIAL) = c.YEAR and
	   'NZD' = c.CURRENCY
	where lower(t.DATAAREAID) = 'hlnz' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month 
	and t.ITEMID not in ('FRA', 'FRU') -- HIRE TOOL, HIRE RETURN?


-- other sales
select 
	'ANNZ' as DATAAREAID,
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
	t.LINEAMOUNTMST lineamountmst_os,
	t.LINEAMOUNTMST / c.CRHRATE lineamounteur_os,
	--,count(t.INVOICEID) over (partition by t.INVOICEID) cnt_inv
	t.t_applicationId as t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t.t_extractionDtm as t_extractionDtm
	into #inventtrans_ANNZ_OS
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANNZ as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] c
	on c.YEAR = Datepart(YYYY, i.DATEFINANCIAL) 
	and c.CURRENCY = 'NZD'
	where lower(t.DATAAREAID) = 'hlnz' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	and t.ITEMID in ('FRA', 'FRU')


--salesbalance calculation
	select 
	t.INVOICEID,
	ISNULL(sum(t.PRODUCTSALESLOCAL),0) salesbalance,
	ISNULL(sum(t.PRODUCTSALESEUR),0) salesbalanceeur,
    count (*) lcounter
	into #inventtrans_ANNZ_SB
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	--inner join #inventtrans_ANNZ_OS os
	--on t.INVOICEID = os.INVOICEID 
	where upper(t.DATAAREAID) = 'ANNZ' 
	and t.ITEMID not in ('ANNZ-FRA', 'ANNZ-FRU')
	group by t.INVOICEID;


--lineamountmst sum calculation
	-- select INVOICEID,
	-- sum(lineamountmst_os) lineamountmst_os_sum,
	-- sum(lineamounteur_os) lineamounteur_os_sum
	-- into #inventtrans_ANNZ_LA
	-- from #inventtrans_ANNZ_OS
	-- group by INVOICEID
	
--lcounter calculation	
	-- select INVOICEID, 
	-- count (*) lcounter
    -- into #inventtrans_ANNZ_cnt
    -- from [intm_axbi].[fact_CUSTINVOICETRANS]
    -- where upper(DATAAREAID) = 'ANNZ'
    -- and ITEMID not in ('ANNZ-FRA', 'ANNZ-FRU')
    -- group by INVOICEID


--update #1
-- update [intm_axbi].[fact_CUSTINVOICETRANS]
-- set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += (la.lineamountmst_os_sum * t.PRODUCTSALESLOCAL/ sb.salesbalance) * os.cnt_inv,
--     [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += (la.lineamounteur_os_sum * t.PRODUCTSALESEUR/sb.salesbalanceeur) * os.cnt_inv
-- from [intm_axbi].[fact_CUSTINVOICETRANS] as t
-- inner join #inventtrans_ANNZ_OS os
-- on t.INVOICEID  = os.INVOICEID  
-- inner join #inventtrans_ANNZ_SB sb
-- on t.INVOICEID =sb.INVOICEID 
-- inner join #inventtrans_ANNZ_LA la
-- on t.INVOICEID =la.INVOICEID 
-- where upper(t.DATAAREAID) = 'ANNZ' 
-- and t.ITEMID not in ('ANNZ-FRA', 'ANNZ-FRU')
-- and sb.salesbalance<>0

WITH PCC AS (
		SELECT t.SALESID
			,t.INVOICEID
			,t.LINENUM
			,SUM(os.lineamountmst_os * t.PRODUCTSALESLOCAL/ sb.salesbalance)  as l_sum
	    	,SUM(os.lineamounteur_os * t.PRODUCTSALESEUR/sb.salesbalance) as e_sum
        from [intm_axbi].[fact_CUSTINVOICETRANS] as t
        inner join #inventtrans_ANNZ_OS os
        on t.INVOICEID  = os.INVOICEID  
        inner join #inventtrans_ANNZ_SB sb
        on t.INVOICEID =sb.INVOICEID 
        where upper(t.DATAAREAID) = 'ANNZ' 
        and t.ITEMID not in ('ANNZ-FRA', 'ANNZ-FRU')
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
-- update [intm_axbi].[fact_CUSTINVOICETRANS]
--    set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += la.lineamountmst_os_sum / cnt.lcounter,
-- 	   [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += la.lineamounteur_os_sum / cnt.lcounter
-- from [intm_axbi].[fact_CUSTINVOICETRANS] as t
-- inner join #inventtrans_ANNZ_SB sb
-- on t.INVOICEID =sb.INVOICEID 
-- inner join #inventtrans_ANNZ_LA la
-- on t.INVOICEID =la.INVOICEID 
-- inner join #inventtrans_ANNZ_cnt cnt
-- on t.INVOICEID =cnt.INVOICEID 
-- where upper(t.DATAAREAID) = 'ANNZ' 
-- and t.ITEMID not in ('ANNZ-FRA', 'ANNZ-FRU')
-- and sb.salesbalance = 0

WITH PCC AS (
		SELECT t.SALESID
			,t.INVOICEID
			,t.LINENUM
			,SUM(os.lineamountmst_os / sb.lcounter) as l_sum
	    	,SUM(os.lineamounteur_os / sb.lcounter) as e_sum
    	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
        inner join #inventtrans_ANNZ_OS os
        on t.INVOICEID  = os.INVOICEID  
        inner join #inventtrans_ANNZ_SB sb
        on t.INVOICEID =sb.INVOICEID 
        where upper(t.DATAAREAID) = 'ANNZ' 
        and t.ITEMID not in ('ANNZ-FRA', 'ANNZ-FRU')
        and sb.salesbalance = 0
        and sb.lcounter>0
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
	'ANNZ-' + CUSTOMERNO,
	'ANNZ-' + ITEMID,
	DELIVERYCOUNTRYID,
	PACKINGSLIPID,
	QTY,
	CAST(0 as [DECIMAL](38, 12)),
	CAST(0 as [DECIMAL](38, 12)),
	lineamountmst_os,
	lineamounteur_os,
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
	from #inventtrans_ANNZ_OS
	where INVOICEID  not in (select INVOICEID from [intm_axbi].[fact_CUSTINVOICETRANS]
	where upper(DATAAREAID) = 'ANNZ' 
    and ITEMID not in ('ANNZ-FRA', 'ANNZ-FRU'))


	-- SALES100 aufbauen
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    [intm_axbi].[fact_CUSTINVOICETRANS].SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'ANNZ' and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month
	
	-- update deliverycountryregion = NZ, if ' '
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'NZ'
	where upper(DATAAREAID) = 'ANNZ' and DELIVERYCOUNTRYID = ' ' and Datepart(yyyy, ACCOUNTINGDATE) = @P_Year and Datepart(mm, ACCOUNTINGDATE) = @P_Month

--drop temp tables
drop table #inventtrans_ANNZ_dup
drop table #inventtrans_ANNZ
drop table #inventtrans_ANNZ_OS
drop table #inventtrans_ANNZ_SB
--drop table #inventtrans_ANNZ_LA
--drop table #inventtrans_ANNZ_cnt


END