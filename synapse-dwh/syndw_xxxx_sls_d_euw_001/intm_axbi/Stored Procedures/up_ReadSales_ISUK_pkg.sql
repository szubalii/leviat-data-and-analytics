CREATE PROCEDURE [intm_axbi].[up_ReadSales_ISUK_pkg] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	--SET NOCOUNT ON;

    -- Insert statements for procedure here

	declare @lYear smallint = (select datepart(year,max(Accountingdate)) from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISUK]),
			@lMonth tinyint = (select datepart(month,max(Accountingdate)) from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISUK]),

			@lFrYear smallint = (select datepart(year,max(Accountingdate)) from [base_tx_ca_0_hlp].[INVOICEDFREIGHT_ISUK]),
			@lFrMonth tinyint = (select datepart(month,max(Accountingdate)) from [base_tx_ca_0_hlp].[INVOICEDFREIGHT_ISUK])

	-- Voraussetzung für numerische Felder: Keine Tausender Punkt und Dezimaltrennzeichen ist der . und das Negativ Zeichen steht vor der Zahl.
	-- Als Columnterminator dient das ; oder der Tabstopp
	-- Rowterminator ist \n
	-- Keine überflüssigen Spalten
	-- Leereinträge geht, aber nicht mit dem Wert null auffüllen.

	-- CUSTTABLE(truncate)
	
	update [base_tx_ca_0_hlp].[CUSTTABLE_ISUK]
	set DIMENSION3_ = ' '
	where upper(DATAAREAID) = 'ISUK' and DIMENSION3_ is null 

	delete from [intm_axbi].[dim_CUSTTABLE] where upper(DATAAREAID) = 'ISUK'

	insert [intm_axbi].[dim_CUSTTABLE]
	([DATAAREAID],[ACCOUNTNUM],[NAME],[INOUT],[CUSTOMERPILLAR],[COMPANYCHAINID],[DIMENSION3_])
	select distinct
	DATAAREAID,
	'ISUK-' + CUSTOMERID,
	CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	DIMENSION3_
	from [base_tx_ca_0_hlp].[CUSTTABLE_ISUK]

    -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben.
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O'
	from [intm_axbi].[dim_CUSTTABLE] as c
	left outer join [base_tx_ca_0_hlp].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID  
	where upper(c.DATAAREAID) = 'ISUK' and d.CRHCOMPANYID is null 

    -- Halfen USA als OUTSIDE kennzeichnen
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O',
	    CUSTOMERPILLAR = 'OTHER',
	    DIMENSION3_ = '5330U01'
	where upper(DATAAREAID) = 'ISUK' and NAME like '%Halfen USA%' 

	-- Alle Leviat Kunden auf Inside setzen, außer Meadow Burke. 
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where upper(DATAAREAID) = 'ISUK' and NAME like '%Leviat%' and NAME not like '%Meadow Burke%' and NAME not like '%MeadowBurke%'

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where upper(DATAAREAID) = 'ISUK' and CUSTOMERPILLAR = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where upper(DATAAREAID) = 'ISUK' and INOUT = 'I' 

	-- ITEMTABLE

	delete from [intm_axbi].[dim_ITEMTABLE] where UPPER(DATAAREAID) = 'ISUK'

	insert [intm_axbi].[dim_ITEMTABLE]
	([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID])
	select distinct
	[DATAAREAID],
	[ITEMID],
	[ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
	ISNULL('ISUK-' + [ITEMGROUPID], ' ')
	from [base_tx_ca_0_hlp].[ITEMTABLE_ISUK]

	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'A.4.'
	where UPPER(DATAAREAID) = 'ISUK' and ITEMGROUPID = 'ANUK-HELI'  

	-- Dummy article for the Budget
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [intm_axbi].[dim_ITEMTABLE] ([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID]) VALUES('ISUK', 'ISUK-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where UPPER(DATAAREAID) = 'ISUK' and PRODUCTGROUPID = ' ' 

	-- INVOICED FREIGHT RECOVERY TABLE

	delete from [base_tx_ca_0_hlp].[INVOICEDFREIGHT_ISUK] where DATEPART(year, Accountingdate) = @lFrYear and DATEPART(month, Accountingdate) = @lFrMonth 

	-- CUSTINVOICETRANS

	TRUNCATE TABLE [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISUK]

	update [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISUK]
	set ProductSalesEUR = a.ProductSalesLocal/c.CRHRATE,
		OtherSalesEUR = a.OtherSalesLocal/c.CRHRATE,
		AllowancesEUR = a.AllowancesLocal/c.CRHRATE,
		Sales100EUR = a.Sales100Local/c.CRHRATE,
		FreightEUR = a.FreightLocal/c.CRHRATE,
		CostAmountEUR = a.CostAmountLocal/c.CRHRATE
	from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISUK] as a
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] as c
	on Datepart(YYYY, a.Accountingdate) = c.YEAR 
	and	'GBP' = c.CURRENCY

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where UPPER(DATAAREAID) = 'ISUK' and DATEPART(year, ACCOUNTINGDATE) = @lYear and DATEPART(month, ACCOUNTINGDATE) = @lMonth 

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
	select a.Dataareaid, 
	ISNULL(a.Salesid, ' '), 
	cast(a.Invoiceid as nvarchar(20)), 
	a.Linenum, ' ', 
	a.Accountingdate, 
	'ISUK-' + a.CustomerNo, 
	b.ITEMID, 
	a.DeliveryCountryID,
		   ISNULL(a.PackingSlipID, ' '), 
		   a.Qty, 
		   a.ProductSalesLocal, 
		   a.ProductSalesEUR, 
		   a.OtherSalesLocal, 
		   a.OtherSalesEUR, 
		   a.AllowancesLocal, 
		   a.AllowancesEUR, 
		   a.Sales100Local,
		   a.Sales100EUR, 
		   a.FreightLocal, 
		   a.FreightEUR, 
		   a.CostAmountLocal, 
		   a.CostAmountEUR
	 from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ISUK] as a
	      left outer join [intm_axbi].[dim_ITEMTABLE] as b
		  on lower(a.Dataareaid) = lower(b.DATAAREAID) 
		  and a.Itemid = b.ITEMNAME
	  where DATEPART(year, a.Accountingdate) = @lYear and DATEPART(month, a.Accountingdate) = @lMonth
	  
	-- Fehlende Artikelstämme hinzufügen  	
	insert [intm_axbi].[dim_ITEMTABLE]
	([DATAAREAID],[ITEMID],[ITEMNAME],[PRODUCTGROUPID],[ITEMGROUPID])
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
	where upper(c.DATAAREAID) = 'ISUK' and i.ITEMID is null	

	-- Wenn fakturierte Frachtkosten gesendet wurden and fakturierte Frachtkosten aus dem gleichen Zeitraum wie Rechnungssätze  

	SELECT 
	i.Accountingdate, 
	i.InvoicedFreightLocal,
	i.InvoicedFreightLocal / c.CRHRATE InvoicedFreightEur,
	i.PackingSlipID 
	into #InvoicedFreightTable_ISUK
	from [base_tx_ca_0_hlp].[INVOICEDFREIGHT_ISUK] i
	inner join [base_tx_ca_0_hlp].[CRHCURRENCY] c
	on c.YEAR = Datepart(YYYY, i.Accountingdate) 
	and upper(c.CURRENCY) = 'GBP'
	where DATEPART(year, Accountingdate) = @lFrYear 
	and DATEPART(month, Accountingdate) = @lFrMonth 

    select 
	c.PACKINGSLIPID,
    ISNULL(sum(c.PRODUCTSALESLOCAL),0) SalesBalance,
    ISNULL(sum(c.PRODUCTSALESEUR),0) SalesBalanceEUR
	into #InvoicedFreightTable_ISUK_SB
    from [intm_axbi].[fact_CUSTINVOICETRANS] c
    inner join #InvoicedFreightTable_ISUK i
    on c.PACKINGSLIPID = substring(i.PackingSlipID, 1, 6)
    and upper(c.DATAAREAID) = 'ISUK' 
	group by c.PACKINGSLIPID
	
	select PACKINGSLIPID, count(*) lcounter
	into #InvoicedFreightTable_ISUK_cnt
	from [intm_axbi].[fact_CUSTINVOICETRANS]
	where upper(DATAAREAID) = 'ISUK'
	group by PACKINGSLIPID
	
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set OTHERSALESLOCAL += i.InvoicedFreightLocal * t.PRODUCTSALESLOCAL/sb.SalesBalance,
	    OTHERSALESEUR   += i.InvoicedFreightEur * t.PRODUCTSALESEUR/sb.SalesBalanceEUR
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join #InvoicedFreightTable_ISUK i
	on t.PACKINGSLIPID=i.PackingSlipID
	inner join #InvoicedFreightTable_ISUK_SB sb
	on t.PACKINGSLIPID = substring(i.PackingSlipID, 1, 6) 
	where upper(t.DATAAREAID) = 'ISUK' 
	and SalesBalance <> 0
	
	
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set OTHERSALESLOCAL += i.InvoicedFreightLocal / cnt.lcounter,
	    OTHERSALESEUR  += i.InvoicedFreightEur / cnt.lcounter
	from [intm_axbi].[fact_CUSTINVOICETRANS] as t
	inner join #InvoicedFreightTable_ISUK i
	on t.PACKINGSLIPID=i.PackingSlipID
	inner join #InvoicedFreightTable_ISUK_SB sb
	on t.PACKINGSLIPID = substring(i.PackingSlipID, 1, 6) 
	inner join #InvoicedFreightTable_ISUK_cnt cnt
	on t.PACKINGSLIPID = cnt.PACKINGSLIPID
	where upper(t.DATAAREAID) = 'ISUK' 
	and sb.SalesBalance = 0
	
		
	-- SALES100 aktualisieren
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set SALES100LOCAL = i.PRODUCTSALESLOCAL + i.OTHERSALESLOCAL + i.ALLOWANCESLOCAL,
	    SALES100EUR   = i.PRODUCTSALESEUR + i.OTHERSALESEUR + i.ALLOWANCESEUR
	from [intm_axbi].[fact_CUSTINVOICETRANS] as i
	where upper(i.DATAAREAID) = 'ISUK' 
	and DATEPART(year, ACCOUNTINGDATE) = @lYear 
	and DATEPART(month, ACCOUNTINGDATE) = @lMonth

	-- Ermitteln der Rechnungen mit nur einer Position, die einen Productsales enthält
	select DATAAREAID, 
	INVOICEID, 
	COUNT(*) as SalesPosCounter, 
	0 as InvoicePosCounter     ,
	0 as productsaleslocal     ,
	0 as productsalesEUR       ,
	0 as othersaleslocal       ,
	0 as othersalesEUR         ,
	0 as allowanceslocal       ,
	0 as allowancesEUR         ,
	0 as sales100local         ,
	0 as sales100EUR           ,
	0 as freightlocal          ,
	0 as freightEUR            ,
	0 as costamountlocal       ,
	0 as costamountEUR         ,
	0 as productsaleslocal_new ,
	0 as productsalesEUR_new   ,
	0 as othersaleslocal_new   ,
	0 as othersalesEUR_new     ,
	0 as allowanceslocal_new   ,
	0 as allowancesEUR_new     ,
	0 as sales100local_new     ,
	0 as sales100EUR_new       ,
	0 as freightlocal_new      ,
	0 as freightEUR_new        ,
	0 as costamountlocal_new   ,
	0 as costamountEUR_new     
	into ##InvoicePosCounter 
	from [intm_axbi].[fact_CUSTINVOICETRANS] 
	where upper(DATAAREAID) = 'ISUK' 
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
				on lower(c.DATAAREAID)  = lower(b.DATAAREAID) 
				and lower(c.INVOICEID)  = lower(b.INVOICEID)
	group by c.DATAAREAID, c.INVOICEID
	)
	update ##InvoicePosCounter
	set InvoicePosCounter = a.CTE_InvoicePosCounter
	from CTE_PosCounter as a
	inner join ##InvoicePosCounter as b
	on	lower(a.CTE_dataareaid) = lower(b.DATAAREAID) and
		a.CTE_invoiceid  = b.INVOICEID;

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
			  c.INVOICEID  = b.INVOICEID
	group by c.DATAAREAID, c.INVOICEID
	)
	update ##InvoicePosCounter
	set productsaleslocal = a.CTE_productsaleslocal,
		productsalesEUR   = a.CTE_productsalesEUR,
		othersaleslocal   = a.CTE_othersaleslocal,
		othersalesEUR     = a.CTE_othersalesEUR,
		allowanceslocal   = a.CTE_allowanceslocal,
		allowancesEUR     = a.CTE_allowancesEUR,
		sales100local     = a.CTE_sales100local,
		sales100EUR       = a.CTE_sales100EUR,
		freightlocal      = a.CTE_freightlocal,
		freightEUR        = a.CTE_freightEUR,
		costamountlocal   = a.CTE_costamountlocal,
		costamountEUR     = a.CTE_costamountEUR
	from CTE_PosCounter2 as a
	inner join ##InvoicePosCounter as b
	on	lower(a.CTE_dataareaid) = lower(b.DATAAREAID)
	and	a.CTE_invoiceid  = b.INVOICEID;

	-- Rechnungen ohne Costamount von der Verteilung der Rechnungswerte ausschließen.  
	delete from ##InvoicePosCounter where costamountlocal = 0

	-- Rechnungswerte werden auf Basis Costamount verteilt.  
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set PRODUCTSALESLOCAL = b.productsaleslocal * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		PRODUCTSALESEUR   = b.productsalesEUR   * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0)),
		OTHERSALESLOCAL   = b.othersaleslocal   * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		OTHERSALESEUR     = b.othersalesEUR     * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0)),
		ALLOWANCESLOCAL   = b.allowanceslocal   * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		ALLOWANCESEUR     = b.allowancesEUR     * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0)),
		SALES100LOCAL     = b.sales100local     * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		SALES100EUR       = b.sales100EUR       * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0)),
		FREIGHTLOCAL      = b.freightlocal      * (ISNULL(a.COSTAMOUNTLOCAL / NULLIF(b.costamountlocal,0),0)),
		FREIGHTEUR        = b.freightEUR        * (ISNULL(a.COSTAMOUNTEUR / NULLIF(b.costamountEUR,0),0))
	from [intm_axbi].[fact_CUSTINVOICETRANS] as a
	inner join ##InvoicePosCounter as b
	on	lower(a.DATAAREAID) = lower(b.DATAAREAID)
	and	a.INVOICEID  = b.INVOICEID;

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
		   on lower(c.DATAAREAID) = lower(b.DATAAREAID)
		   and c.INVOICEID  = b.INVOICEID
	group by c.DATAAREAID, c.INVOICEID
	)
	update ##InvoicePosCounter
	set productsaleslocal_new = a.CTE_productsaleslocal,
		productsalesEUR_new   = a.CTE_productsalesEUR,
		othersaleslocal_new   = a.CTE_othersaleslocal,
		othersalesEUR_new     = a.CTE_othersalesEUR,
		allowanceslocal_new   = a.CTE_allowanceslocal,
		allowancesEUR_new     = a.CTE_allowancesEUR,
		sales100local_new     = a.CTE_sales100local,
		sales100EUR_new       = a.CTE_sales100EUR,
		freightlocal_new      = a.CTE_freightlocal,
		freightEUR_new        = a.CTE_freightEUR,
		costamountlocal_new   = a.CTE_costamountlocal,
		costamountEUR_new     = a.CTE_costamountEUR
	from CTE_Custinvoicetrans as a
	inner join ##InvoicePosCounter as b
	on	LOWER(a.CTE_dataareaid) = LOWER(b.DATAAREAID)
	and	a.CTE_invoiceid  = b.INVOICEID;

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
	on	lower(a.DATAAREAID) = lower(b.DATAAREAID) 
	and	a.INVOICEID  = b.INVOICEID
	where a.LINENUM = (select MAX(b.LINENUM) from [intm_axbi].[fact_CUSTINVOICETRANS] As b where lower(a.DATAAREAID) = lower(b.DATAAREAID) and a.INVOICEID = b.INVOICEID and b.PRODUCTSALESLOCAL <> 0);

	-- Fehlendes DUMMY Lieferland eintragen 
	update [intm_axbi].[fact_CUSTINVOICETRANS]
	set DELIVERYCOUNTRYID = 'GB'
	where upper(DATAAREAID) = 'ISUK' and DELIVERYCOUNTRYID = ' '

END