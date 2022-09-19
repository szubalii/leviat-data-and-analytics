-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <12.07.2019>
-- Description:	<Aufbau Artikel- und Kundenstamm für TX Construction Accessories>
-- =============================================
--
-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <22.08.2019>
-- Description:	<Aufbau Artikel- und Kundenstamm für TX Construction Accessories>
-- =============================================
--
CREATE PROCEDURE [int_axbi].[up_createAxBiBasicData] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--------	customer table AX-BI	-------------------
	
	-- transfer customer main table ANCON, ASCHWANDEN, HALFEN, PLAKA to main table AX-BI CUSTTABLE

	truncate table [int_axbi].[CUSTTABLE]

	insert [int_axbi].[CUSTTABLE]
	select distinct
	case DATAAREAID
	when '5300' then 'HADP'
	when '5302' then 'HAIN'
	when '5303' then 'HADE'
	when '5307' then 'HAFR'
	when '5308' then 'HASE'
	when '5309' then 'HABE'
	when '5310' then 'HAUK'
	when '5311' then 'HACH'
	when '5313' then 'HAAT'
	when '5314' then 'HANL'
	when '5315' then 'HAIT'
	when '5316' then 'HAPL'
	when '5317' then 'HACZ'
	when '5320' then 'HAES'
	when '5321' then 'HAPP'
	when '5325' then 'HANO'
	when '5327' then 'HACN'
	when '5330' then 'HAUS'
	end,
	case DATAAREAID
	when '5300' then 'HADP-' + ACCOUNTNUM
	when '5302' then 'HAIN-' + ACCOUNTNUM
	when '5303' then 'HADE-' + ACCOUNTNUM
	when '5307' then 'HAFR-' + ACCOUNTNUM
	when '5308' then 'HASE-' + ACCOUNTNUM
	when '5309' then 'HABE-' + ACCOUNTNUM
	when '5310' then 'HAUK-' + ACCOUNTNUM
	when '5311' then 'HACH-' + ACCOUNTNUM
	when '5313' then 'HAAT-' + ACCOUNTNUM
	when '5314' then 'HANL-' + ACCOUNTNUM
	when '5315' then 'HAIT-' + ACCOUNTNUM
	when '5316' then 'HAPL-' + ACCOUNTNUM
	when '5317' then 'HACZ-' + ACCOUNTNUM
	when '5320' then 'HAES-' + ACCOUNTNUM
	when '5321' then 'HAPP-' + ACCOUNTNUM
	when '5325' then 'HANO-' + ACCOUNTNUM
	when '5327' then 'HACN-' + ACCOUNTNUM
	when '5330' then 'HAUS-' + ACCOUNTNUM
	end,
	NAME,
	case DIMENSION3_
	when '5300U01' then 'I'
	when '5302U01' then 'I'
	when '5303U01' then 'I'
	when '5307U01' then 'I'
	when '5308U01' then 'I'
	when '5309U01' then 'I'
	when '5310U01' then 'I'
	when '5311U01' then 'I'
	when '5313U01' then 'I'
	when '5314U01' then 'I'
	when '5315U01' then 'I'
	when '5316U01' then 'I'
	when '5317U01' then 'I'
	when '5320U01' then 'I'
	when 'S060U01' then 'I'
	when '5321U01' then 'I'
	when '5325U01' then 'I'
	when '5327U01' then 'I'
	when '5330U01' then 'O'
	when '5331U01' then 'I'
	when '5332U01' then 'I'
	when '5333U01' then 'I'
	when '5334U01' then 'I'
	when 'S038U01' then 'I'
	when 'S059U01' then 'I'
	when '2160U01' then 'I'
	when '2161U01' then 'I'
	when '2162U01' then 'I'
	when '2163U01' then 'I'
	when '2164U01' then 'I'
	when '2165U01' then 'I'
	when '2166U01' then 'I'
	when '2175U01' then 'I'
	when 'S071U01' then 'I'
	Else 'O'
	end,
	STATISTICSGROUP,
	ISNULL(COMPANYCHAINID, ' '),
	ISNULL(DIMENSION3_, ' ')
	from [base_dw_halfen_0_hlp].[CUSTOMER] where DATAAREAID in ('5300', '5302', '5303', '5307', '5308', '5309', '5310', '5311', '5313', '5314', '5315', '5316', '5317', '5320', '5321', '5325', '5327') -- ohne Halfen USA 5330

	-- Ancon AT, CH, DE Aschwanden CH Plaka BE, FR

	insert [int_axbi].[CUSTTABLE]
	select distinct
	case DATAAREAID
	when 'anat' then 'ANAT'
	when 'anch' then 'ANCH'
	when 'ande' then 'ANDE'
	when 'ass' then 'ASCH'
	when 'plb' then 'PLBE'
	when 'plf' then 'PLFR'
	end,
	case DATAAREAID
	when 'anat' then 'ANAT-' + ACCOUNTNUM
	when 'anch' then 'ANCH-' + ACCOUNTNUM
	when 'ande' then 'ANDE-' + ACCOUNTNUM
	when 'ass' then 'ASCH-' + ACCOUNTNUM
	when 'plb' then 'PLBE-' + ACCOUNTNUM
	when 'plf' then 'PLFR-' + ACCOUNTNUM
	end,
	NAME,
	'O',
	case DATAAREAID
	when 'ass' then
		Case SEGMENTID
		when 'PRECAST' then 'PRECAST'
		else 'OTHER' end
	when 'plb' then
		Case SEGMENTID
		when 'Precast' then 'PRECAST'
		when 'PRECAST' then 'PRECAST'
		when 'Industrial' then 'INDUSTRIAL'
		when 'INDUSTRIAL' then 'INDUSTRIAL'
		else 'OTHER' end
	else
		Case STATISTICSGROUP
		when 'Precast' then 'PRECAST'
		when 'PRECAST' then 'PRECAST'
		when 'Industrial' then 'INDUSTRIAL'
		when 'INDUSTRIAL' then 'INDUSTRIAL'
		else 'OTHER' end
 end,
	--ISNULL(COMPANYCHAINID, ' '), ausgesternt wegen STATITICSGROUP nicht in DIM_CUSTABLE
	ISNULL([Chain to use], ' '),
	case DATAAREAID
	when 'ass' then
	ISNULL(DIMENSION5_, ' ')
	else
	ISNULL(DIMENSION3_, ' ')
	end
	from [base_tx_crh_1_stg].[AX_CRH_A_dbo_CUSTTABLE] where DATAAREAID in ('anat', 'anch', 'ande', 'ass', 'plb', 'plf')

