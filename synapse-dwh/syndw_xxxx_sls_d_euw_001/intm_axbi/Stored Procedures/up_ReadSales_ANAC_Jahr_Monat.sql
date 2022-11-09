-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <13.08.2019>
-- Description:	<Ermitteln Umsatz für Ancon CONOLLY Australia>
-- =============================================
--
-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <10.08.2021>
-- Description:	<TOM Dashboard: Ancon Australia Connolly Load Customer, Article and Sales Data from ANAC working SQL tables.>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_ANAC_Jahr_Monat]
	-- Add the parameters for the stored procedure here

		@P_Year smallint, -- Current Year of Sales Data
		@P_Month smallint -- Current Month of Sales Data
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	-- Customer Master Data ---------------------------------------------------------------------------------------------------------------------------

	-- delete/insert Ancon Australia CONNOLLY customer master data from working table CUSTTABLE_ANAC$_bulk into TOM dashboard customer master CUSTTABLE
	delete from [intm_axbi].[fact_CUSTINVOICETRANS] 
	where DATAAREAID = 'ANAC' 
	and datepart(YYYY, ACCOUNTINGDATE) = @P_Year 
	and datepart(MM, ACCOUNTINGDATE) = @P_Month

    delete from [intm_axbi].[dim_CUSTTABLE] 
    where upper(DATAAREAID) = 'ANAK'

	insert [intm_axbi].[dim_CUSTTABLE]
    ([DATAAREAID]
    ,[ACCOUNTNUM]
    ,[NAME]
    ,[INOUT]
    ,[CUSTOMERPILLAR]
    ,[COMPANYCHAINID]
    ,[DIMENSION3_])
	select distinct
	DATAAREAID,
	'ANAC-' + CAST(ACCOUNTNUM as nvarchar), -- To identify the Leviat's company customer 
	[NAME],
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' '
	from [base_ancon_conolly_aus].[CUSTTABLE_ANAC]

	-- Identification Leviat Inside Customers and set column INOUT = I for Inside Customer for the purpose to identify Leviat Inside Sales.
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where upper([DATAAREAID]) = 'ANAC' and  substring([NAME], 1, 5) = 'Ancon'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where upper([DATAAREAID]) = 'ANAC' and  substring([NAME], 1, 5) = 'Plaka'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where upper([DATAAREAID]) = 'ANAC' and  substring([NAME], 1, 6) = 'Halfen'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where upper([DATAAREAID]) = 'ANAC' and  [NAME] like '%Aschwanden%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where upper([DATAAREAID]) = 'ANAC' and  [NAME] like '%Helifix (Australia)%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where  
        upper([DATAAREAID]) = 'ANAC' 
        and
        [NAME] like '%Leviat%'
        and
        [NAME] not like '%Meadow Burke%'
        and
        [NAME] not like '%MeadowBurke%'

	-- Customer Master Data standard corrections:

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind.
	update [intm_axbi].[dim_CUSTTABLE]
	set [CUSTOMERPILLAR] = 'Other'
	where upper([DATAAREAID]) = 'ANAC' and [CUSTOMERPILLAR] = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set [CUSTOMERPILLAR] = 'Other'
	where upper([DATAAREAID]) = 'ANAC' and [INOUT] = 'I' 

	-- Item Master Data ---------------------------------------------------------------------------------------------------------------------------

	-- delete/insert Ancon Australia CONNOLLY item master data from working table ITEMTABLE_ANAC$_bulk into TOM dashboard item master ITEMTABLE
	delete from [intm_axbi].[dim_ITEMTABLE]
    where upper([DATAAREAID]) = 'ANAC'

	insert [intm_axbi].[dim_ITEMTABLE]
    ([DATAAREAID]
	,[ITEMID]
	,[ITEMNAME]
	,[PRODUCTGROUPID]
	,[ITEMGROUPID])
	select distinct
	[DATAAREAID],
	'ANAC-' + [ITEMID], -- To identify the Leviat's company item
	ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '), -- CRH PRODUCTGROUP, the higher level is PRODUCTPILLAR
	ISNULL('ANAC-' + Cast([STOCKGROUP] as nvarchar(2)), ' ') -- Ancon Connolly Autralia local article group
	from [base_ancon_conolly_aus].[ITEMTABLE_ANAC]

	-- Manual item inserts:

	-- Dummy article for the Budget
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANAC', 'ANAC-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	-- Insert of sales items, where the item is missing in the item master table
	insert [intm_axbi].[dim_ITEMTABLE]
    ([DATAAREAID]
	,[ITEMID]
	,[ITEMNAME]
	,[PRODUCTGROUPID]
	,[ITEMGROUPID])
	select distinct
	c.DATAAREAID,
	c.ITEMID,
	'Missing Article in Itemtable',
	'N.3.',
	'ANAC-0'
	from [intm_axbi].[fact_CUSTINVOICETRANS] as c
	left outer join [intm_axbi].[dim_ITEMTABLE] as i
	on UPPER(c.DATAAREAID) = UPPER(i.DATAAREAID) and
	   c.ITEMID = i.ITEMID
	where UPPER(c.DATAAREAID) = 'ANAC' and i.ITEMID is null

	-- Sales Data Ancon Connolly Australia --------------------------------------------------------------------------------------------------------

	-- delete/insert Ancon Australia CONNOLLY sales data per month from working table CUSTINVOICETRANS_ANAC$_bulk into TOM dashboard sales data table CUSTINVOICETRANS.
	delete from [intm_axbi].[fact_CUSTINVOICETRANS] 
    where 
        UPPER(DATAAREAID) = 'ANAC' 
        and
        Datepart(yyyy, ACCOUNTINGDATE) = @P_Year and Datepart(MM, ACCOUNTINGDATE) = @P_Month

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
	'ANAC',
	Case
	    When [SALESID] is Null
        then '999999'
	    else [SALESID]
    end,
	substring([INVOICEID], 1, 5), -- substring, because distribute of FREIGHT postions with another invoice suffix i.e. /02, normal invoice with suffix /01
	[LINENUM],
	' ', -- Dummy Column inventtransid
	[ACCOUNTINGDATE], -- financial booking date
	'ANAC-' + cast([CUSTOMERNO] as nvarchar), -- To identify the Leviat's company customer 
	'ANAC-' + [ITEMID], -- To identify the Leviat's company item number
	Case
	    When [DELIVERYCOUNTRYID] = 'Australia' then 'AU' -- set delivery country to ISO Code
	    When [DELIVERYCOUNTRYID] = 'New Zealand' then 'NZ'
	    When [DELIVERYCOUNTRYID] = 'Germany' then 'DE'
	    else ' '
    end,
	' ', -- Dummy Column PackingslipID
	[QTY], -- Invoiced Quantity
	[PRODUCTSALESLOCAL], -- sales amount local of article sales position
	[PRODUCTSALESEUR], -- sales amount EUR of article sales position
	0, -- othersaleslocal
	0, -- othersalesEUR
	0, -- allowanceslocal
	0, -- allowancesEUR
	0, -- sales100local, calculate later
	0, -- sales100EUR, calculate later
	[FREIGHTLOCAL], -- internal freight local, no consider
	[FREIGHTEUR], -- internal freight EUR, no consider
	[COSTAMOUNTLOCAL], -- costamountlocal, no consider
	[COSTAMOUNTEUR] -- costamountEUR, no consider
	from [base_ancon_conolly_aus].[CUSTINVOICETRANS_ANAC]
	where
        UPPER(DATAAREAID) = 'ANAC'
        and
        Datepart(yyyy, [ACCOUNTINGDATE]) = @P_Year
        and
        Datepart(MM, [ACCOUNTINGDATE]) = @P_Month
        and
        [ITEMID] not in ('ADMIN', 'FREIGHT') 

	-- Read sales positions with item number ADMIN and FREIGHT from working table CUSTINVOICETRANS_ANAC$_bulk into the SQL cursor 
	select 'ANAC' AS [DATAAREAID],
	[SALESID],
	substring([INVOICEID], 1, 5) AS [INVOICEID],
	[LINENUM],
	[ACCOUNTINGDATE],
	cast([CUSTOMERNO] as nvarchar) AS [CUSTOMETNO],
	[ITEMID],
	Case
	    When [DELIVERYCOUNTRYID] = 'Australia' then 'AU'
	    When [DELIVERYCOUNTRYID] = 'New Zealand' then 'NZ'
	    When [DELIVERYCOUNTRYID] = 'Germany' then 'DE'
	    else ' '
    end AS [DELIVERYCOUNTRYID],
	' ' AS [PackingslipID],
	[QTY],
	[OTHERSALESLOCAL],
	[OTHERSALESEUR]
    into #OtherSalesTable
	from [base_ancon_conolly_aus].[CUSTINVOICETRANS_ANAC]
	where
        UPPER(DATAAREAID) = 'ANAC'
        and
        Datepart(yyyy, [ACCOUNTINGDATE]) = @P_Year
        and
        Datepart(MM, [ACCOUNTINGDATE]) = @P_Month
        and
        [ITEMID] in ('ADMIN', 'FREIGHT')

    -- calculate sales amount per invoice into variables. Only real product sales positions. 
    select 
	    c.[INVOICEID],
        ISNULL(sum(c.PRODUCTSALESLOCAL),0) SalesBalanceMST,
        ISNULL(sum(c.PRODUCTSALESEUR),0) SalesBalanceEUR
	into #OtherSalesTable_SB
    from [intm_axbi].[fact_CUSTINVOICETRANS] c
        inner join #OtherSalesTable i
            on c.[INVOICEID] = i.[INVOICEID]
    WHERE
        upper(c.DATAAREAID) = 'ANAC'
        and
        c.[ITEMID] not in ('ANAC-ADMIN', 'ANAC-FREIGHT')
	group by c.[INVOICEID]

    select [INVOICEID], count(*) lcounter
	into #OtherSalesTableTable_cnt
	from [intm_axbi].[fact_CUSTINVOICETRANS]
	where upper(DATAAREAID) = 'ANAC'
	group by [INVOICEID]
	
	-- If regular positions with existing sales amount, distribute the lineamount of ADMIN or FREIGHT according to sales share.
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set OTHERSALESLOCAL += st.OTHERSALESLOCAL * t.PRODUCTSALESLOCAL/sb.SalesBalanceMST,
	    OTHERSALESEUR   += st.OTHERSALESEUR * t.PRODUCTSALESEUR/sb.SalesBalanceEUR
	from 
        [intm_axbi].[fact_CUSTINVOICETRANS] as t
    inner join
        #OtherSalesTable st
	        on t.[INVOICEID]=st.[INVOICEID]
	inner join
        #OtherSalesTable_SB sb
	        on t.[INVOICEID] = sb.[INVOICEID]
	where 
        upper(t.DATAAREAID) = 'ANAC' 
        and
        t.[ITEMID] not in ('ANAC-ADMIN', 'ANAC-FREIGHT')
	    and
        sb.SalesBalanceMST <> 0

	-- If regular positions but without existing sales amount, distribute the lineamount of ADMIN or FREIGHT according to the number of positions.
	update [intm_axbi].[fact_CUSTINVOICETRANS] 
	set OTHERSALESLOCAL += st.OTHERSALESLOCAL / cnt.lcounter,
	    OTHERSALESEUR   += st.OTHERSALESEUR / cnt.lcounter
	from 
        [intm_axbi].[fact_CUSTINVOICETRANS] as t
    inner join
        #OtherSalesTable st
	        on t.[INVOICEID]=st.[INVOICEID]
	inner join
        #OtherSalesTable_SB sb
	        on t.[INVOICEID] = sb.[INVOICEID]
	inner join
        #OtherSalesTableTable_cnt cnt
	        on t.[INVOICEID] = sb.[INVOICEID]             
	where 
        upper(t.DATAAREAID) = 'ANAC' 
        and
        t.[ITEMID] not in ('ANAC-ADMIN', 'ANAC-FREIGHT')
	    and
        sb.SalesBalanceMST = 0
        and 
        cnt.lcounter<>0

    --add step where lcounter=0
	-- If no regular positions exist, then insert the ADMIN or FREIGHT Position but only as Other Sales.
	insert into [intm_axbi].[fact_CUSTINVOICETRANS]
    values
    (
            [DATAAREAID]
	    ,   [SALESID]
	    ,   [INVOICEID]
	    ,   [LINENUM]
	    ,   [INVENTTRANSID]
	    ,   [ACCOUNTINGDATE]
	    ,   [CUSTOMERNO]
	    ,   [ITEMID]
	    ,   [DELIVERYCOUNTRYID]
	    ,   [PACKINGSLIPID]
	    ,   [QTY]
	    ,   [PRODUCTSALESLOCAL]
	    ,   [PRODUCTSALESEUR]
	    ,   [OTHERSALESLOCAL]
	    ,   [OTHERSALESEUR]
	    ,   [ALLOWANCESLOCAL]
	    ,   [ALLOWANCESEUR]
	    ,   [SALES100LOCAL]
	    ,   [SALES100EUR]
	    ,   [FREIGHTLOCAL]
	    ,   [FREIGHTEUR]
	    ,   [COSTAMOUNTLOCAL]
	    ,   [COSTAMOUNTEUR]
    )
	select
	        [DATAAREAID]
	    ,   [SALESID]
	    ,   st.[INVOICEID]
	    ,   [LINENUM]
	    ,   ' '
	    ,   [ACCOUNTINGDATE]
	    ,   'ANAC-' + [CUSTOMETNO]
	    ,   'ANAC-' + [ITEMID]
	    ,   [DELIVERYCOUNTRYID]
	    ,   [PackingslipID]
	    ,   [QTY]
	    ,   0
	    ,   0
	    ,   st.OTHERSALESLOCAL
	    ,   st.OTHERSALESEUR
	    ,   0
	    ,   0
	    ,   0
	    ,   0
	    ,   0
	    ,   0
	    ,   0
	    ,   0
    FROM
        #OtherSalesTable st
	inner join
        #OtherSalesTable_SB sb
	        on st.[INVOICEID] = sb.[INVOICEID]
	inner join
        #OtherSalesTableTable_cnt cnt
	        on st.[INVOICEID] = sb.[INVOICEID]
    WHERE 
        upper(st.DATAAREAID) = 'ANAC'
        and
        sb.SalesBalanceMST = 0
        and
        cnt.lcounter=0

	-- Recalculate SALES100 local and CRH EUR
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[dim_CUSTTABLE] as c
	inner join [intm_axbi].[fact_CUSTINVOICETRANS] as i
	on UPPER(c.DATAAREAID) = UPPER(i.DATAAREAID) and
	   c.ACCOUNTNUM = i.CUSTOMERNO
	where
        UPPER(c.DATAAREAID) = 'ANAC'
        and
        Datepart(yyyy, ACCOUNTINGDATE) = @P_Year
        and
        Datepart(MM, ACCOUNTINGDATE) = @P_Month
	
	-- Standard correction:
	-- Missing a delivery country entry, enter dummy delivery country AU. 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'AU'
	where UPPER(DATAAREAID) = 'ANAC' and DELIVERYCOUNTRYID = ' '

    --drop temp tables
    drop table #OtherSalesTable
    drop table #OtherSalesTable_SB
    drop table #OtherSalesTableTable_cnt

END
