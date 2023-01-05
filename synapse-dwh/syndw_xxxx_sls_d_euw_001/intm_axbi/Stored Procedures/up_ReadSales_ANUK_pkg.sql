CREATE PROCEDURE [intm_axbi].[up_ReadSales_ANUK_pkg] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  -- Insert statements for procedure here
    IF OBJECT_ID(N'tempdb..#InvoicedFreightTable') IS NOT NULL
    BEGIN
        DROP TABLE #InvoicedFreightTable
    END 
    IF OBJECT_ID(N'tempdb..#InvoicedFreightTable_SB') IS NOT NULL
    BEGIN
        DROP TABLE #InvoicedFreightTable_SB
    END  
    -- IF OBJECT_ID(N'tempdb..#InvoicedFreightTable_cnt') IS NOT NULL
    -- BEGIN
    --     DROP TABLE #InvoicedFreightTable_cnt
    -- END  
    IF OBJECT_ID(N'tempdb..##InvoicePosCounter') IS NOT NULL
    BEGIN
        DROP TABLE ##InvoicePosCounter
    END  

	declare @lYear smallint = (select datepart(year,max(Accountingdate)) from [base_ancon_uk].[CUSTINVOICETRANS_ANUK]),
			@lMonth tinyint = (select datepart(month,max(Accountingdate)) from [base_ancon_uk].[CUSTINVOICETRANS_ANUK]),

			@lFrYear smallint = (select datepart(year,max(Accountingdate)) from [base_ancon_uk].[INVOICEDFREIGHT_ANUK]),
			@lFrMonth tinyint = (select datepart(month,max(Accountingdate)) from [base_ancon_uk].[INVOICEDFREIGHT_ANUK])


	-- Voraussetzung für numerische Felder: Keine Tausender Punkt und Dezimaltrennzeichen ist der . und das Negativ Zeichen steht vor der Zahl.
	-- Als Columnterminator dient das ; oder der Tabstopp
	-- Rowterminator ist \n
	-- Keine überflüssigen Spalten
	-- Leereinträge geht, aber nicht mit dem Wert null auffüllen.

	-- CUSTTABLE
	--append [base_ancon_uk].[CUSTTABLE_ANUK]
	INSERT INTO [base_ancon_uk].[CUSTTABLE_ANUK](
        [DATAAREAID],      
		[CUSTOMERID],      
		[CUSTOMERNAME],    
		[INOUT],           
		[CUSTOMERPILLAR],  
		[DIMENSION3_],
		[t_applicationId], 
		[t_jobId],         
		[t_jobDtm],        
		[t_jobBy],         
		[t_extractionDtm], 
		[t_filePath]
	)      
	SELECT
        [DATAAREAID],      
		[CUSTOMERID],      
		[CUSTOMERNAME],    
		[INOUT],           
		[CUSTOMERPILLAR],  
		[DIMENSION3_], 
		[t_applicationId], 
		[t_jobId],         
		[t_jobDtm],        
		[t_jobBy],         
		[t_extractionDtm], 
		[t_filePath]       
    FROM 
        [base_ancon_uk].[CUSTTABLE_ANUK_orig] AS ORIG 
    WHERE
        NOT EXISTS (
            SELECT 1
            FROM
                [base_ancon_uk].[CUSTTABLE_ANUK] AS ITEM
            WHERE
                ITEM.[CUSTOMERID] = ORIG.[CUSTOMERID]
        )
 
	update [base_ancon_uk].[CUSTTABLE_ANUK]
	set DIMENSION3_ = ' '
	where upper(DATAAREAID) = 'ANUK' and DIMENSION3_ is null 

	delete from [intm_axbi].[dim_CUSTTABLE] where upper(DATAAREAID) = 'ANUK'

	insert [intm_axbi].[dim_CUSTTABLE]
	([DATAAREAID],[ACCOUNTNUM],[NAME],[INOUT],[CUSTOMERPILLAR],[COMPANYCHAINID],[DIMENSION3_])
	select distinct
	DATAAREAID,
	'ANUK-' + CUSTOMERID,
	CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	DIMENSION3_
	from [base_ancon_uk].[CUSTTABLE_ANUK]


  -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben.
	update [intm_axbi].[dim_CUSTTABLE]
	set [intm_axbi].[dim_CUSTTABLE].INOUT = 'O'
	from [intm_axbi].[dim_CUSTTABLE] as c
	left outer join [base_tx_ca_0_hlp].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID 
	where upper(c.DATAAREAID) = 'ANUK' and d.CRHCOMPANYID is null 

	-- Alle Leviat Kunden auf Inside setzen, außer Meadow Burke. 
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where upper(DATAAREAID) = 'ANUK' and UPPER(NAME) like '%LEVIAT%' and UPPER(NAME) not like '%MEADOW BURKE%' and UPPER(NAME) not like '%MEADOWBURKE%'
    
    update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where
        UPPER(DATAAREAID) = 'ANUK'
        and
        (UPPER([NAME]) like '%MEADOWBURKE%'
        or
        UPPER([NAME]) like '%MEADOW BURKE%')

  -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where upper(DATAAREAID) = 'ANUK' and ISNULL(CUSTOMERPILLAR,' ') = ' ' 

  -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where upper(DATAAREAID) = 'ANUK' and INOUT = 'I' 

  /*  update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O',
	    CUSTOMERPILLAR = 'OTHER',
	    DIMENSION3_ = '5330U01'
	where DATAAREAID = 'ANUK' and UPPER(NAME) like '%HALFEN USA%'
*/

	-- ITEMTABLE

	delete from [intm_axbi].[dim_ITEMTABLE] where upper(DATAAREAID) = 'ANUK'

    delete from [base_ancon_uk].[ITEMTABLE_ANUK] where [CRH PRODUCTGROUPID] = 'SCRAP'

	insert [intm_axbi].[dim_ITEMTABLE]
	([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID])
	select distinct
	[DATAAREAID],
	'ANUK-' + [ITEMID],
	[ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
    ISNULL('ANUK-' +[ITEMGROUPID],' ')
	from [base_ancon_uk].[ITEMTABLE_ANUK]

	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'A.4.'
	where upper(DATAAREAID) = 'ANUK' and UPPER(ITEMGROUPID) = 'ANUK-HELI' 

	-- Dummy article for the Budget
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ANUK', 'ANUK-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where upper(DATAAREAID) = 'ANUK' and ISNULL(PRODUCTGROUPID,' ') = ' ' 


	-- MAPPING ITEMGROUP / CRH PRODUCTGROUP

	delete from [intm_axbi].[dim_ITEMGROUP] where upper(DATAAREAID) = 'ANUK'

	insert [intm_axbi].[dim_ITEMGROUP] (DATAAREAID,ITEMGROUPID,ITEMGROUPNAME)
	select 'ANUK', 'ANUK-' + ITEMGROUPID, 'ANUK-' + ITEMGROUPNAME from [base_ancon_uk].[MAPPING_ITEMGROUP_ANUK]

	-- [intm_axbi].[fact_CUSTINVOICETRANS]

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where upper(DATAAREAID) = 'ANUK' and DATEPART(year, ACCOUNTINGDATE) = @lYear and DATEPART(month, ACCOUNTINGDATE) = @lMonth 

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
	Dataareaid, 
	right(CONCAT('0000000000',Salesid),10), 
	CAST(Invoiceid AS NVARCHAR(20)), 
	Linenum, ' ', 
	Accountingdate, 
	'ANUK-' + CustomerNo,
	'ANUK-' + Itemid, 
	DeliveryCountryID, 
	PackingSlipID, 
	Qty, 
	ProductSalesLocal, 
	ProductSalesEUR, 
	OtherSalesLocal, 
	OtherSalesEUR, 
	AllowancesLocal, 
	AllowancesEUR, 
	Sales100Local, 
	Sales100EUR, 
	FreightLocal, 
	FreightEUR, 
	CostAmountLocal, 
	CostAmountEUR 
	from [base_ancon_uk].[CUSTINVOICETRANS_ANUK]
	where DATEPART(year, Accountingdate) = @lYear 
	and DATEPART(month, Accountingdate) = @lMonth

	-- Fehlende Artikelstämme hinzufügen 	
	insert [intm_axbi].[dim_ITEMTABLE] (
	DATAAREAID,
	ITEMID,
	ITEMNAME,
	PRODUCTGROUPID,
	ITEMGROUPID)
	select distinct
	c.DATAAREAID,
	c.ITEMID,
	'Missing Article in Itemtable',
	'N.3.',
	'ANUK-OTH'
	from [intm_axbi].[fact_CUSTINVOICETRANS] as c
	left outer join [intm_axbi].[dim_ITEMTABLE] as i
	on lower(c.DATAAREAID) = lower(i.DATAAREAID) and
	  c.ITEMID = i.ITEMID
	where upper(c.DATAAREAID) = 'ANUK' 
	and i.ITEMID is null	

	-- Wenn fakturierte Frachtkosten gesendet wurden and fakturierte Frachtkosten aus dem gleichen Zeitraum wie Rechnungssätze 	

	SELECT Accountingdate, 
	InvoicedFreightLocal, 
	InvoicedFreightLocal/c.CRHRATE InvoicedFreightEur, 
	PackingSlipID
	into #InvoicedFreightTable
	from [base_ancon_uk].[INVOICEDFREIGHT_ANUK] i
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] c
	on YEAR = Datepart(YYYY, i.Accountingdate) and c.CURRENCY = 'GBP'
	where DATEPART(year, Accountingdate) = @lFrYear 
	and DATEPART(month, Accountingdate) = @lFrMonth 

    select 
	c.PACKINGSLIPID,
    ISNULL(sum(c.PRODUCTSALESLOCAL),0) SalesBalance,
    ISNULL(sum(c.PRODUCTSALESEUR),0) SalesBalanceEUR,
    count(*) lcounter
	into #InvoicedFreightTable_SB
    from [intm_axbi].[fact_CUSTINVOICETRANS] c
    WHERE upper(c.DATAAREAID) = 'ANUK' 
	AND EXISTS (
		SELECT 1
		FROM #InvoicedFreightTable ift
		WHERE ift.PackingSlipID = c.PACKINGSLIPID
	)
	group by c.PACKINGSLIPID;
	
	-- select c.PACKINGSLIPID, count(*) lcounter
	-- into #InvoicedFreightTable_cnt 
	-- from [intm_axbi].[fact_CUSTINVOICETRANS] c
    -- inner join #InvoicedFreightTable i
    -- on c.PACKINGSLIPID = i.PackingSlipID
	-- where upper(c.DATAAREAID) = 'ANUK'
	-- group by c.PACKINGSLIPID
	
	WITH PCC AS (
		SELECT SALESID
			,INVOICEID
			,LINENUM
			,SUM(i.InvoicedFreightLocal * t.PRODUCTSALESLOCAL/sb.SalesBalance) as l_sum
	    	,SUM(i.InvoicedFreightEur * t.PRODUCTSALESEUR/sb.SalesBalanceEUR) as e_sum
    	FROM [intm_axbi].[fact_CUSTINVOICETRANS] AS t
    	INNER JOIN #InvoicedFreightTable i
    		ON t.PACKINGSLIPID=i.[PackingSlipID]
    	INNER JOIN #InvoicedFreightTable_SB sb
    		ON t.PACKINGSLIPID = sb.PACKINGSLIPID
    	WHERE upper(t.DATAAREAID) = 'ANUK' 
    		AND sb.SalesBalance <> 0
    	GROUP BY SALESID,INVOICEID, LINENUM
	)
	UPDATE [intm_axbi].[fact_CUSTINVOICETRANS]
	SET OTHERSALESLOCAL += PCC.l_sum,
	    OTHERSALESEUR   += PCC.e_sum
	FROM [intm_axbi].[fact_CUSTINVOICETRANS] as t
	INNER JOIN PCC
		ON t.SALESID=PCC.SALESID AND t.INVOICEID=PCC.INVOICEID AND t.LINENUM=PCC.LINENUM;
	
	WITH PCC AS (
		SELECT SALESID
			,INVOICEID
			,LINENUM
			,SUM(i.InvoicedFreightLocal / sb.lcounter) AS l_sum
			,SUM(i.InvoicedFreightEur / sb.lcounter) AS e_sum
		FROM [intm_axbi].[fact_CUSTINVOICETRANS] as t
		INNER JOIN #InvoicedFreightTable i
			ON t.PACKINGSLIPID=i.[PackingSlipID]
		INNER JOIN #InvoicedFreightTable_SB sb
		ON t.PACKINGSLIPID = sb.[PACKINGSLIPID]
		WHERE upper(t.DATAAREAID) = 'ANUK' 
			AND sb.SalesBalance = 0
			AND sb.lcounter > 0
		GROUP BY SALESID,INVOICEID, LINENUM
	)
	UPDATE [intm_axbi].[fact_CUSTINVOICETRANS]
	set OTHERSALESLOCAL += PCC.l_sum,
	    OTHERSALESEUR  += PCC.e_sum
	FROM [intm_axbi].[fact_CUSTINVOICETRANS] as t
	INNER JOIN PCC
		ON t.SALESID=PCC.SALESID AND t.INVOICEID=PCC.INVOICEID AND t.LINENUM=PCC.LINENUM;

	-- SALES100 aktualisieren
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set [intm_axbi].[fact_CUSTINVOICETRANS].SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	  [intm_axbi].[fact_CUSTINVOICETRANS].SALES100EUR  = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[fact_CUSTINVOICETRANS] as i
	where upper(i.DATAAREAID) = 'ANUK' and DATEPART(year, ACCOUNTINGDATE) = @lYear and DATEPART(month, ACCOUNTINGDATE) = @lMonth


	-- Ermitteln der Rechnungen mit nur einer Position, die einen Productsales enthält
	select DATAAREAID, 
	INVOICEID, 
	COUNT(*) as SalesPosCounter, 
	CAST(0 as [DECIMAL](38, 12)) as InvoicePosCounter     ,
	CAST(0 as [DECIMAL](38, 12)) as  productsaleslocal    ,
	CAST(0 as [DECIMAL](38, 12)) as  productsalesEUR      ,
	CAST(0 as [DECIMAL](38, 12)) as  othersaleslocal      ,
	CAST(0 as [DECIMAL](38, 12)) as  othersalesEUR        ,
	CAST(0 as [DECIMAL](38, 12)) as  allowanceslocal      ,
	CAST(0 as [DECIMAL](38, 12)) as  allowancesEUR        ,
	CAST(0 as [DECIMAL](38, 12)) as  sales100local        ,
	CAST(0 as [DECIMAL](38, 12)) as  sales100EUR          ,
	CAST(0 as [DECIMAL](38, 12)) as  freightlocal         ,
	CAST(0 as [DECIMAL](38, 12)) as  freightEUR           ,
	CAST(0 as [DECIMAL](38, 12)) as  costamountlocal      ,
	CAST(0 as [DECIMAL](38, 12)) as  costamountEUR        ,
    CAST(0 as [DECIMAL](38, 12)) as  productsaleslocal_new,
    CAST(0 as [DECIMAL](38, 12)) as  productsalesEUR_new  ,
    CAST(0 as [DECIMAL](38, 12)) as  othersaleslocal_new  ,
    CAST(0 as [DECIMAL](38, 12)) as  othersalesEUR_new    ,
    CAST(0 as [DECIMAL](38, 12)) as  allowanceslocal_new  ,
    CAST(0 as [DECIMAL](38, 12)) as  allowancesEUR_new    ,
    CAST(0 as [DECIMAL](38, 12)) as  sales100local_new    ,
    CAST(0 as [DECIMAL](38, 12)) as  sales100EUR_new      ,
    CAST(0 as [DECIMAL](38, 12)) as  freightlocal_new     ,
    CAST(0 as [DECIMAL](38, 12)) as  freightEUR_new       ,
    CAST(0 as [DECIMAL](38, 12)) as  costamountlocal_new  ,
    CAST(0 as [DECIMAL](38, 12)) as  costamountEUR_new
	into ##InvoicePosCounter
	from [intm_axbi].[fact_CUSTINVOICETRANS] 
	where upper(DATAAREAID) = 'ANUK' 
	and DATEPART(year, ACCOUNTINGDATE) = @lYear 
	and DATEPART(month, ACCOUNTINGDATE) = @lMonth 
	and SALES100LOCAL <> 0
	group by DATAAREAID, INVOICEID

	delete from ##InvoicePosCounter where SalesPosCounter <> 1;

	-- Ermitteln der Gesamtzahl Postionen dieser Rechnungen, wenn insgesamt nur eine, diese wiederum löschen
	WITH CTE_PosCounter(CTE_dataareaid, CTE_invoiceid, CTE_InvoicePosCounter) AS
	(
	select c.DATAAREAID, c.INVOICEID, COUNT(*) from [intm_axbi].[fact_CUSTINVOICETRANS] AS c
	inner join ##InvoicePosCounter As b
				on lower(c.DATAAREAID) = lower(b.DATAAREAID) and
				  c.INVOICEID = b.INVOICEID
	group by c.DATAAREAID, c.INVOICEID
	)
	update ##InvoicePosCounter
	set InvoicePosCounter = a.CTE_InvoicePosCounter
	from CTE_PosCounter as a
	inner join ##InvoicePosCounter as b
	on	lower(a.CTE_dataareaid) = lower(b.DATAAREAID) and
		a.CTE_invoiceid = b.INVOICEID;

	delete from ##InvoicePosCounter where SalesPosCounter = 1 and InvoicePosCounter = 1;


	WITH CTE_PosCounter2(CTE_dataareaid, CTE_invoiceid, CTE_productsaleslocal, CTE_productsalesEUR, CTE_othersaleslocal, CTE_othersalesEUR,
						 CTE_allowanceslocal, CTE_allowancesEUR, CTE_sales100local, CTE_sales100EUR, CTE_freightlocal, CTE_freightEUR,
						 CTE_costamountlocal, CTE_costamountEUR) AS
	(
	select c.DATAAREAID, c.INVOICEID, 
		  SUM(c.PRODUCTSALESLOCAL), SUM(c.PRODUCTSALESEUR), SUM(c.OTHERSALESLOCAL), SUM(c.OTHERSALESEUR),
		  SUM(c.ALLOWANCESLOCAL), SUM(c.ALLOWANCESEUR), SUM(c.SALES100LOCAL), SUM(c.SALES100EUR),
		  SUM(c.FREIGHTLOCAL), SUM(c.FREIGHTEUR), SUM(c.COSTAMOUNTLOCAL), SUM(c.COSTAMOUNTEUR)
		  from [intm_axbi].[fact_CUSTINVOICETRANS] AS c
		  inner join ##InvoicePosCounter As b
		  on lower(c.DATAAREAID) = lower(b.DATAAREAID) and
			 c.INVOICEID = b.INVOICEID
	group by c.DATAAREAID, c.INVOICEID
	)
	update ##InvoicePosCounter
	set productsaleslocal = a.CTE_productsaleslocal,
		productsalesEUR  = a.CTE_productsalesEUR,
		othersaleslocal  = a.CTE_othersaleslocal,
		othersalesEUR   = a.CTE_othersalesEUR,
		allowanceslocal  = a.CTE_allowanceslocal,
		allowancesEUR   = a.CTE_allowancesEUR,
		sales100local   = a.CTE_sales100local,
		sales100EUR    = a.CTE_sales100EUR,
		freightlocal   = a.CTE_freightlocal,
		freightEUR    = a.CTE_freightEUR,
		costamountlocal  = a.CTE_costamountlocal,
		costamountEUR   = a.CTE_costamountEUR
	from CTE_PosCounter2 as a
	inner join ##InvoicePosCounter as b
	on	lower(a.CTE_dataareaid) = lower(b.DATAAREAID) and
		a.CTE_invoiceid = b.INVOICEID;


	-- Rechnungen ohne Costamount von der Verteilung der Rechnungswerte ausschließen. 
	delete from ##InvoicePosCounter where costamountlocal = 0

	-- Rechnungswerte werden auf Basis Costamount verteilt. 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set PRODUCTSALESLOCAL = b.productsaleslocal * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		PRODUCTSALESEUR  = b.productsalesEUR  * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0)),
		OTHERSALESLOCAL  = b.othersaleslocal  * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		OTHERSALESEUR   = b.othersalesEUR   * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0)),
		ALLOWANCESLOCAL  = b.allowanceslocal  * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		ALLOWANCESEUR   = b.allowancesEUR   * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0)),
		SALES100LOCAL   = b.sales100local   * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		SALES100EUR    = b.sales100EUR    * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0)),
		FREIGHTLOCAL   = b.freightlocal   * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		FREIGHTEUR    = b.freightEUR    * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0))
	from [intm_axbi].[fact_CUSTINVOICETRANS] as a
	inner join ##InvoicePosCounter as b
	on	lower(a.DATAAREAID) = lower(b.DATAAREAID) and
		a.INVOICEID = b.INVOICEID;
	
	WITH CTE_Custinvoicetrans(CTE_dataareaid, CTE_invoiceid, CTE_productsaleslocal, CTE_productsalesEUR, CTE_othersaleslocal, CTE_othersalesEUR,
							 CTE_allowanceslocal, CTE_allowancesEUR, CTE_sales100local, CTE_sales100EUR, CTE_freightlocal, CTE_freightEUR,
							 CTE_costamountlocal, CTE_costamountEUR) AS
	(
	select c.DATAAREAID, c.INVOICEID, 
		  SUM(c.PRODUCTSALESLOCAL), SUM(c.PRODUCTSALESEUR), SUM(c.OTHERSALESLOCAL), SUM(c.OTHERSALESEUR),
		  SUM(c.ALLOWANCESLOCAL), SUM(c.ALLOWANCESEUR), SUM(c.SALES100LOCAL), SUM(c.SALES100EUR),
		  SUM(c.FREIGHTLOCAL), SUM(c.FREIGHTEUR), SUM(c.COSTAMOUNTLOCAL), SUM(c.COSTAMOUNTEUR)
		  from [intm_axbi].[fact_CUSTINVOICETRANS] AS c
		  inner join ##InvoicePosCounter As b
		  on lower(c.DATAAREAID) = lower(b.DATAAREAID) and
			 c.INVOICEID = b.INVOICEID
	group by c.DATAAREAID, c.INVOICEID
	)
	update ##InvoicePosCounter
	set productsaleslocal_new = a.CTE_productsaleslocal,
		productsalesEUR_new  = a.CTE_productsalesEUR,
		othersaleslocal_new  = a.CTE_othersaleslocal,
		othersalesEUR_new   = a.CTE_othersalesEUR,
		allowanceslocal_new  = a.CTE_allowanceslocal,
		allowancesEUR_new   = a.CTE_allowancesEUR,
		sales100local_new   = a.CTE_sales100local,
		sales100EUR_new    = a.CTE_sales100EUR,
		freightlocal_new   = a.CTE_freightlocal,
		freightEUR_new    = a.CTE_freightEUR,
		costamountlocal_new  = a.CTE_costamountlocal,
		costamountEUR_new   = a.CTE_costamountEUR
	from CTE_Custinvoicetrans as a
	inner join ##InvoicePosCounter as b
	on	lower(a.CTE_dataareaid) = lower(b.DATAAREAID) and
		a.CTE_invoiceid = b.INVOICEID;

	-- Je Rechnung Rundungsdifferenz alter/neuer Gesamtumsatz in der letzten Position ausgleichen 
	update [intm_axbi].[fact_CUSTINVOICETRANS] 
	set PRODUCTSALESLOCAL = a.PRODUCTSALESLOCAL + (b.productsaleslocal - b.productsaleslocal_new),
		PRODUCTSALESEUR = a.PRODUCTSALESEUR + (b.productsalesEUR - b.productsalesEUR_new),
		OTHERSALESLOCAL = a.OTHERSALESLOCAL + (b.othersaleslocal - b.othersaleslocal_new),
		OTHERSALESEUR = a.OTHERSALESEUR + (b.othersalesEUR - b.othersalesEUR_new),
		ALLOWANCESLOCAL = a.ALLOWANCESLOCAL + (b.allowanceslocal - b.allowanceslocal_new),
		ALLOWANCESEUR = a.ALLOWANCESEUR + (b.allowancesEUR - b.allowancesEUR_new),
		SALES100LOCAL = a.SALES100LOCAL + (b.sales100local - b.sales100local_new),
		SALES100EUR = a.SALES100EUR + (b.sales100EUR - b.sales100EUR_new),
		FREIGHTLOCAL = a.FREIGHTLOCAL + (b.freightlocal - b.freightlocal_new),
		FREIGHTEUR = a.FREIGHTEUR + (b.freightEUR - b.freightEUR_new),
		COSTAMOUNTLOCAL = a.COSTAMOUNTLOCAL + (b.costamountlocal - b.costamountlocal_new),
		COSTAMOUNTEUR = a.COSTAMOUNTEUR + (b.costamountEUR - b.costamountEUR_new)
	from [intm_axbi].[fact_CUSTINVOICETRANS] As a
	inner join ##InvoicePosCounter as b
	on	lower(a.DATAAREAID) = lower(b.DATAAREAID) and
		a.INVOICEID = b.INVOICEID
	where a.LINENUM = (select MAX(b.LINENUM) from [intm_axbi].[fact_CUSTINVOICETRANS] As b where lower(a.DATAAREAID) = lower(b.DATAAREAID) and a.INVOICEID = b.INVOICEID and b.PRODUCTSALESLOCAL <> 0);
	
	-- Fehlendes DUMMY Lieferland eintragen 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'GB'
	where upper(DATAAREAID) = 'ANUK' and DELIVERYCOUNTRYID = ' '

    drop table #InvoicedFreightTable
    drop table #InvoicedFreightTable_SB
    --drop table #InvoicedFreightTable_cnt
    drop table ##InvoicePosCounter
END