--old logic commented by Erich
	/* update [int_axbi].[CUSTTABLE]
	set DIMENSION3_ = 'S059U01'
	where DATAAREAID = 'PLBE' and ACCOUNTNUM in ('PLBE-I_050-055', 'PLBE-I_050-057') */

	update [int_axbi].[CUSTTABLE]
	set DIMENSION3_ = 'S060U01'
	where DATAAREAID = 'PLFR' and ACCOUNTNUM in ('PLFR-I_101-063', 'PLFR-I_102-061')

	delete from [int_axbi].[CUSTTABLE]
	where DATAAREAID ='PLBE' and ACCOUNTNUM in ('PLBE-11120', 'PLBE-3562', 'PLBE-49249', 'PLBE-I_505')

--old logic commented by Erich
	--delete from [int_axbi].[CUSTTABLE]
	--where DATAAREAID ='PLBE' and ACCOUNTNUM like '%PLBE-I_050%'

	delete from [int_axbi].[CUSTTABLE]
	where DATAAREAID ='PLFR' and ACCOUNTNUM in ('PLFR-11243', 'PLFR-I_050', 'PLFR-I_505')

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAT', 'ANCH', 'ANDE', 'ASCH', 'PLBE', 'PLFR') and  substring(NAME, 1, 5) = 'Ancon'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAT', 'ANCH', 'ANDE', 'ASCH', 'PLBE', 'PLFR') and  substring(NAME, 1, 5) = 'Plaka'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAT', 'ANCH', 'ANDE', 'ASCH', 'PLBE', 'PLFR') and  substring(NAME, 1, 6) = 'Halfen'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAT', 'ANCH', 'ANDE', 'ASCH', 'PLBE', 'PLFR') and  NAME like '%Aschwanden%'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAT', 'ANCH', 'ANDE', 'ASCH', 'PLBE', 'PLFR') and  NAME like '%Helifix (Australia)%'

	-- Ancon AU, NZ

	insert [int_axbi].[CUSTTABLE]
	select distinct
	case DATAAREAID
	when 'anau' then 'ANAU'
	when 'hlau' then 'ANAH'
	when 'hlnz' then 'ANNZ'
	end,
	case DATAAREAID
	when 'anau' then 'ANAU-' + ACCOUNTNUM
	when 'hlau' then 'ANAH-' + ACCOUNTNUM
	when 'hlnz' then 'ANNZ-' + ACCOUNTNUM
	end,
	NAME,
	'O',
	Case DIMENSION
	when 'UNIC' then 'PRECAST'
	else 'OTHER' end,
	' ',
	ISNULL(DIMENSION3_, ' ')
	from [ANCON_AUSTRALIA_2_DWH_UAT].dbo.DIM_CUSTTABLE where DATAAREAID in ('anau', 'hlau', 'hlnz')

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAU', 'ANAH', 'ANNZ') and  substring(NAME, 1, 5) = 'Ancon'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAU', 'ANAH', 'ANNZ') and  substring(NAME, 1, 5) = 'Plaka'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAU', 'ANAH', 'ANNZ') and  substring(NAME, 1, 6) = 'Halfen'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAU', 'ANAH', 'ANNZ') and  NAME like '%Aschwanden%'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID in ('ANAU', 'ANAH', 'ANNZ') and  NAME like '%Helifix (Australia)%'

	-- Ancon UK
