-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <15.06.2020>
-- Description:	<Übernahme Umsatzdaten Halfen Moment Singapore für TX Construction Accessories>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_HMSG_pkg] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

     declare @P_Year smallint = (select datepart(year,max([ACCOUNTINGDATE])) from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_HMSG]),
	         @P_Month tinyint = (select datepart(month,max([ACCOUNTINGDATE])) from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_HMSG])

	-- CUSTTABLE

	Delete from [base_tx_ca_0_hlp].[CUSTTABLE_HMSG] where ACCOUNTNUM is Null;

	update [base_tx_ca_0_hlp].[CUSTTABLE_HMSG]
	set CUSTOMERPILLAR = case a.CUSTOMERPILLAR
	                        when 'Precasters' then 'PRECAST'
	                        when 'Industrials' then 'INDUSTRIAL'
	                        when 'Others' then 'OTHER'
						    else 'OTHER'
						 End
	from [base_tx_ca_0_hlp].[CUSTTABLE_HMSG] as a

	-- Custtable Halfen Moment Malaysia

	delete from [intm_axbi].[dim_CUSTTABLE] where UPPER(DATAAREAID) = 'HMSG'

	insert [intm_axbi].[dim_CUSTTABLE]
    ([DATAAREAID]
    ,[ACCOUNTNUM]
    ,[NAME]
    ,[INOUT]
    ,[CUSTOMERPILLAR]
    ,[COMPANYCHAINID]
    ,[DIMENSION3_])
	select distinct
	'HMSG',
	'HMSG-' + ACCOUNTNUM,
	'HMSG-' + NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	DIMENSION3_
	from [base_tx_ca_0_hlp].[CUSTTABLE_HMSG]

	-- Alle Leviat Kunden auf Inside setzen, außer Meadow Burke. 
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where
        UPPER(DATAAREAID) = 'HMSG'
        and
        [NAME] like '%Leviat%'
        and
        [NAME] not like '%Meadow Burke%'
        and
        [NAME] not like '%MeadowBurke%'

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  UPPER(DATAAREAID) = 'HMSG' and CUSTOMERPILLAR = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where UPPER(DATAAREAID) = 'HMSG' and INOUT = 'I'

	-- ITEMTABLE

	Delete from [base_tx_ca_0_hlp].[ITEMTABLE_HMSG] where ITEMID is Null

