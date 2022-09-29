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

    -- Insert statements for procedure here

	--  Ancon Australia 

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] 
	where DATAAREAID = 'ANAH' 
	and datepart(YYYY, ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, ACCOUNTINGDATE) = @P_Month

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
	where t.DATAAREAID = 'hlau' and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year and Datepart(mm, i.DATEFINANCIAL) = @P_Month and i.DATEFINANCIAL < convert(date, getdate())
	group by t.DATAAREAID, t.INVOICEID, t.SALESID, t.INVENTTRANSID, t.LINENUM, i.DATEFINANCIAL, i.PACKINGSLIPID; 

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
	where t.DATAAREAID = 'hlau' 
	and Datepart(yyyy, i.DATEFINANCIAL) = @P_Year 
	and Datepart(mm, i.DATEFINANCIAL) = @P_Month 
	and t.ITEMID not in ('FRA', 'MISC', 'RESTOCK')


-- other sales
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
	t.LINEAMOUNTMST lineamountmst_os,
	t.LINEAMOUNTMST / c.CRHRATE lineamounteur_os,
	count(t.invoiceid) over (partition by t.invoiceid) cnt_inv
	into #inventtrans_ANAH_OS
	from [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] as t
	inner join [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] as j
	on t.DATAAREAID = j.DATAAREAID and
	   t.INVOICEID = j.INVOICEID
	inner join #inventtrans_ANAH as i
	on t.DATAAREAID = i.DATAAREAID and
	   t.INVOICEID = i.INVOICEID and
	   t.INVENTTRANSID = i.INVENTTRANSID
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] c
	on c.year = Datepart(YYYY, i.DATEFINANCIAL) 
	and c.CURRENCY = 'AUD'
	where t.DATAAREAID = 'hlau' 
	and Datepart(yyyy, i.datefinancial) = @P_Year 
	and Datepart(mm, i.datefinancial) = @P_Month 
	and t.ITEMID in ('FRA', 'MISC', 'RESTOCK')

	--salesbalance calculation
	select 
	t.invoiceid,
	ISNULL(sum(t.productsaleslocal),0) salesbalance,
	ISNULL(sum(t.PRODUCTSALESEUR),0) salesbalanceeur,
	count(*) lcounter
	into #inventtrans_ANAH_SB
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join #inventtrans_ANAH_OS os
	on t.invoiceid COLLATE DATABASE_DEFAULT= os.invoiceid COLLATE DATABASE_DEFAULT
	where t.dataareaid = 'ANAH' and t.itemid not in ('ANAH-FRA', 'ANAH-MISC', 'ANAH-RESTOCK')
	group by t.invoiceid

	--lineamountmst sum calculation
	select invoiceid,
	sum(lineamountmst_os) lineamountmst_os_sum,
	sum(lineamounteur_os) lineamounteur_os_sum
	into #inventtrans_ANAH_LA
	from #inventtrans_ANAH_OS
	group by invoiceid


--update #1
update [intm_axbi].[fact_CUSTINVOICETRANS]
set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += (la.lineamountmst_os_sum * t.PRODUCTSALESLOCAL/ sb.salesbalance) * os.cnt_inv,
    [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += (la.lineamountmst_os_sum * t.PRODUCTSALESEUR/sb.salesbalance) * os.cnt_inv
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join #inventtrans_ANAH_OS os
on t.invoiceid  COLLATE DATABASE_DEFAULT= os.invoiceid  COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANAH_SB sb
on t.INVOICEID COLLATE DATABASE_DEFAULT=sb.INVOICEID COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANAH_LA la
on t.invoiceid COLLATE DATABASE_DEFAULT=la.invoiceid COLLATE DATABASE_DEFAULT
where t.dataareaid = 'ANAH'  and t.itemid not in ('ANAH-FRA', 'ANAH-MISC', 'ANAH-RESTOCK')
and sb.salesbalance<>0


--update #2
update [intm_axbi].[fact_CUSTINVOICETRANS]
   set [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESLOCAL += la.lineamountmst_os_sum / sb.lcounter,
	   [intm_axbi].[fact_CUSTINVOICETRANS].OTHERSALESEUR   += la.lineamountmst_os_sum / sb.lcounter
from [intm_axbi].[fact_CUSTINVOICETRANS] as t
inner join #inventtrans_ANAH_SB sb
on t.INVOICEID COLLATE DATABASE_DEFAULT=sb.INVOICEID COLLATE DATABASE_DEFAULT
inner join #inventtrans_ANAH_LA la
on t.invoiceid COLLATE DATABASE_DEFAULT=la.invoiceid COLLATE DATABASE_DEFAULT
where t.dataareaid = 'ANAH'  and t.itemid not in ('ANAH-FRA', 'ANAH-MISC', 'ANAH-RESTOCK')
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
	'ANAH-' + CUSTOMERNO,
	'ANAH-' + ITEMID,
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
	from #inventtrans_ANAH_OS
	where invoiceid COLLATE DATABASE_DEFAULT not in (select invoiceid from [intm_axbi].[fact_CUSTINVOICETRANS])

--update SALES100
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

--drop temp tables
drop table #inventtrans_ANAH
drop table #inventtrans_ANAH_OS
drop table #inventtrans_ANAH_SB
drop table #inventtrans_ANAH_LA

END