--out of sprint 32
/*
	update [dbo].[CUSTTABLE_ANUK$_bulk]
	set DIMENSION3_ = ' '
	where DATAAREAID = 'ANUK' and DIMENSION3_ is null 

	insert [int_axbi].[CUSTTABLE]
	select distinct
	DATAAREAID,
	'ANUK-' + CUSTOMERID,
	CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	DIMENSION3_
	from [int_axbi].[CUSTTABLE]_ANUK$_bulk
*/
	-- Ancon Australia CONNOLLY
--out of sprint 32
/*
	insert [int_axbi].[CUSTTABLE]
	select distinct
	DATAAREAID,
	'ANAC-' + CAST(ACCOUNTNUM as nvarchar),
	NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' '
	from [int_axbi].[CUSTTABLE]_ANAC$_bulk

	delete from itemtable where PRODUCTGROUPID = 'SCRAP'
	delete from [dbo].[ITEMTABLE_ANUK$_bulk] where [CRH PRODUCTGROUPID] = 'SCRAP'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  substring(NAME, 1, 5) = 'Ancon'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  substring(NAME, 1, 5) = 'Plaka'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  substring(NAME, 1, 6) = 'Halfen'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  NAME like '%Aschwanden%'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  NAME like '%Helifix (Australia)%'
*/

--old logic commented by Erich
	/*
	update [int_axbi].[CUSTTABLE]
	set [CUSTTABLE].DIMENSION3_ =
	case u.NAME
	when 'ANCON (MIDDLE EAST) FZE' then '2165U01'
	when 'Ancon (New Zealand) Ltd' then '2166U01'
	when 'ANCON (NEW ZEALAND) LTD' then '2166U01'
	when 'ANCON (SCHWEIZ) AG' then '2163U01'
	when 'ANCON BUILDING PRODUCTS (AUSTRALIA)' then '2161U01'	
	when 'Ancon Building Products Gesmbh' then '2162U01'
	when 'ANCON BUILDING PRODUCTS GesmbH.' then '2162U01'
	when 'Ancon GMBH' then '2164U01'
	when 'ANCON GMBH' then '2164U01'
	when 'F J ASCHWANDEN AG' then 'S071U01'
	when 'HALFEN AB' then '5308U01'
	when 'HALFEN AS' then '5325U01'
	when 'HALFEN B.V.' then '5314U01'
	when 'HALFEN GMBH' then '5300U01'
	when 'HALFEN IBERICA S. L.' then 'S060U01'
	when 'HALFEN LIMITED' then '5310U01'
	when 'HALFEN S.R.L.' then '5315U01'
	when 'HALFEN SAS' then '5307U01'
	when 'HALFEN Sp. Z.o.o (euros)' then '5316U01'
	when 'HALFEN-MOMENT PTE LTD' then '5333U01'
	when 'HALFEN -MOMENT INC' then '5334U01'
	when 'HALFEN MOMENT SDN BHD' then '5331U01'
	when 'Helifix (Australia) Pty Ltd' then '2167U01'	
	when 'NV PLAKABETON S.A' then 'S038U01'
	else ' '
	end
	from  [int_axbi].[CUSTTABLE] as u where DATAAREAID = 'ANUK'
	*/
	
    -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben. Mark all customers as OUTSIDE who have no entry in the DATAAREA table.
--out of sprint 32
/*
	update [int_axbi].[CUSTTABLE]
	set CUSTTABLE.INOUT = 'O'
	from [int_axbi].[CUSTTABLE] as c
	left outer join [dbo].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID  
	where c.DATAAREAID = 'ANUK' and d.CRHCOMPANYID is null 
*/

	-- Ancon Middle East
--out of sprint 32
/*
	insert [int_axbi].[CUSTTABLE]
	select distinct
	'ANME',
	CUSTOMERID,
	'ANME-' + CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' '
	from [int_axbi].[CUSTTABLE]_ANME$_bulk
*/

	-- Ancon Isedio UK
