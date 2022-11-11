-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <26.06.2020>
-- Description:	<Übernahme Umsatzdaten Halfen Moment Philippinen für TX Construction Accessories>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_HMPH_pkg] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

     declare @P_Year smallint = (select datepart(year,max([Accountingdate])) from [base_halfen_moment_ph].[CUSTINVOICETRANS_HMPH]),
	         @P_Month tinyint = (select datepart(month,max([Accountingdate])) from [base_halfen_moment_ph].[CUSTINVOICETRANS_HMPH])

	
	Delete from [base_halfen_moment_ph].[CUSTTABLE_HMPH] where CUSTOMERID is Null;

	update [base_halfen_moment_ph].[CUSTTABLE_HMPH]
	set CLASSIFICATION_PH = ' '
	where CLASSIFICATION_PH is Null; 

	-- Custtable Halfen Moment Philippinen

	delete from [intm_axbi].[dim_CUSTTABLE] where UPPER(DATAAREAID) = 'HMPH'

	insert [intm_axbi].[dim_CUSTTABLE]
    ([DATAAREAID]
    ,[ACCOUNTNUM]
    ,[NAME]
    ,[INOUT]
    ,[CUSTOMERPILLAR]
    ,[COMPANYCHAINID]
    ,[DIMENSION3_])
	select distinct
	'HMPH',
	CUSTOMERID,
	'HMPH-' + CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' '
	from [base_halfen_moment_ph].[CUSTTABLE_HMPH]

	-- Fehlenden Kunden eintragen
	insert into [intm_axbi].[dim_CUSTTABLE]
    ([DATAAREAID],
	[ACCOUNTNUM],
	[NAME],
	[INOUT],
	[CUSTOMERPILLAR],
	[COMPANYCHAINID],
	[DIMENSION3_]
    )
    VALUES
    ('HMPH',
    'HMPH-Freyfil Corporation- Limamburao',
    'HMPH-Freyfil Corporation- Limamburao',
    'O',
    'OTHER',
    ' ',
    ' ')

    -- DIMENSION3_ versorgen
	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = '5331U01'
	where UPPER(DATAAREAID) = 'HMPH' and ACCOUNTNUM = 'HMPH-Halfen Moment SDN BHD'

	-- Alle Leviat Kunden auf Inside setzen, außer Meadow Burke. 
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where
        UPPER(DATAAREAID) = 'HMPH'
        and
        NAME like '%Leviat%'
        and
        NAME not like '%Meadow Burke%'
        and
        NAME not like '%MeadowBurke%'

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where UPPER(DATAAREAID) = 'HMPH' and CUSTOMERPILLAR = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where UPPER(DATAAREAID) = 'HMPH' and INOUT = 'I'

	Delete from [base_halfen_moment_ph].[ITEMTABLE_HMPH]
    where ITEMID is Null

	-- Items Halfen Moment Philippinen

	delete from [intm_axbi].[dim_ITEMTABLE]
    where UPPER(DATAAREAID) = 'HMPH'

	insert [intm_axbi].[dim_ITEMTABLE]
    ([DATAAREAID]
	,[ITEMID]
	,[ITEMNAME]
	,[PRODUCTGROUPID]
	,[ITEMGROUPID])
	select distinct
	'HMPH',
	[ITEMID],
	'HMPH-' + ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	' '
	from [base_halfen_moment_ph].[ITEMTABLE_HMPH]

	-- Dummy article for the Budget
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('HMPH', 'HMPH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where UPPER(DATAAREAID) = 'HMPH' and PRODUCTGROUPID = ' ' 

	delete [base_halfen_moment_ph].[CUSTINVOICETRANS_HMPH]
    where
        DATEPART(yyyy, [Accountingdate]) = @P_Year
        and
        DATEPART(mm, [Accountingdate]) = @P_Month

	delete from [intm_axbi].[fact_CUSTINVOICETRANS]
    where
        UPPER(DATAAREAID) = 'HMPH'
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
        'HMPH',
        '999999999999',
        a.[Invoiceid],
        999,
        ' ',
        a.[Accountingdate],
        a.[CustomerNo],
        a.[Itemid],
        a.[DeliveryCountryID],
        ' ',
	    a.[Qty],
        a.[ProductSalesLocal],
        a.[ProductSalesLocal]/b.[CRHRATE],
        a.[OtherSalesLocal],
        a.[OtherSalesLocal]/b.[CRHRATE],
        0,
        0,
        a.[ProductSalesLocal] + a.[OtherSalesLocal],
        a.[ProductSalesLocal]/b.[CRHRATE] + a.[OtherSalesLocal]/b.[CRHRATE],
        0,
        0,
        a.[CostAmountLocal],
        a.[CostAmountLocal]/b.[CRHRATE]
	from
        [base_halfen_moment_ph].[CUSTINVOICETRANS_HMPH] as a
	inner join
        [base_tx_ca_0_hlp].[CRHCURRENCY] as b
	        on b.[YEAR]  = @P_Year
               and
	           b.[CURRENCY] = 'PHP'
	where
        DATEPART(yyyy, a.[Accountingdate]) =  @P_Year
        and
        DATEPART(mm, a.[Accountingdate]) =  @P_Month

	-- Fehlendes DUMMY Lieferland eintragen 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'PH'
	where DATAAREAID = 'HMPH' and DELIVERYCOUNTRYID = ' '

END
