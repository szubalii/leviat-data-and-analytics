CREATE PROCEDURE [intm_axbi].[up_ReadSales_ANDE] 
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
#inventtrans_ANDE
from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
    on t.DATAAREAID = j.DATAAREAID 
   and t.INVOICEID = j.INVOICEID
inner join [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTRANS] as i
	on t.DATAAREAID = i.DATAAREAID 
   and t.INVOICEID = i.INVOICEID 
   and t.INVENTTRANSID = i.INVENTTRANSID
	where t.DATAAREAID = 'ande' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month
	group by t.DATAAREAID, t.INVOICEID, t.ORIGSALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID;


--remove duplicates, non-determenistic set
	WITH CTE_inventtrans AS
	(
		SELECT dataareaid, invoiceid, origsalesid, inventtransid, linenum, ROW_NUMBER() 
		OVER(PARTITION BY dataareaid, invoiceid, origsalesid, inventtransid, linenum 
			ORDER BY dataareaid, invoiceid, origsalesid, inventtransid, linenum ) RowNumber
		FROM #inventtrans_ANDE
	)
	DELETE FROM CTE_inventtrans WHERE RowNumber > 1


--insert main sales
insert [intm_axbi].[fact_CUSTINVOICETRANS]
	select
    'ANDE' as DATAAREAID,
	t.origsalesid as SALESID,
	t.invoiceid as INVOICEID,
	t.linenum as LINENUM,
	ISNULL(t.inventtransid,' ') as INVENTTRANSID,
	i.datefinancial as ACCOUNTINGDATE,
	'ANDE-' + j.orderaccount as CUSTOMERNO,
	'ANDE-' + t.itemid as ITEMID,
	ISNULL(t.dlvcountryregionid,' ') as DELIVERYCOUNTRYID,
	ISNULL(i.packingslipid,' ') as PACKINGSLIPID,
	t.qty as QTY,
	t.lineamountmst as PRODUCTSALESLOCAL,
	t.lineamountmst as PRODUCTSALESEUR,
	0 as OTHERSALESLOCAL,
	0 as OTHERSALESEUR,
	t.lineamountmst * [intm_axbi].[uf_get_CashDiscPct](u.cashdisc) / 100 * (-1) as ALLOWANCESLOCAL,
	t.lineamountmst * [intm_axbi]..[uf_get_CashDiscPct](u.cashdisc) / 100 * (-1) as ALLOWANCESEUR,
	0 as SALES100LOCAL, -- Sales 100 für Ancon DE später addieren
	0 as SALES100EUR,
	t.lineamountmst * 0.034 * (-1) as FREIGHTLOCAL, -- Interne Fracht 3,4 %
	t.lineamountmst * 0.034 * (-1) as FREIGHTEUR,
	i.costamount as COSTAMOUNTLOCAL,
	i.costamount as COSTAMOUNTEUR
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTTABLE] as u
	on t.DATAAREAID = u.DATAAREAID and
	   t.INVOICEACCOUNT = u.ACCOUNTNUM
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID 
	and t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANDE as i
	on t.dataareaid = i.dataareaid and
	   t.invoiceid = i.invoiceid and
	   t.inventtransid = i.inventtransid
	where t.dataareaid = 'ande' 
	and Datepart(yyyy, i.datefinancial) = @P_Year 
	and Datepart(mm, i.datefinancial) = @P_Month 
	and t.itemid not in ('DIENST', 'FRACHT', 'MINDERMENGE', 'POSZU') 