--out of sprint 32
/*
	insert [int_axbi].[CUSTTABLE]
	select distinct
	DATAAREAID,
	'ISUK-' + CUSTOMERID,
	CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	DIMENSION3_
	from [int_axbi].[CUSTTABLE]_ISUK$_bulk

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Isedio%'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Ancon%'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Plaka%'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Halfen%'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Aschwanden%'

	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Helifix (Australia)%'


	update [int_axbi].[CUSTTABLE]
	set [CUSTTABLE].DIMENSION3_ =
	case u.NAME
	when 'ISEDIO AUSTRALIA PTY LTD' then '2174U01'
	when 'ANCON (MIDDLE EAST) FZE' then '2165U01'
	when 'Ancon (New Zealand) Ltd' then '2166U01'
	when 'ANCON (NEW ZEALAND) LTD' then '2166U01'
	when 'ANCON (SCHWEIZ) AG' then '2163U01'
	when 'ANCON BUILDING PRODUCTS (AUSTRALIA)' then '2161U01'	
	when 'Ancon Building Products Gesmbh' then '2162U01'
	when 'ANCON BUILDING PRODUCTS GesmbH.' then '2162U01'
	when 'Ancon GMBH' then '2164U01'
	when 'ANCON GMBH' then '2164U01'
	when 'F J ASCHWANDEN AG' then 'S071U01'
	when 'HALFEN AB' then '5308U01'
	when 'HALFEN AS' then '5325U01'
	when 'HALFEN B.V.' then '5314U01'
	when 'HALFEN GMBH' then '5300U01'
	when 'HALFEN IBERICA S.L' then 'S060U01'
	when 'HALFEN LIMITED' then '5310U01'
	when 'HALFEN S.R.L.' then '5315U01'
	when 'HALFEN SAS' then '5307U01'
	when 'HALFEN Sp. Z.o.o (euros)' then '5316U01'
	when 'HALFEN-MOMENT PTE LTD' then '5333U01'
	when 'HALFEN -MOMENT INC' then '5334U01'
	when 'HALFEN MOMENT SDN BHD' then '5331U01'
	when 'Helifix (Australia) Pty Ltd' then '2167U01'	
	when 'NV PLAKABETON S.A' then 'S038U01'
	else ' '
	end
	from  [int_axbi].[CUSTTABLE] as u where DATAAREAID = 'ISUK'

	-- Bereiningung INSIDE CRH Company Spalte DIMENSION3_ 
	update [int_axbi].[CUSTTABLE]
	set DIMENSION3_ = ' '
	 where DATAAREAID = 'ISUK' and DIMENSION3_ = '999999'

    -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben.
	update [int_axbi].[CUSTTABLE]
	set CUSTTABLE.INOUT = 'O'
	from [int_axbi].[CUSTTABLE] as c
	left outer join [dbo].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID  
	where c.DATAAREAID = 'ISUK' and d.CRHCOMPANYID is null 

    -- Halfen USA als OUTSIDE kennzeichnen
	update [int_axbi].[CUSTTABLE]
	set INOUT = 'O',
	    CUSTOMERPILLAR = 'OTHER',
	    DIMENSION3_ = '5330U01'
	where DATAAREAID = 'ISUK' and NAME like '%Halfen USA%' 

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen
	update [int_axbi].[CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISUK' and CUSTOMERPILLAR = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [int_axbi].[CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISUK' and INOUT = 'I' 

	-- Bereiningung INSIDE CRH Company Spalte DIMENSION3_ 
	update [int_axbi].[CUSTTABLE]
	set DIMENSION3_ = ' '
	 where DIMENSION3_ = '999999'

    -- Halfen USA als OUTSIDE kennzeichnen
	update [int_axbi].[CUSTTABLE]
	set INOUT = 'O',
	    CUSTOMERPILLAR = 'OTHER',
	    DIMENSION3_ = '5330U01'
	where DATAAREAID = 'ANUK' and NAME like '%Halfen USA%' 
*/

	--======================================================================

	-- Halfen Moment Malaysia
