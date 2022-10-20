-- =============================================
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
	into #inventtrans_ANAU_dup
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join [base_ancon_australia_2_dwh].[FACT_INVENTTRANS] as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	where lower(t.DATAAREAID) = 'anau' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and i.DATEFINANCIAL < convert(date, getdate())
	group by t.DATAAREAID, t.INVOICEID, t.SALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID; 

	-- Doppelte Sätze löschen. Geht leider ein DATEFINANCIAL und eine PACKINGSLIPID verloren, dafür werden die Zahlen richtig.
	-- Obwohl wir in der COMMON TABLE EXPRESSION table löschen, werden die doppelten Sätze in der temporären Tabelle #inventtrans_ANAH gelöscht.
	
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
	into #inventtrans_ANAU
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
	from #inventtrans_ANAU_dup
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
    ,COSTAMOUNTEUR)
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
	t.LINEAMOUNTMST / c.CRHRATE * 0.036 * (-1),
	i.COSTAMOUNTPOSTED + i.COSTAMOUNTADJUSTMENT,
	(i.COSTAMOUNTPOSTED + i.COSTAMOUNTADJUSTMENT) / c.CRHRATE
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANAU as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] as c
	on Datepart(YYYY, i.DATEFINANCIAL) = c.YEAR and
	   'AUD' = c.CURRENCY
	where lower(t.DATAAREAID) = 'anau' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month 
	and t.ITEMID not in ('AIR', 'DHL', 'FRA', 'FRA1KG', 'FRA3KG', 'FRA5KG', 'MISC')

	-- ANCON AUSTRALIA Customer Bonus nach Allowances übertragen 

	-- customer 2,00 %
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESLOCAL += i.PRODUCTSALESLOCAL * 0.0200 * -1,
	    [intm_axbi].[fact_CUSTINVOICETRANS].ALLOWANCESEUR   += i.PRODUCTSALESEUR   * 0.0200 * -1
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'ANAU' and c.ACCOUNTNUM in ('ANAU-3865', 'ANAU-4063', 'ANAU-4128', 'ANAU-8381') and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

--create temp table with other sales (obsolete cursor)

	select 
	'ANAU' as DATAAREAID,
	t.ORIGSALESID,
	t.INVOICEID,
	t.LINENUM,
	ISNULL(t.INVENTTRANSID,' ') as INVENTTRANSID,
	i.DATEFINANCIAL as ACCOUNTINGDATE,
	j.ORDERACCOUNT as CUSTOMERNO,
	t.ITEMID,
	ISNULL(t.DLVCOUNTRYREGIONID,' ') as DELIVERYCOUNTRYID,
	i.PACKINGSLIPID as PACKINGSLIPID,
	t.QTY,
	t.LINEAMOUNTMST lineamountmst_os,
	t.LINEAMOUNTMST / c.CRHRATE lineamounteur_os,
	count(t.INVOICEID) over (partition by t.INVOICEID) cnt_inv
	into #inventtrans_ANAU_OS
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on lower(t.DATAAREAID) = lower(j.DATAAREAID) and
	   t.INVOICEID = j.INVOICEID
	inner join [base_ancon_australia_2_dwh].[FACT_INVENTTRANS] as i
	on lower(t.DATAAREAID) = lower(i.DATAAREAID) and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] c
	on c.YEAR = Datepart(YYYY, i.DATEFINANCIAL) 
	and c.CURRENCY = 'AUD'
	where lower(t.DATAAREAID) = 'anau' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month 
	and t.ITEMID in ('AIR', 'DHL', 'FRA', 'FRA1KG', 'FRA3KG', 'FRA5KG', 'MISC')

	--salesbalance calculation
	select 
	t.INVOICEID,
	ISNULL(sum(t.PRODUCTSALESLOCAL),0) salesbalance,
	ISNULL(sum(t.PRODUCTSALESEUR),0) salesbalanceeur
	into #inventtrans_ANAU_SB
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join #inventtrans_ANAU_OS os
	on t.INVOICEID COLLATE DATABASE_DEFAULT= os.INVOICEID COLLATE DATABASE_DEFAULT
	where upper(t.DATAAREAID) = 'ANAU' 
	and t.ITEMID not in ('ANAU-AIR', 'ANAU-DHL', 'ANAU-FRA', 'ANAU-FRA1KG', 'ANAU-FRA3KG', 'ANAU-FRA5KG', 'ANAU-MISC')
	group by t.INVOICEID


--lineamountmst sum calculation
	select INVOICEID,
	sum(lineamountmst_os) lineamountmst_os_sum,
	sum(lineamounteur_os) lineamounteur_os_sum
	into #inventtrans_ANAU_LA
	from #inventtrans_ANAU_OS
	group by INVOICEID
	