--create temp table with other sales (obsolete cursor)
select     
    'ANDE' as DATAAREAID,
	t.origsalesid as SALESID,
	t.invoiceid as INVOICEID,
	t.linenum as LINENUM,
	ISNULL(t.inventtransid,' ') as INVENTTRANSID,
	i.datefinancial as ACCOUNTINGDATE,
	j.orderaccount as CUSTOMERNO,
	t.itemid as ITEMID,
	ISNULL(t.dlvcountryregionid,' ') as DELIVERYCOUNTRYID,
	ISNULL(i.packingslipid,' ') as PACKINGSLIPID,
	t.qty as QTY,
	t.lineamountmst as lineamountmst_os,
	count(t.invoiceid) over (partition by t.invoiceid) cnt_inv
	into #inventtrans_ANDE_OS
	from [base_tx_crh_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANDE as i
	on t.dataareaid = i.dataareaid and
	   t.invoiceid = i.invoiceid and
	   t.inventtransid = i.inventtransid
	where t.dataareaid = 'ande' 
	and Datepart(yyyy, i.datefinancial) = @P_Year 
	and Datepart(mm, i.datefinancial) = @P_Month 
	and t.itemid in ('DIENST', 'FRACHT', 'MINDERMENGE', 'POSZU')


--salesbalance calculation
	select 
	t.invoiceid,
	ISNULL(sum(t.productsaleslocal),0) salesbalance,
	count(*) lcounter
	into #inventtrans_ANDE_SB
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join #inventtrans_ANDE_OS os
	on t.invoiceid COLLATE DATABASE_DEFAULT= os.invoiceid COLLATE DATABASE_DEFAULT
	where t.dataareaid = 'ANDE' and t.itemid not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
	group by t.invoiceid

--lineamountmst sum calculation
	select invoiceid,
	sum(lineamountmst_os) lineamountmst_os_sum
	into #inventtrans_ANDE_LA
	from #inventtrans_ANDE_OS
	group by invoiceid


--update #1
update [intm_axbi].[fact_CUSTINVOICETRANS]
set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += (la.lineamountmst_os_sum * t.PRODUCTSALESLOCAL/ sb.salesbalance) * os.cnt_inv,
    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += (la.lineamountmst_os_sum * t.PRODUCTSALESEUR/sb.salesbalance) * os.cnt_inv
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join #inventtrans_ANDE_OS os
on t.invoiceid  COLLATE DATABASE_DEFAULT= os.invoiceid  COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANDE_SB sb
on t.INVOICEID COLLATE DATABASE_DEFAULT=sb.INVOICEID COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANDE_LA la
on t.invoiceid COLLATE DATABASE_DEFAULT=la.invoiceid COLLATE DATABASE_DEFAULT
where t.dataareaid = 'ANDE'  and t.itemid not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
and sb.salesbalance<>0


--update #2
update [intm_axbi].[fact_CUSTINVOICETRANS]
   set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += la.lineamountmst_os_sum / sb.lcounter,
	   [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += la.lineamountmst_os_sum / sb.lcounter
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join #inventtrans_ANDE_SB sb
on t.INVOICEID COLLATE DATABASE_DEFAULT=sb.INVOICEID COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANDE_LA la
on t.invoiceid COLLATE DATABASE_DEFAULT=la.invoiceid COLLATE DATABASE_DEFAULT
where t.dataareaid = 'ANDE'  and t.itemid not in ('ANDE-DIENST', 'ANDE-FRACHT', 'ANDE-MINDERMENGE', 'ANDE-POSZU')
and lcounter>0
and salesbalance = 0


--insert for other sales
insert [intm_axbi].[fact_CUSTINVOICETRANS]
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
	lineamountmst_os,
	lineamountmst_os,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
	from #inventtrans_ANDE_OS
	where invoiceid COLLATE DATABASE_DEFAULT not in (select invoiceid from [intm_axbi].[fact_CUSTINVOICETRANS])


--update SALES100 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	   set [intm_axbi].[fact_CUSTINVOICETRANS].SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	       [intm_axbi].[fact_CUSTINVOICETRANS].SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where c.DATAAREAID = 'ANDE' 
	and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year 
	and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month


-- Enter missing DUMMY delivery country
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'DE'
	where DATAAREAID = 'ANDE' and DELIVERYCOUNTRYID = ' '

--drop temp tables
drop table #inventtrans_ANDE
drop table #inventtrans_ANDE_OS
drop table #inventtrans_ANDE_SB
drop table #inventtrans_ANDE_LA

END