--out of sprint 32
/*	
	insert [int_axbi].[CUSTTABLE]
	select distinct
	'HMMY',
	'HMMY-' + ACCOUNTNUM,
	'HMMY-' + NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	DIMENSION3_
	from [int_axbi].[CUSTTABLE]_HMMY$_bulk

	-- Halfen Moment Singapur
	
	insert [int_axbi].[CUSTTABLE]
	select distinct
	'HMSG',
	'HMSG-' + ACCOUNTNUM,
	'HMSG-' + NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	DIMENSION3_
	from [int_axbi].[CUSTTABLE]_HMSG$_bulk

	-- Halfen Moment Indien

	insert [int_axbi].[CUSTTABLE]
	select distinct
	'HMIN',
	CUSTOMERID,
	'HMIN-' + CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' '
	from [int_axbi].[CUSTTABLE]_HMIN$_bulk

	update [int_axbi].[CUSTTABLE]
	set DIMENSION3_ = case ACCOUNTNUM
						 when 'HMIN-Halfen Internat' then '5302U01'
						 when 'HMIN-Halfen Mom MY' then '5331U01'
						 when 'HMIN-Halfen Mom SG' then '5333U01'
						 else ' ' end
	where DATAAREAID = 'HMIN' 

	-- Halfen Moment Philippinen

	insert [int_axbi].[CUSTTABLE]
	select distinct
	'HMPH',
	CUSTOMERID,
	'HMPH-' + CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' '
	from [int_axbi].[CUSTTABLE]_HMPH$_bulk

	-- Fehlenden Kunden eintragen
	insert into [int_axbi].[CUSTTABLE] VALUES('HMPH', 'HMPH-Freyfil Corporation- Limamburao', 'HMPH-Freyfil Corporation- Limamburao', 'O', 'OTHER', ' ', ' ')

    -- DIMENSION3_ versorgen
	update [int_axbi].[CUSTTABLE]
	set DIMENSION3_ = '5331U01'
	where DATAAREAID = 'HMPH' and accountnum = 'HMPH-Halfen Moment SDN BHD'

	-- Isedio Australien

	
	insert [int_axbi].[CUSTTABLE]
	select distinct
	DATAAREAID,
	'ISAU-' + ACCOUNTNUM,
	NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' '
	from [int_axbi].[CUSTTABLE]_ISAU$_bulk

	update [int_axbi].[CUSTTABLE]
	set DIMENSION3_ = '2173U01',
	    INOUT = 'I'
	where DATAAREAID = 'ISAU' and NAME = 'Isedio Ltd' 

    -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben.
	update [int_axbi].[CUSTTABLE]
	set CUSTTABLE.INOUT = 'O'
	from [int_axbi].[CUSTTABLE] as c
	left outer join [dbo].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID  
	where c.DATAAREAID = 'ISAU' and d.CRHCOMPANYID is null 

--old logic commented by Erich
    -- Halfen USA als OUTSIDE kennzeichnen
	--update [int_axbi].[CUSTTABLE]
	--set INOUT = 'O',
	--    CUSTOMERPILLAR = 'OTHER',
	--    DIMENSION3_ = '5330U01'
	--where DATAAREAID = 'ISAU' and NAME like '%Halfen USA%' 

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind.
	
	update [int_axbi].[CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISAU' and CUSTOMERPILLAR = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [int_axbi].[CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISAU' and INOUT = 'I'

    -- CUSTOMERPILLAR auf OTHER setzen
	update [int_axbi].[CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISAU' and CUSTOMERPILLAR = 'Other'

    -- Kunde Meadow Burke auf Inside setzen
	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	where NAME like '%MeadowBurke%' or NAME like '%Meadow Burke%' or NAME like '%Halfen USA%' 

    -- Kunde Scaldex auf Inside setzen
	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	 where NAME like '%Scaldex%'
*/
	--======================================================================

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen. Set all CUSTOMERPILLAR to OTHER that are empty. Except for Halfen
	update [int_axbi].[CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where substring(DATAAREAID, 1, 2) <> 'HA' and CUSTOMERPILLAR = ' ' 

    -- Alle LEVIAT Kunden auf Inside setzen, außer Meadow Burke
	update [int_axbi].[CUSTTABLE]
	set INOUT = 'I'
	where NAME like '%Leviat%' and NAME not like '%Meadow Burke%' and NAME not like '%MeadowBurke%'

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [int_axbi].[CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where INOUT = 'I' 

	--------	itemgroup table AX-BI	-------------------

	-- Halfen
	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'HALF'
	insert [int_axbi].[ITEMGROUP]
	select 'HALF', 'HALF-' + PRODUCTLINEID, 'HALF-' + PRODUCTLINEDESC from [DW_HALFEN_0_HLP_UAT].dbo.PRODUCTLINE order by PRODUCTLINEID

	-- Plaka BE
	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'PLBE'
	insert [int_axbi].[ITEMGROUP]
	select 'PLBE', 'PLBE-' + ITEMGROUP4, 'PLBE-' + DESCRIPTION from [TX_CRH_2_DWH_UAT].dbo.DIM_ADUASCHWITEMGROUP4 where DATAAREAID = 'plb' and DESCRIPTION <> ' ' and DESCRIPTION is not null group by DATAAREAID, ITEMGROUP4, DESCRIPTION order by DATAAREAID, ITEMGROUP4, DESCRIPTION

	-- Plaka FR
	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'PLFR'
	insert [int_axbi].[ITEMGROUP]
	select 'PLFR', 'PLFR-' + ITEMGROUP4, 'PLFR-' + DESCRIPTION from [TX_CRH_2_DWH_UAT].dbo.DIM_ADUASCHWITEMGROUP4 where DATAAREAID = 'plf' and DESCRIPTION <> ' ' and DESCRIPTION is not null group by DATAAREAID, ITEMGROUP4, DESCRIPTION order by DATAAREAID, ITEMGROUP4, DESCRIPTION

	-- Aschwanden
	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ASCH'
	insert [int_axbi].[ITEMGROUP]
	select 'ASCH', 'ASCH-' + ITEMGROUP4, 'ASCH-' + DESCRIPTION from [TX_CRH_2_DWH_UAT].dbo.DIM_ADUASCHWITEMGROUP4 where DATAAREAID = 'ass' and DESCRIPTION <> ' ' and DESCRIPTION is not null group by DATAAREAID, ITEMGROUP4, DESCRIPTION order by DATAAREAID, ITEMGROUP4, DESCRIPTION

	-- Ancon D-A-CH
	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ANAT'
	insert [int_axbi].[ITEMGROUP]
	select 'ANAT', 'ANAT-' + ITEMGROUPID, 'ANAT-' + ITEMGROUPNAME from [TX_CRH_1_STG_UAT].dbo.AX_CRH_A_dbo_INVENTTABLE where DATAAREAID = 'anat' group by ITEMGROUPID, ITEMGROUPNAME order by ITEMGROUPID, ITEMGROUPNAME

	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ANCH'
	insert [int_axbi].[ITEMGROUP]
	select 'ANCH', 'ANCH-' + ITEMGROUPID, 'ANCH-' + ITEMGROUPNAME from [TX_CRH_1_STG_UAT].dbo.AX_CRH_A_dbo_INVENTTABLE where DATAAREAID = 'anch' group by ITEMGROUPID, ITEMGROUPNAME order by ITEMGROUPID, ITEMGROUPNAME

	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ANDE'
	insert [int_axbi].[ITEMGROUP]
	select 'ANDE', 'ANDE-' + ITEMGROUPID, 'ANDE-' + ITEMGROUPNAME from [TX_CRH_1_STG_UAT].dbo.AX_CRH_A_dbo_INVENTTABLE where DATAAREAID = 'ande' group by ITEMGROUPID, ITEMGROUPNAME order by ITEMGROUPID, ITEMGROUPNAME

--out of sprint 32
/*
	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ANAC'
	insert [int_axbi].[ITEMGROUP]
	select distinct 'ANAC', 'ANAC-' + CAST(STOCKGROUP as NVARCHAR(2)), 'ANAC-' + GROUPNAME from [dbo].[ITEMTABLE_ANAC$] group by 'ANAC-' + CAST(STOCKGROUP as NVARCHAR(2)), 'ANAC-' + GROUPNAME order by 'ANAC-' + CAST(STOCKGROUP as NVARCHAR(2)), 'ANAC-' + GROUPNAME
*/

	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ANAU'
	insert [int_axbi].[ITEMGROUP]
	select 'ANAU', 'ANAU-' + ITEMGROUPID, 'ANAU-' + NAME from [ANCON_AUSTRALIA_2_DWH_UAT].[dbo].[DIM_ITEMGROUP] where DATAAREAID = 'vmd'

	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ANAH'
	insert [int_axbi].[ITEMGROUP]
	select 'ANAH', 'ANAH-' + ITEMGROUPID, 'ANAH-' + NAME from [ANCON_AUSTRALIA_2_DWH_UAT].[dbo].[DIM_ITEMGROUP] where DATAAREAID = 'vmd'

	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ANNZ'
	insert [int_axbi].[ITEMGROUP]
	select 'ANNZ', 'ANNZ-' + ITEMGROUPID, 'ANNZ-' + NAME from [ANCON_AUSTRALIA_2_DWH_UAT].[dbo].[DIM_ITEMGROUP] where DATAAREAID = 'vmd'

--out of sprint 32
/*
	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ANUK'
	insert [int_axbi].[ITEMGROUP]
	select 'ANUK', 'ANUK-' + ITEMGROUPID, 'ANUK-' + ITEMGROUPNAME from [dbo].[MAPPING_ITEMGROUP_ANUK$_bulk]
*/

--out of sprint 32
/*
	delete [int_axbi].[ITEMGROUP] where DATAAREAID = 'ISUK'
	insert [int_axbi].[ITEMGROUP]
	select 'ISUK', 'ISUK-' + ITEMGROUPID, 'ISUK-' + ITEMGROUPNAME from [dbo].[MAPPING_ITEMGROUP_ANUK$_bulk]
*/

	-- itemgroup ISAU manuell hinzugefügt. Nicht löschen --

	--------	item table AX-BI	-------------------

	truncate table [int_axbi].[ITEMTABLE]
	
	-- transfer item main table HALFEN to main table AX-BI ITEMTABLE

	insert [int_axbi].[ITEMTABLE]
	select distinct
	'HALF',
	'HALF-' + [Item no],
	[Item description],
	case when [CRHPRODUCTGROUPID] is null then ' ' else [CRHPRODUCTGROUPID] end,
	'HALF-' + [Product line]
	from [DW_HALFEN_2_DWH_UAT].dbo.DIM_ARTICLE
	where [Item no] <> ' ' -- ohne Dummy Artikel blank 

	-- Dummy article for the Budget
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-O.1.', 'CONSTRUCTION FOILS', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-O.2.', 'DRAINAGE FOILS', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HALF', 'HALF-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'K.3.', ' ')
	
	-- Ancon AT, CH, DE Aschwanden CH Plaka BE, FR

	insert [int_axbi].[ITEMTABLE]
	select distinct
	case when [DATAAREAID] = 'anat' then 'ANAT'
	     when [DATAAREAID] = 'anch' then 'ANCH'
		 when [DATAAREAID] = 'ande' then 'ANDE'
		 when [DATAAREAID] = 'ass' then 'ASCH'
		 when [DATAAREAID] = 'plb' then 'PLBE'
		 when [DATAAREAID] = 'plf' then 'PLFR'
	end,
	case when [DATAAREAID] = 'anat' then 'ANAT-' + [ITEMID]
	     when [DATAAREAID] = 'anch' then 'ANCH-' + [ITEMID]
		 when [DATAAREAID] = 'ande' then 'ANDE-' + [ITEMID]
		 when [DATAAREAID] = 'ass' then 'ASCH-' + [ITEMID]
		 when [DATAAREAID] = 'plb' then 'PLBE-' + [ITEMID]
		 when [DATAAREAID] = 'plf' then 'PLFR-' + [ITEMID]
	end,
	[ITEMNAME],
	substring([ADUTYPECRHCA], 1, 4),
	case when [DATAAREAID] = 'anat' then 'ANAT-' + [ITEMGROUPID]
	     when [DATAAREAID] = 'anch' then 'ANCH-' + [ITEMGROUPID]
		 when [DATAAREAID] = 'ande' then 'ANDE-' + [ITEMGROUPID]
		 when [DATAAREAID] = 'ass' then 'ASCH-'  + [ADUASCHWITEMGROUP4]
		 when [DATAAREAID] = 'plb' then 'PLBE-'  + [ADUASCHWITEMGROUP4]
		 when [DATAAREAID] = 'plf' then 'PLFR-'  + [ADUASCHWITEMGROUP4]
	end
	from [TX_CRH_2_DWH_UAT].dbo.DIM_INVENTTABLE where DATAAREAID in ('anat', 'anch', 'ande', 'ass', 'plb', 'plf')

	-- Dummy article for the Budget
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLBE', 'PLBE-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('PLFR', 'PLFR-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ASCH', 'ASCH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAT', 'ANAT-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANCH', 'ANCH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANDE', 'ANDE-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	-- Korrektur leere Itemgroups
	update [int_axbi].[ITEMTABLE]
	set ITEMGROUPID = ' '
	where ITEMGROUPID = 'PLBE-'

	-- Korrektur R.x. Itemgroups
	update [int_axbi].[ITEMTABLE]
	set PRODUCTGROUPID = 'N.1.'
	where DATAAREAID in ('PLBE', 'PLFR') and PRODUCTGROUPID in ('R.1.','R.6.','R.7.','R.9.') 
	update [int_axbi].[ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where DATAAREAID in ('PLBE', 'PLFR') and PRODUCTGROUPID = 'R.3.' 

	-- Ancon AU, NZ, Helifix

	insert [int_axbi].[ITEMTABLE]
	select distinct
	case when [DATAAREAID] = 'anau' then 'ANAU'
	     when [DATAAREAID] = 'hlau' then 'ANAH'
	     when [DATAAREAID] = 'hlnz' then 'ANNZ'
	End,
	case when [DATAAREAID] = 'anau' then 'ANAU-' + [ITEMID]
	     when [DATAAREAID] = 'hlau' then 'ANAH-' + [ITEMID]
	     when [DATAAREAID] = 'hlnz' then 'ANNZ-' + [ITEMID]
	End,
	[ITEMNAME],
	substring([ADUTYPECRHCA], 1, 4),
	case when [DATAAREAID] = 'anau' then 'ANAU-' + ISNULL([ITEMGROUPID], ' ')
	     when [DATAAREAID] = 'hlau' then 'ANAH-' + ISNULL([ITEMGROUPID], ' ')
		 when [DATAAREAID] = 'hlnz' then 'ANNZ-' + ISNULL([ITEMGROUPID], ' ')
	end
	from [base_ancon_australia_2_dwh].[DIM_INVENTTABLE] where DATAAREAID in ('anau', 'hlau', 'hlnz')

	-- Dummy article for the Budget
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAU', 'ANAU-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAH', 'ANAH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANNZ', 'ANNZ-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	-- Korrektur leere Itemgroups
	update [int_axbi].[ITEMTABLE]
	set ITEMGROUPID = ' '
	where ITEMGROUPID in ('ANAU-', 'ANAH-', 'ANNZ-')
		
	-- Ancon UK
--out of sprint 32
/*
	insert [int_axbi].[ITEMTABLE]
	select distinct
	[DATAAREAID],
	'ANUK-' + [ITEMID],
	[ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
	ISNULL('ANUK-' + [ITEMGROUPID], ' ')
	from dbo.[ITEMTABLE_ANUK$_bulk]

	update [int_axbi].[ITEMTABLE]
	set PRODUCTGROUPID = 'A.4.'
	where DATAAREAID = 'ANUK' and ITEMGROUPID = 'ANUK-HELI'  

	-- Dummy article for the Budget
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANUK', 'ANUK-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert ITEMTABLE
	select distinct
	c.DATAAREAID,
	c.ITEMID,
	'Missing Article in Itemtable',
	'N.3.',
	'ANUK-OTH'
	from CUSTINVOICETRANS as c
	left outer join ITEMTABLE as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ITEMID = i.ITEMID
	where c.DATAAREAID = 'ANUK' and i.ITEMID is null	
*/

	-- Ancon Australia CONNOLLY
--out of sprint 32
/*
	insert [int_axbi].[ITEMTABLE]
	select distinct
	[DATAAREAID],
	'ANAC-' + [ITEMID],
	ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	ISNULL('ANAC-' + Cast([STOCKGROUP] as nvarchar(2)), ' ')
	from dbo.[ITEMTABLE_ANAC$]

	-- Dummy article for the Budget
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANAC', 'ANAC-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')

	insert ITEMTABLE
	select distinct
	c.DATAAREAID,
	c.ITEMID,
	'Missing Article in Itemtable',
	'N.3.',
	'ANAC-0'
	from CUSTINVOICETRANS as c
	left outer join ITEMTABLE as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ITEMID = i.ITEMID
	where c.DATAAREAID = 'ANAC' and i.ITEMID is null
*/
	
	-- Ancon Middle East
--out of sprint 32
/*
	insert [int_axbi].[ITEMTABLE]
	select distinct
	'ANME',
	[ITEMID],
	'ANME-' + ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	' '
	from dbo.[ITEMTABLE_ANME$_bulk]

	-- Dummy article for the Budget
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ANME', 'ANME-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
*/

	-- Ancon Isedio UK
--out of sprint 32
/*
	insert [int_axbi].[ITEMTABLE]
	select distinct
	[DATAAREAID],
	[ITEMID],
	[ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
	ISNULL('ANUK-' + [ITEMGROUPID], ' ')
	from dbo.[ITEMTABLE_ISUK$_bulk]

	update [int_axbi].[ITEMTABLE]
	set PRODUCTGROUPID = 'A.4.'
	where DATAAREAID = 'ISUK' and ITEMGROUPID = 'ANUK-HELI'  

	-- Dummy article for the Budget
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISUK', 'ISUK-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
*/

	-- Halfen Moment Malaysia
--out of sprint 32
/*
	insert [int_axbi].[ITEMTABLE]
	select distinct
	'HMMY',
	'HMMY-' + [ITEMID],
	'HMMY-' + ISNULL([ITEMNAME], ' '),
	ISNULL([PRODUCTGROUPID], ' '),
	'HMMY-' + [ITEMGROUPID]
	from dbo.[ITEMTABLE_HMMY$_bulk]

	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMMY', 'HMMY-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
*/

	-- Halfen Moment Singapur
--out of sprint 32
/*
	insert [int_axbi].[ITEMTABLE]
	select distinct
	'HMSG',
	'HMSG-' + [ITEMID],
	'HMSG-' + ISNULL([ITEMNAME], ' '),
	ISNULL([PRODUCTGROUPID], ' '),
	'HMSG-' + [ITEMGROUPID]
	from dbo.[ITEMTABLE_HMSG$_bulk]

	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMSG', 'HMSG-103-09XX-XX0003', 'HMSG-103-09XX-XX0003', 'N.3.', ' ')
*/

	-- Halfen Indien
--out of sprint 32
/*
	insert [int_axbi].[ITEMTABLE]
	select distinct
	'HMIN',
	[ITEMID],
	'HMIN-' + ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	' '
	from dbo.[ITEMTABLE_HMIN$_bulk]

	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-Moment Red Coupler 16mm-12mm', 'HMIN-Moment Reducer Coupler 16mm-12mm', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-Moment Red Coupler 20mm-12mm', 'HMIN-Moment Reducer Coupler 20mm-12mm', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-Moment Red Coupler 25mm-12mm', 'HMIN-Moment Reducer Coupler 25mm-12mm', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-Moment Red Coupler 32mm-12mm', 'HMIN-Moment Reducer Coupler 32mm-12mm', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMIN', 'HMIN-Moment Red Coupler 40mm-12mm', 'HMIN-Moment Reducer Coupler 40mm-12mm', 'E.2.', ' ')
*/

	-- Halfen Philippinen
--out of sprint 32
/*
	insert [int_axbi].[ITEMTABLE]
	select distinct
	'HMPH',
	[ITEMID],
	'HMPH-' + ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	' '
	from dbo.[ITEMTABLE_HMPH$_bulk]

	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('HMPH', 'HMPH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
*/

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [int_axbi].[ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where PRODUCTGROUPID = ' ' 

--old logic commented by Erich
	/* -- Alle ANUK Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [int_axbi].[ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where PRODUCTGROUPID < 'A.1.' */

	-- Isedio Australien
--out of sprint 32
/*	
	insert [int_axbi].[ITEMTABLE]
	select distinct
	[DATAAREAID],
	'ISAU-' + [ITEMID],
	'ISAU-' + [ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
	ISNULL('ISAU-' + [STOCKGROUP], ' ')
	from dbo.[ITEMTABLE_ISAU$_bulk]

	-- Dummy article for the Budget
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-A.3.', 'MURFOR', 'A.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-A.4.', 'HELIFIX', 'A.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-C.3.', 'PLASTIC', 'C.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-C.4.', 'STEEL', 'C.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-D.1.', 'BALCONY INSULATION', 'D.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.8.', 'COLUMN SHOE', 'E.8.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-E.9.', 'POST TENSION', 'E.9.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-F.4.', 'MAGNETS', 'F.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-G.1.', 'DILATATION JOINTS', 'G.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-H.1.', 'LOOPING DEVICES', 'H.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-I.3.', 'BOLTS', 'I.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-I.4.', 'INSERTS', 'I.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-I.6.', 'FRAMING', 'I.6.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-I.7.', 'OTHER FIXING', 'I.7.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-K.3.', 'OTHERS', 'K.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-L.1.', 'MORTARS & PASTES', 'L.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-N.3.', 'OTHERS', 'N.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ')
	insert into [int_axbi].[ITEMTABLE] VALUES('ISAU', 'ISAU-ARMOURFIXEND', 'ISAU-ARMOURFIXEND', 'G.1.', 'ISAU-2')

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [int_axbi].[ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where DATAAREAID = 'ISAU' and PRODUCTGROUPID = ' ' 
*/
END