--lcounter calculation	
	select INVOICEID , count (*) lcounter
    into #inventtrans_ANAU_cnt
    from [intm_axbi].[fact_CUSTINVOICETRANS]
    where upper(DATAAREAID) = 'ANAU'
    and ITEMID not in ('ANAU-AIR', 'ANAU-DHL', 'ANAU-FRA', 'ANAU-FRA1KG', 'ANAU-FRA3KG', 'ANAU-FRA5KG', 'ANAU-MISC')
    group by INVOICEID


--update #1
update [intm_axbi].[fact_CUSTINVOICETRANS]
set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += (la.lineamountmst_os_sum * t.PRODUCTSALESLOCAL/ sb.salesbalance) * os.cnt_inv,
    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += (la.lineamountmst_os_sum * t.PRODUCTSALESEUR/sb.salesbalance) * os.cnt_inv
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join #inventtrans_ANAU_OS os
on t.INVOICEID  COLLATE DATABASE_DEFAULT= os.INVOICEID  COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANAU_SB sb
on t.INVOICEID COLLATE DATABASE_DEFAULT=sb.INVOICEID COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANAU_LA la
on t.INVOICEID COLLATE DATABASE_DEFAULT=la.INVOICEID COLLATE DATABASE_DEFAULT
where upper(t.DATAAREAID) = 'ANAU' 
and t.ITEMID not in ('ANAU-AIR', 'ANAU-DHL', 'ANAU-FRA', 'ANAU-FRA1KG', 'ANAU-FRA3KG', 'ANAU-FRA5KG', 'ANAU-MISC')
and sb.salesbalance<>0


--update #2
update [intm_axbi].[fact_CUSTINVOICETRANS]
   set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += la.lineamountmst_os_sum / cnt.lcounter,
	   [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += la.lineamounteur_os_sum / cnt.lcounter
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join #inventtrans_ANAU_SB sb
on t.INVOICEID COLLATE DATABASE_DEFAULT=sb.INVOICEID COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANAU_LA la
on t.INVOICEID COLLATE DATABASE_DEFAULT=la.INVOICEID COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANAU_cnt cnt
on t.INVOICEID COLLATE DATABASE_DEFAULT=cnt.INVOICEID COLLATE DATABASE_DEFAULT
where upper(t.DATAAREAID) = 'ANAU'
and t.ITEMID not in ('ANAU-AIR', 'ANAU-DHL', 'ANAU-FRA', 'ANAU-FRA1KG', 'ANAU-FRA3KG', 'ANAU-FRA5KG', 'ANAU-MISC')
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
   ,COSTAMOUNTEUR)
	select
	DATAAREAID,
	ORIGSALESID,
	INVOICEID,
	LINENUM,
	INVENTTRANSID,
	ACCOUNTINGDATE,
	'ANAU-' + CUSTOMERNO,
	'ANAU-' + ITEMID,
	DELIVERYCOUNTRYID,
	PACKINGSLIPID,
	QTY,
	0,
	0,
	lineamountmst_os,
	lineamounteur_os,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
	from #inventtrans_ANAU_OS
	where INVOICEID COLLATE DATABASE_DEFAULT not in (select INVOICEID from [intm_axbi].[fact_CUSTINVOICETRANS]
	where upper(DATAAREAID) = 'ANAU'
    and ITEMID not in ('ANAU-AIR', 'ANAU-DHL', 'ANAU-FRA', 'ANAU-FRA1KG', 'ANAU-FRA3KG', 'ANAU-FRA5KG', 'ANAU-MISC'))

	-- SALES100 aufbauen
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    [intm_axbi].[fact_CUSTINVOICETRANS].SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where upper(c.DATAAREAID) = 'ANAU' and Datepart(yyyy, i.ACCOUNTINGDATE) = @P_Year and Datepart(mm, i.ACCOUNTINGDATE) = @P_Month

	-- update deliverycountryregion = AU, if ' '
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'AU'
	where upper(DATAAREAID) = 'ANAU' and DELIVERYCOUNTRYID = ' ' and Datepart(yyyy, ACCOUNTINGDATE) = @P_Year and Datepart(mm, ACCOUNTINGDATE) = @P_Month

--drop temp tables
drop table #inventtrans_ANAU_dup
drop table #inventtrans_ANAU
drop table #inventtrans_ANAU_OS
drop table #inventtrans_ANAU_SB
drop table #inventtrans_ANAU_LA
drop table #inventtrans_ANAU_cnt


END