/*	update [dbo].[ITEMTABLE_HMSG$_bulk]
	set ITEMTABLE_HMSG$_bulk.PRODUCTGROUPID = a.PRODUCTGROUPID + '.'
	from [dbo].[ITEMTABLE_HMSG$_bulk] as a */


	-- Items Halfen Moment Singapur

	delete from [intm_axbi].[dim_ITEMTABLE] where DATAAREAID = 'HMSG'

	insert [intm_axbi].[dim_ITEMTABLE]
    ([DATAAREAID]
	,[ITEMID]
	,[ITEMNAME]
	,[PRODUCTGROUPID]
	,[ITEMGROUPID])
	select distinct
	'HMSG',
	'HMSG-' + [ITEMID],
	'HMSG-' + ISNULL([ITEMNAME], ' '),
	ISNULL([PRODUCTGROUPID], ' '),
	'HMSG-' + [ITEMGROUPID]
	from [base_tx_ca_0_hlp].[ITEMTABLE_HMSG]

	-- Dummy article for the Budget
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMSG', 'HMSG-103-09XX-XX0003', 'HMSG-103-09XX-XX0003', 'N.3.', ' ')

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where UPPER(DATAAREAID) = 'HMSG' and PRODUCTGROUPID = ' '

	-- CUSTINVOICETRANS

	delete [base_tx_ca_0_hlp].[CUSTINVOICETRANS_HMSG]
    where
        DATEPART(yyyy, [ACCOUNTINGDATE]) = @P_Year
        and
        DATEPART(mm, [ACCOUNTINGDATE]) = @P_Month

	delete from [intm_axbi].[fact_CUSTINVOICETRANS]
    where
        UPPER(DATAAREAID) = 'HMSG'
        and
        DATEPART(yyyy, [ACCOUNTINGDATE]) = @P_Year
        and
        DATEPART(mm, [ACCOUNTINGDATE]) =  @P_Month 

	insert [intm_axbi].[fact_CUSTINVOICETRANS]
    ([DATAAREAID]
	,[SALESID]
	,[INVOICEID]
	,[LINENUM]
	,[INVENTTRANSID]
	,[ACCOUNTINGDATE]
	,[CUSTOMERNO]
	,[ITEMID]
	,[DELIVERYCOUNTRYID]
	,[PACKINGSLIPID]
	,[QTY]
	,[PRODUCTSALESLOCAL]
	,[PRODUCTSALESEUR]
	,[OTHERSALESLOCAL]
	,[OTHERSALESEUR]
	,[ALLOWANCESLOCAL]
	,[ALLOWANCESEUR]
	,[SALES100LOCAL]
	,[SALES100EUR]
	,[FREIGHTLOCAL]
	,[FREIGHTEUR]
	,[COSTAMOUNTLOCAL]
	,[COSTAMOUNTEUR])
	select
        'HMSG',
        '999999999999',
        a.[INVOICEID],
        a.[LINENUM],
        ' ',
        a.[ACCOUNTINGDATE],
        'HMSG-' + a.[CUSTOMERNO],
        'HMSG-' + a.[ITEMID],
        a.[DELIVERYCOUNTRYID],
        ' ',
	    a.[QTY],
        a.[PRODUCTSALESLOCAL],
        a.[PRODUCTSALESLOCAL]/b.[CRHRATE],
        a.[OTHERSALESLOCAL],
        a.[OTHERSALESLOCAL]/b.[CRHRATE],
        0,
        0,
        a.[PRODUCTSALESLOCAL] + a.[OTHERSALESLOCAL],
        a.[PRODUCTSALESLOCAL]/b.[CRHRATE] + a.[OTHERSALESLOCAL]/b.[CRHRATE],
        [FREIGHTLOCAL],
        a.[FREIGHTLOCAL]/b.[CRHRATE],
        a.[COSTAMOUNTLOCAL],
        a.[COSTAMOUNTLOCAL]/b.[CRHRATE]
	from
        [base_tx_ca_0_hlp].[CUSTINVOICETRANS_HMSG] as a
	inner join
        [base_tx_ca_0_hlp].[CRHCURRENCY] as b
	        on  b.[YEAR] = @P_Year
                and
	            b.[CURRENCY] = 'SGD'

	-- Verteilung der OTHERSALES
    select
	    [DATAAREAID],
	    [INVOICEID],
	    sum([PRODUCTSALESLOCAL]) AS [PRODUCTSALESLOCAL],
	    sum([PRODUCTSALESEUR]) AS [PRODUCTSALESEUR],
	    sum([OTHERSALESLOCAL]) AS [OTHERSALESLOCAL],
	    sum([OTHERSALESEUR]) AS [OTHERSALESEUR]
    into #OtherSalesTable
	from [intm_axbi].[fact_CUSTINVOICETRANS]
	where
        UPPER(DATAAREAID) = 'HMSG'
        and
        Datepart(yyyy, [ACCOUNTINGDATE]) = @P_Year
        and
        Datepart(mm, [ACCOUNTINGDATE]) = @P_Month
	group by [DATAAREAID], [INVOICEID] 
	order by [DATAAREAID], [INVOICEID] 

	-- Rechnungen mit Productsales und mit Othersales, Othersales auf die SalesPositionen verteilen und anschließend die Othersales Positionen löschen.

	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set OTHERSALESLOCAL = o.[OTHERSALESLOCAL] * t.PRODUCTSALESLOCAL/o.[PRODUCTSALESLOCAL],
	    OTHERSALESEUR   = o.[OTHERSALESEUR] * t.PRODUCTSALESEUR/o.[PRODUCTSALESEUR]
    from [intm_axbi].[fact_CUSTINVOICETRANS] as t
    INNER JOIN
        #OtherSalesTable o
            ON t.INVOICEID = o.INVOICEID
	where
        t.DATAAREAID = 'HMSG'
        and
        datepart(YYYY, t.[ACCOUNTINGDATE]) = @P_Year
        and
        datepart(MM, t.[ACCOUNTINGDATE]) = @P_Month
        and
        t.productsaleslocal <> 0
        and
        o.[PRODUCTSALESLOCAL] <> 0
        and
        o.[OTHERSALESLOCAL] <> 0

	delete [intm_axbi].[fact_CUSTINVOICETRANS]
    from [intm_axbi].[fact_CUSTINVOICETRANS] t
    INNER JOIN 
        #OtherSalesTable o
            ON t.INVOICEID = o.INVOICEID
	where
        UPPER(t.DATAAREAID) = 'HMSG'
        and
        datepart(YYYY, t.ACCOUNTINGDATE) = @P_Year
        and
        datepart(MM, t.ACCOUNTINGDATE) = @P_Month
        and
        t.ProductSalesLocal = 0
        and
        t.OtherSalesLocal <> 0
        and
        o.[PRODUCTSALESLOCAL] <> 0
        and
        o.[OTHERSALESLOCAL] <> 0

	-- SALES100 neu aufbauen
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set SALES100LOCAL = ISNULL(i.PRODUCTSALESLOCAL,0) + ISNULL(i.OTHERSALESLOCAL,0) + ISNULL(i.ALLOWANCESLOCAL,0),
	    SALES100EUR   = ISNULL(i.PRODUCTSALESEUR,0) + ISNULL(i.OTHERSALESEUR,0) + ISNULL(i.ALLOWANCESEUR,0)
	from [intm_axbi].[fact_CUSTINVOICETRANS] as i
	where i.DATAAREAID = 'HMSG' and datepart(YYYY, i.ACCOUNTINGDATE) = @P_Year and datepart(MM, i.ACCOUNTINGDATE) = @P_Month

	-- Fehlendes DUMMY Lieferland eintragen 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'MY'
	where DATAAREAID = 'HMSG' and DELIVERYCOUNTRYID = ' '

    drop table #OtherSalesTable

END
