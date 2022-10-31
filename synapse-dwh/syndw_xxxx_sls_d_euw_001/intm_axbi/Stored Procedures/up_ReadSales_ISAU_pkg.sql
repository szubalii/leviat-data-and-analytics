-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <28.04.2020>
-- Description:	<Übernahme Umsatzdaten Isedio AU für TX Construction Accessories>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_ISAU_pkg] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--declare @sqlstmt nvarchar(4000),
	--        @log nvarchar(200),
	--		@lDataAreaID nvarchar(8),
	--		@lOrigSalesID nvarchar(20),
	--		@lInvoiceID nvarchar(20),
	--		@lLineNum numeric(28,12),
	--		@lDatefinancial datetime,
	--		@lOrderAccount nvarchar(20),
	--		@lItemID nvarchar(40),
	--		@lDlvcountryregionid nvarchar(20),
	--		@lInvoicedfreightMST decimal(38,12),
	--		@lInvoicedfreightEUR decimal(38,12),
	--		@lPackingslipid nvarchar(20),
	--		@lQty numeric(28,12),
	--		@lLineAmountMST numeric(28,12),
	--		@lLineAmountEUR numeric(28,12),
	--		@lSalesBalanceMST numeric(28,12),
	--		@lSalesBalanceEUR numeric(28,12),
	--		@lcurrencycode nvarchar(3),
	--		@lcounter smallint,

		--	@lYear smallint,
		--	@lMonth tinyint,

		--	@lFrYear smallint,
		--	@lFrMonth tinyint

     declare @P_Year smallint = (select datepart(year,max([Accountingdate])) from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU]),
	         @P_Month tinyint = (select datepart(month,max([Accountingdate])) from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU]),
             @lRate numeric(15,6)


	-- CUSTTABLE

	delete from [intm_axbi].[dim_CUSTTABLE] where DATAAREAID = 'ISAU'

	insert [intm_axbi].[dim_CUSTTABLE]
	select distinct
	DATAAREAID,
	'ISAU-' + ACCOUNTNUM,
	NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' '
	from [base_tx_ca_0_hlp].[CUSTTABLE_ISAU]

	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = '2173U01',
	    INOUT = 'I'
	where UPPER(DATAAREAID) = 'ISAU' and [NAME] = 'Isedio Ltd' 

    -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben.
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O'
	from [intm_axbi].[dim_CUSTTABLE] as c
	left outer join [base_tx_ca_0_hlp].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID  
	where UPPER(c.DATAAREAID) = 'ISAU' and d.CRHCOMPANYID is null 

    -- Halfen USA als OUTSIDE kennzeichnen
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O',
	    CUSTOMERPILLAR = 'OTHER',
	    DIMENSION3_ = '5330U01'
	where UPPER(DATAAREAID) = 'ISAU' and [NAME] like '%Halfen USA%' 

	-- Alle Leviat Kunden auf Inside setzen, außer Meadow Burke. 
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where
        UPPER(DATAAREAID) = 'ISAU'
        and
        [NAME] like '%Leviat%'
        and
        [NAME] not like '%Meadow Burke%'
        and
        [NAME] not like '%MeadowBurke%'

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where UPPER(DATAAREAID) = 'ISAU' and CUSTOMERPILLAR = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where UPPER(DATAAREAID) = 'ISAU' and INOUT = 'I'

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where UPPER(DATAAREAID) = 'ISAU' and CUSTOMERPILLAR = 'Other'

	-- ITEMTABLE

	delete from [intm_axbi].[dim_ITEMTABLE] where UPPER(DATAAREAID) = 'ISAU'

	insert [intm_axbi].[dim_ITEMTABLE]
	select distinct
	[DATAAREAID],
	'ISAU-' + [ITEMID],
	'ISAU-' + [ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
	ISNULL('ISAU-' + [STOCKGROUP], ' ')
	from [base_tx_ca_0_hlp].[ITEMTABLE_ISAU]

	-- Dummy article for the Budget
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE]([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISAU', 'ISAU-ARMOURFIXEND', 'ISAU-ARMOURFIXEND', 'G.1.', 'ISAU-2')

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where UPPER(DATAAREAID) = 'ISAU' and PRODUCTGROUPID = ' '

	-- CUSTINVOICETRANS
	
	select @lRate = CRHRATE
    from [base_tx_ca_0_hlp].[CRHCURRENCY]
    where [YEAR] = @P_Year and [CURRENCY] = 'AUD'

	delete from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU]
    where
        datepart(Year, [Accountingdate]) <> @P_Year
        or
        (datepart(Year, [Accountingdate]) = @P_Year
        and
        datepart(Month, [Accountingdate]) <> @P_Month)

	UPDATE [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU]
	set [ProductSalesEUR] = a.[ProductSalesLocal]/@lRate,
	    [OtherSalesEUR]   = a.[OtherSalesLocal]/@lRate,
	    [AllowancesEUR]   = a.[AllowancesLocal]/@lRate,
	    [Sales100EUR]   = a.[Sales100Local]/@lRate,
	    [FreightEUR]   = a.[FreightLocal]/@lRate,
	    [CostAmountEUR]   = a.[CostAmountLocal]/@lRate
	from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU] as a
    where
        datepart(Year, a.[Accountingdate]) = @P_Year
        and
        datepart(Month, a.[Accountingdate]) = @P_Month 

	UPDATE [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU]
	SET [DeliveryCountryID] = 'AU'
	WHERE [DeliveryCountryID] = 'AUSTRALIA'

	UPDATE [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU]
	SET [Itemid] = 'ISAU-' + [Itemid]
	where substring([Itemid], 1, 5) <> 'ISAU-'

	delete from [intm_axbi].[fact_CUSTINVOICETRANS]
    where
        UPPER(DATAAREAID) = 'ISAU'
        and
        DATEPART(year, [ACCOUNTINGDATE]) = @P_Year
        and
        DATEPART(month, [ACCOUNTINGDATE]) = @P_Month 

	insert [intm_axbi].[fact_CUSTINVOICETRANS]
	select
        a.[Dataareaid],
        ISNULL(a.[Salesid], ' '),
        cast(a.[Invoiceid] as nvarchar(20)),
        a.[Linenum],
        ' ',
        a.[Accountingdate],
        'ISAU-' + a.[CustomerNo],
        a.[Itemid],
        a.[DeliveryCountryID],
		' ',
        a.[Qty],
        a.[ProductSalesLocal],
        a.[ProductSalesEUR],
        a.[OtherSalesLocal],
        a.[OtherSalesEUR],
        a.[AllowancesLocal],
        a.[AllowancesEUR],
        a.[Sales100Local],
		a.[Sales100EUR],
        a.[FreightLocal],
        a.[FreightEUR],
        a.[CostAmountLocal],
        a.[CostAmountEUR]
	 from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU] as a
     where
        a.[Itemid] <> 'ISAU-FREIGHT'
        and
        datepart(Year, a.[Accountingdate]) = @P_Year
        and
        datepart(Month, a.[Accountingdate]) = @P_Month

	-- Fehlende Artikelstämme hinzufügen  	
	insert [intm_axbi].[dim_ITEMTABLE]
	select distinct
	c.DATAAREAID,
	c.ITEMID,
	'Missing Article in Itemtable',
	'N.3.',
	'ISAU-0'
	from
        [intm_axbi].[fact_CUSTINVOICETRANS] as c
	left outer join
        [intm_axbi].[dim_ITEMTABLE] as i
	        on UPPER(c.DATAAREAID) = UPPER(i.DATAAREAID)
            and
	        c.ITEMID = i.ITEMID
	where UPPER(c.DATAAREAID) = 'ISAU' and i.ITEMID is null	

	-- other sales

	DECLARE OtherSalesCursor CURSOR FAST_FORWARD FOR

	select
        [Dataareaid],
	    ISNULL([Salesid], ' ') AS [Salesid],
	    cast([Invoiceid] as nvarchar(20)) AS [Invoiceid],
	    [Linenum],
	    [Accountingdate],
	    'ISAU-' + [CustomerNo] AS [CustomerNo],
	    [Itemid],
	    [DeliveryCountryID],
	    [Qty],
	    [OtherSalesLocal],
	    [OtherSalesEUR]
    into #OtherSalesTable
	from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISAU]
	where
        [Itemid] = 'ISAU-FREIGHT'
        and
        DATEPART(year, [Accountingdate]) = @P_Year
        and
        DATEPART(month, [Accountingdate]) = @P_Month

     select 
	    c.[INVOICEID],
        ISNULL(sum(c.PRODUCTSALESLOCAL),0) SalesBalanceMST,
        ISNULL(sum(c.PRODUCTSALESEUR),0) SalesBalanceEUR
	into #OtherSalesTable_SB
    from [intm_axbi].[fact_CUSTINVOICETRANS] c
        inner join #OtherSalesTable i
            on c.[INVOICEID] = i.[INVOICEID]
    WHERE
        upper(c.DATAAREAID) = 'ISAU'
        and
        c.[ITEMID] <> 'ISAU-FREIGHT'
        AND
        DATEPART(year,c.[ACCOUNTINGDATE]) = @P_Year
        and
        DATEPART(month,c.[ACCOUNTINGDATE]) = @P_Month
	group by c.[INVOICEID]

    select [INVOICEID], count(*) lcounter
	into #OtherSalesTable_cnt
	from [intm_axbi].[fact_CUSTINVOICETRANS]
	where
        upper(DATAAREAID) = 'ISAU'
        and
        [ITEMID] <> 'ISAU-FREIGHT'
        AND
        DATEPART(year,[ACCOUNTINGDATE]) = @P_Year
        and
        DATEPART(month,[ACCOUNTINGDATE]) = @P_Month
	group by [INVOICEID]

	-- Falls reguläre Postionen mit Umsatz vorhanden
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set OTHERSALESLOCAL += st.OtherSalesLocal * t.PRODUCTSALESLOCAL/sb.SalesBalanceMST,
	    OTHERSALESEUR   += st.OtherSalesEUR * t.PRODUCTSALESEUR/sb.SalesBalanceEUR
	from
        [intm_axbi].[fact_CUSTINVOICETRANS] as t
    inner join
        #OtherSalesTable st
	        on t.[INVOICEID]=st.[INVOICEID]
	inner join
        #OtherSalesTable_SB sb
	        on t.[INVOICEID] = sb.[INVOICEID]        
	where
        UPPER(t.DATAAREAID) = 'ISAU'
        and
        DATEPART(year, t.[ACCOUNTINGDATE]) = @P_Year
        and
        DATEPART(month, t.[ACCOUNTINGDATE]) = @P_Month
        and
        t.itemid <> 'ISAU-FREIGHT'
        and
        sb.SalesBalanceMST<>0

	-- Falls Positionen vorhanden, aber ohne Umsatz
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
        #OtherSalesTable_cnt cnt
	        on t.[INVOICEID] = sb.[INVOICEID]       
	where
        UPPER(t.DATAAREAID) = 'ISAU'
        and
        DATEPART(year, t.ACCOUNTINGDATE) = @P_Year
        and
        DATEPART(month, t.ACCOUNTINGDATE) = @P_Month
        and
        t.itemid <> 'ISAU-FREIGHT'
	    and
        sb.SalesBalanceMST=0
        and 
        cnt.counter > 0
	-- Falls keine Positionen vorhanden, aber Miscellaneous Charges vorhanden, dann Position für die Miscellaneous Charge anlegen
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
	    ,   [CUSTOMERNO]
	    ,   [ITEMID]
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
        #OtherSalesTable_cnt cnt
	        on st.[INVOICEID] = sb.[INVOICEID]
    WHERE 
        upper(st.DATAAREAID) = 'ANAC'
        and
        sb.SalesBalanceMST = 0
        and
        cnt.lcounter=0
    		
	-- SALES100 aktualisieren
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[fact_CUSTINVOICETRANS] as i
	where
        UPPER(i.DATAAREAID) = 'ISAU'
        and
        DATEPART(year, ACCOUNTINGDATE) = @P_Year
        and
        DATEPART(month, ACCOUNTINGDATE) = @P_Month

    --drop temp tables
    drop table #OtherSalesTable
    drop table #OtherSalesTable_SB
    drop table #OtherSalesTable_cnt

END
