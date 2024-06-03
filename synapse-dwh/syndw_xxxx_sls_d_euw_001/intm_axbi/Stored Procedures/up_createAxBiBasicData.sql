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
CREATE PROCEDURE [intm_axbi].[up_createAxBiBasicData] 
	-- Add the parameters for the stored procedure here
(
	@t_jobId varchar(36),
	@t_jobDtm datetime, 
	@t_jobBy nvarchar(128),
	@axbiDataBaseEnvSuffix nvarchar(4) 
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--------	customer table AX-BI	-------------------
	
	-- transfer customer main table ANCON, ASCHWANDEN, HALFEN, PLAKA to main table AX-BI CUSTTABLE

	truncate table [intm_axbi].[dim_CUSTTABLE]

	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
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
	ISNULL(DIMENSION3_, ' '),
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm
	from [base_dw_halfen_0_hlp].[CUSTOMER] where DATAAREAID in ('5307', '5309', '5310', '5325', -- ohne Halfen USA 5330
                                                                '5300', '5302', '5303', '5308', '5311', '5313', '5314', '5315', '5316', '5317', '5320', '5321', '5327')

	-- Ancon AT, CH, DE Aschwanden CH Plaka BE, FR

	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	case LOWER(DATAAREAID)
	--when 'anat' then 'ANAT'
	--when 'anch' then 'ANCH'
	--when 'ande' then 'ANDE'
	--when 'ass' then 'ASCH'
	when 'plb' then 'PLBE'
	when 'plf' then 'PLFR'
	end,
	case LOWER(DATAAREAID)
	/*when 'anat' then 'ANAT-' + ACCOUNTNUM
	when 'anch' then 'ANCH-' + ACCOUNTNUM
	when 'ande' then 'ANDE-' + ACCOUNTNUM
	when 'ass' then 'ASCH-' + ACCOUNTNUM*/
	when 'plb' then 'PLBE-' + ACCOUNTNUM
	when 'plf' then 'PLFR-' + ACCOUNTNUM
	end,
	NAME,
	'O',
	case LOWER(DATAAREAID)
	/*when 'ass' then
		Case SEGMENTID
		when 'PRECAST' then 'PRECAST'
		else 'OTHER' end*/
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
	ISNULL([Chaintouse], ' '),
	ISNULL(DIMENSION3_, ' '),
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm
	from [base_tx_crh_1_stg].[AX_CRH_A_dbo_CUSTTABLE] where LOWER(DATAAREAID) in ('plb', 'plf')

--old logic commented by Erich
	/* update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = 'S059U01'
	where DATAAREAID = 'PLBE' and ACCOUNTNUM in ('PLBE-I_050-055', 'PLBE-I_050-057') */

	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = 'S060U01'
	where UPPER(DATAAREAID) = 'PLFR' and ACCOUNTNUM in ('PLFR-I_101-063', 'PLFR-I_102-061')

	delete from [intm_axbi].[dim_CUSTTABLE]
	where UPPER(DATAAREAID) ='PLBE' and ACCOUNTNUM in ('PLBE-11120', 'PLBE-3562', 'PLBE-49249', 'PLBE-I_505')

--old logic commented by Erich
	--delete from [intm_axbi].[dim_CUSTTABLE]
	--where DATAAREAID ='PLBE' and ACCOUNTNUM like '%PLBE-I_050%'

	delete from [intm_axbi].[dim_CUSTTABLE]
	where UPPER(DATAAREAID) ='PLFR' and ACCOUNTNUM in ('PLFR-11243', 'PLFR-I_050', 'PLFR-I_505')

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('PLBE', 'PLFR') and  UPPER(substring(NAME, 1, 5)) = 'ANCON'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('PLBE', 'PLFR') and  UPPER(substring(NAME, 1, 5)) = 'PLAKA'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('PLBE', 'PLFR') and  UPPER(substring(NAME, 1, 6)) = 'HALFEN'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('PLBE', 'PLFR') and  UPPER(NAME) like '%ASCHWANDEN%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('PLBE', 'PLFR') and  UPPER(NAME) like '%HELIFIX (AUSTRALIA)%'

	-- Ancon AU, NZ

	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	case LOWER(DATAAREAID)
	when 'anau' then 'ANAU'
	when 'hlau' then 'ANAH'
	when 'hlnz' then 'ANNZ'
	end,
	case LOWER(DATAAREAID)
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
	ISNULL(DIMENSION3_, ' '),
    t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm
	from [base_ancon_australia_2_dwh].[DIM_CUSTTABLE] where LOWER(DATAAREAID) in ('anau', 'hlau', 'hlnz')

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('ANAU', 'ANAH', 'ANNZ') and  substring(NAME, 1, 5) = 'Ancon'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('ANAU', 'ANAH', 'ANNZ') and  substring(NAME, 1, 5) = 'Plaka'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('ANAU', 'ANAH', 'ANNZ') and  substring(NAME, 1, 6) = 'Halfen'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('ANAU', 'ANAH', 'ANNZ') and  NAME like '%Aschwanden%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where UPPER(DATAAREAID) in ('ANAU', 'ANAH', 'ANNZ') and  NAME like '%Helifix (Australia)%'

	-- Ancon UK

	update [base_ancon_uk].[CUSTTABLE_ANUK]
	set DIMENSION3_ = ' '
	where DATAAREAID = 'ANUK' and DIMENSION3_ is null 

	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	DATAAREAID,
	'ANUK-' + CUSTOMERID,
	CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	DIMENSION3_,
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_ancon_uk].[CUSTTABLE_ANUK]

	-- Ancon Australia CONNOLLY


	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	DATAAREAID,
	'ANAC-' + CAST([ACCOUNTNUM] as nvarchar),
	[NAME],
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' ',
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_ancon_conolly_aus].[CUSTTABLE_ANAC]

	delete from [intm_axbi].[dim_ITEMTABLE] where PRODUCTGROUPID = 'SCRAP'
	delete from [base_ancon_uk].[ITEMTABLE_ANUK] where [CRH PRODUCTGROUPID] = 'SCRAP'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  substring(NAME, 1, 5) = 'Ancon'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  substring(NAME, 1, 5) = 'Plaka'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  substring(NAME, 1, 6) = 'Halfen'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  NAME like '%Aschwanden%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ANAC' and  NAME like '%Helifix (Australia)%'


--old logic commented by Erich
	/*
	update [intm_axbi].[dim_CUSTTABLE]
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
	from  [intm_axbi].[dim_CUSTTABLE] as u where DATAAREAID = 'ANUK'
	*/
	
    -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben. Mark all customers as OUTSIDE who have no entry in the DATAAREA table.


	update [intm_axbi].[dim_CUSTTABLE]
	set [INOUT] = 'O'
	from [intm_axbi].[dim_CUSTTABLE] as c
	left outer join [base_tx_ca_0_hlp].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID  
	where c.DATAAREAID = 'ANUK' and d.CRHCOMPANYID is null 


	-- Ancon Middle East
	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'ANME',
	CUSTOMERID,
	'ANME-' + CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' ',
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_ancon_me].[CUSTTABLE_ANME]

	-- Ancon Isedio UK
	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	DATAAREAID,
	'ISUK-' + CUSTOMERID,
	CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	ISNULL(DIMENSION3_,' '),
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_isedio].[CUSTTABLE_ISUK]

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Isedio%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Ancon%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Plaka%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Halfen%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Aschwanden%'

	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where DATAAREAID = 'ISUK' and NAME like '%Helifix (Australia)%'


	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ =
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
			when 'Halfen GmbH'  then '5300U01'
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
	from  [intm_axbi].[dim_CUSTTABLE] as u where DATAAREAID = 'ISUK'

	-- Bereiningung INSIDE CRH Company Spalte DIMENSION3_ 
	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = ' '
	 where DATAAREAID = 'ISUK' and DIMENSION3_ = '999999'

    -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben.
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O'
	from [intm_axbi].[dim_CUSTTABLE] as c
	left outer join [base_tx_ca_0_hlp].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID  
	where c.DATAAREAID = 'ISUK' and d.CRHCOMPANYID is null 

    -- Halfen USA als OUTSIDE kennzeichnen
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O',
	    CUSTOMERPILLAR = 'OTHER',
	    DIMENSION3_ = '5330U01'
	where DATAAREAID = 'ISUK' and UPPER(NAME) like '%HALFEN USA%' 

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISUK' and ISNULL(CUSTOMERPILLAR, ' ') = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISUK' and INOUT = 'I' 

	-- Bereiningung INSIDE CRH Company Spalte DIMENSION3_ 
	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = ' '
	 where DIMENSION3_ = '999999'

    -- Halfen USA als OUTSIDE kennzeichnen
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O',
	    CUSTOMERPILLAR = 'OTHER',
	    DIMENSION3_ = '5330U01'
	where DATAAREAID = 'ANUK' and UPPER(NAME) like '%HALFEN USA%' 

	--======================================================================

	-- Halfen Moment Malaysia
	
	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HMMY',
	'HMMY-' + ACCOUNTNUM,
	'HMMY-' + NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	ISNULL(DIMENSION3_,' '),
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_halfen_moment_my].[CUSTTABLE_HMMY]

	-- Halfen Moment Singapur
	
	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HMSG',
	'HMSG-' + ACCOUNTNUM,
	'HMSG-' + NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	ISNULL(DIMENSION3_,' '),
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_halfen_moment_sg].[CUSTTABLE_HMSG]

	-- Halfen Moment Indien

	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HMIN',
	CUSTOMERID,
	'HMIN-' + CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' ',
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_halfen_moment_in].[CUSTTABLE_HMIN]

	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = case ACCOUNTNUM
						 when 'HMIN-Halfen Internat' then '5302U01'
						 when 'HMIN-Halfen Mom MY' then '5331U01'
						 when 'HMIN-Halfen Mom SG' then '5333U01'
						 else ' ' end
	where DATAAREAID = 'HMIN' 

	-- Halfen Moment Philippinen

	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HMPH',
	CUSTOMERID,
	'HMPH-' + CUSTOMERNAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' ',
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_halfen_moment_ph].[CUSTTABLE_HMPH]

	-- Fehlenden Kunden eintragen
	DECLARE @t_applicationId_HMPH varchar(20) 
	SET @t_applicationId_HMPH = 'halfen-moment-ph'

	insert into [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
    VALUES('HMPH', 'HMPH-Freyfil Corporation- Limamburao', 'HMPH-Freyfil Corporation- Limamburao', 'O', 'OTHER', ' ', ' ', @t_applicationId_HMPH, @t_jobId, @t_jobDtm ,@t_jobBy, NULL)


    -- DIMENSION3_ versorgen
	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = '5331U01'
	where DATAAREAID = 'HMPH' and ACCOUNTNUM = 'HMPH-Halfen Moment SDN BHD'

	-- Isedio Australien

	
	insert [intm_axbi].[dim_CUSTTABLE]
	(DATAAREAID
    ,ACCOUNTNUM
    ,NAME
    ,INOUT
    ,CUSTOMERPILLAR
    ,COMPANYCHAINID
    ,DIMENSION3_
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	DATAAREAID,
	'ISAU-' + ACCOUNTNUM,
	NAME,
	INOUT,
	CUSTOMERPILLAR,
	' ',
	' ',
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_isedio_aus].[CUSTTABLE_ISAU]

	update [intm_axbi].[dim_CUSTTABLE]
	set DIMENSION3_ = '2173U01',
	    INOUT = 'I'
	where DATAAREAID = 'ISAU' and NAME = 'Isedio Ltd' 

    -- Alle Kunden als OUTSIDE kennzeichnen, die keinen Eintrag in der DATAAREA Tabelle haben.
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'O'
	from [intm_axbi].[dim_CUSTTABLE] as c
	left outer join [base_tx_ca_0_hlp].[DATAAREA] as d
	on c.DIMENSION3_ = d.CRHCOMPANYID  
	where c.DATAAREAID = 'ISAU' and d.CRHCOMPANYID is null 

--old logic commented by Erich
    -- Halfen USA als OUTSIDE kennzeichnen
	--update [intm_axbi].[dim_CUSTTABLE]
	--set INOUT = 'O',
	--    CUSTOMERPILLAR = 'OTHER',
	--    DIMENSION3_ = '5330U01'
	--where DATAAREAID = 'ISAU' and NAME like '%Halfen USA%' 

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind.
	
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISAU' and ISNULL(CUSTOMERPILLAR, ' ') = ' ' 

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISAU' and INOUT = 'I'

    -- CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where  DATAAREAID = 'ISAU' and CUSTOMERPILLAR = 'Other'

    -- Kunde Meadow Burke auf Inside setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where
        UPPER([NAME]) like '%MEADOWBURKE%'
        or
        UPPER([NAME]) like '%MEADOW BURKE%'
        or
        UPPER([NAME]) like '%HALFEN USA%'

    -- Kunde Scaldex auf Inside setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	 where NAME like '%Scaldex%'
	--======================================================================

    -- Alle CUSTOMERPILLAR auf OTHER setzen, die leer sind. Außer bei Halfen. Set all CUSTOMERPILLAR to OTHER that are empty. Except for Halfen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where substring(UPPER(DATAAREAID), 1, 2) <> 'HA' and ISNULL(CUSTOMERPILLAR, ' ') = ' ' 

    -- Alle LEVIAT Kunden auf Inside setzen, außer Meadow Burke
	update [intm_axbi].[dim_CUSTTABLE]
	set INOUT = 'I'
	where
        UPPER([NAME]) like '%LEVIAT%'
        and
        UPPER([NAME]) not like '%MEADOW BURKE%'
        and
        UPPER([NAME]) not like '%MEADOWBURKE%'

    -- Alle INSIDE customer column CUSTOMERPILLAR auf OTHER setzen
	update [intm_axbi].[dim_CUSTTABLE]
	set CUSTOMERPILLAR = 'OTHER'
	where INOUT = 'I' 

	--------	itemgroup table AX-BI	-------------------

	-- Halfen
	delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'HALF'
	insert [intm_axbi].[dim_ITEMGROUP]
	 (DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'HALF', 
	'HALF-' + PRODUCTLINEID, 
	'HALF-' + PRODUCTLINEDESC,
	 t_applicationId,
	 @t_jobId as t_jobId,
	 @t_jobDtm as t_jobDtm,
	 @t_jobBy as t_jobBy,
	 t_extractionDtm 
	from [base_dw_halfen_0_hlp].[PRODUCTLINE]

	-- Plaka BE
	delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'PLBE'
	insert [intm_axbi].[dim_ITEMGROUP] 
	 (DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'PLBE', 
	'PLBE-' + ITEMGROUP4, 
	'PLBE-' + DESCRIPTION,
	 t_applicationId,
	 @t_jobId as t_jobId,
	 @t_jobDtm as t_jobDtm,
	 @t_jobBy as t_jobBy,
	 t_extractionDtm 
	 from [base_tx_crh_2_dwh].[DIM_ADUASCHWITEMGROUP4] where LOWER(DATAAREAID) = 'plb' and DESCRIPTION <> ' ' and DESCRIPTION is not null group by DATAAREAID, ITEMGROUP4, DESCRIPTION, t_applicationId,t_extractionDtm

	-- Plaka FR
	delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'PLFR'
	insert [intm_axbi].[dim_ITEMGROUP] 
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'PLFR', 
	'PLFR-' + ITEMGROUP4, 
	'PLFR-' + DESCRIPTION,
	 t_applicationId,
	 @t_jobId as t_jobId,
	 @t_jobDtm as t_jobDtm,
	 @t_jobBy as t_jobBy,
	 t_extractionDtm 
	from [base_tx_crh_2_dwh].[DIM_ADUASCHWITEMGROUP4] where LOWER(DATAAREAID) = 'plf' and DESCRIPTION <> ' ' and DESCRIPTION is not null group by DATAAREAID, ITEMGROUP4, DESCRIPTION, t_applicationId,t_extractionDtm

	-- Aschwanden
	/*delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'ASCH'
	insert [intm_axbi].[dim_ITEMGROUP] 
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'ASCH', 
	'ASCH-' + ITEMGROUP4, 
	'ASCH-' + DESCRIPTION,
	 t_applicationId,
	 @t_jobId as t_jobId,
	 @t_jobDtm as t_jobDtm,
	 @t_jobBy as t_jobBy,
	 t_extractionDtm 
	from [base_tx_crh_2_dwh].[DIM_ADUASCHWITEMGROUP4] where LOWER(DATAAREAID) = 'ass' and DESCRIPTION <> ' ' and DESCRIPTION is not null group by DATAAREAID, ITEMGROUP4, DESCRIPTION
	*/

	-- Ancon D-A-CH
	/*delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'ANAT'
	insert [intm_axbi].[dim_ITEMGROUP] 
    (DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'ANAT', 
	'ANAT-' + ITEMGROUPID, 
	'ANAT-' + ItemGroupName,
	 t_applicationId,
	 @t_jobId as t_jobId,
	 @t_jobDtm as t_jobDtm,
	 @t_jobBy as t_jobBy,
	 t_extractionDtm 
	from [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTABLE] where LOWER(DATAAREAID) = 'anat' group by ITEMGROUPID, ItemGroupName
	*/
	/*
	delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'ANCH'
	insert [intm_axbi].[dim_ITEMGROUP] 
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'ANCH', 
	'ANCH-' + ITEMGROUPID, 
	'ANCH-' + ItemGroupName,
	 t_applicationId,
	 @t_jobId as t_jobId,
	 @t_jobDtm as t_jobDtm,
	 @t_jobBy as t_jobBy,
	 t_extractionDtm 
	from [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTABLE] where LOWER(DATAAREAID) = 'anch' group by ITEMGROUPID, ItemGroupName
	*/
	/*
	delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'ANDE'
	insert [intm_axbi].[dim_ITEMGROUP]
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'ANDE', 
	'ANDE-' + ITEMGROUPID, 
	'ANDE-' + ItemGroupName,
	 t_applicationId,
	 @t_jobId as t_jobId,
	 @t_jobDtm as t_jobDtm,
	 @t_jobBy as t_jobBy,
	 t_extractionDtm 
	from [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTABLE] where LOWER(DATAAREAID) = 'ande' group by ITEMGROUPID, ItemGroupName
	*/

	delete [intm_axbi].[dim_ITEMGROUP] where DATAAREAID = 'ANAC'
	insert [intm_axbi].[dim_ITEMGROUP]
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
        distinct 'ANAC',
        'ANAC-' + CAST(STOCKGROUP as NVARCHAR(2)),
        'ANAC-' + GROUPNAME,
		t_applicationId,
	 	@t_jobId as t_jobId,
	 	@t_jobDtm as t_jobDtm,
	 	@t_jobBy as t_jobBy,
	 	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
    from [base_ancon_conolly_aus].[ITEMTABLE_ANAC]
    group by 'ANAC-' + CAST(STOCKGROUP as NVARCHAR(2)), 'ANAC-' + GROUPNAME, t_applicationId, t_filePath

	delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'ANAU'
	insert [intm_axbi].[dim_ITEMGROUP] 
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'ANAU', 
	'ANAU-' + ITEMGROUPID, 
	'ANAU-' + NAME,
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm  
	from [base_ancon_australia_2_dwh].[DIM_ITEMGROUP] where LOWER(DATAAREAID) = 'vmd'

	delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'ANAH'
	insert [intm_axbi].[dim_ITEMGROUP] 
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'ANAH', 
	'ANAH-' + ITEMGROUPID, 
	'ANAH-' + NAME,
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm  
	from [base_ancon_australia_2_dwh].[DIM_ITEMGROUP] where LOWER(DATAAREAID) = 'vmd'

	delete [intm_axbi].[dim_ITEMGROUP] where UPPER(DATAAREAID) = 'ANNZ'
	insert [intm_axbi].[dim_ITEMGROUP] 
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select 
	'ANNZ', 
	'ANNZ-' + ITEMGROUPID, 
	'ANNZ-' + NAME,
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm   
	from [base_ancon_australia_2_dwh].[DIM_ITEMGROUP] where LOWER(DATAAREAID) = 'vmd'

	delete [intm_axbi].[dim_ITEMGROUP] where DATAAREAID = 'ANUK'
	insert [intm_axbi].[dim_ITEMGROUP]
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select
        'ANUK',
        'ANUK-' + ITEMGROUPID,
        'ANUK-' + ITEMGROUPNAME,
		t_applicationId,
		@t_jobId as t_jobId,
		@t_jobDtm as t_jobDtm,
		@t_jobBy as t_jobBy,
		REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm  
        from [base_ancon_uk].[MAPPING_ITEMGROUP_ANUK]

	delete [intm_axbi].[dim_ITEMGROUP] where DATAAREAID = 'ISUK'
	insert [intm_axbi].[dim_ITEMGROUP]
	(DATAAREAID
	 ,ITEMGROUPID
	 ,ITEMGROUPNAME
	 ,t_applicationId
	 ,t_jobId
	 ,t_jobDtm
	 ,t_jobBy
	 ,t_extractionDtm)
	select
        'ISUK',
        'ISUK-' + ITEMGROUPID,
        'ISUK-' + ITEMGROUPNAME,
		 t_applicationId,
		 @t_jobId as t_jobId,
		 @t_jobDtm as t_jobDtm,
		 @t_jobBy as t_jobBy,
		 REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm  
    from [base_ancon_uk].[MAPPING_ITEMGROUP_ANUK]


	-- itemgroup ISAU manuell hinzugefügt. Nicht löschen --

	--------	item table AX-BI	-------------------

	truncate table [intm_axbi].[dim_ITEMTABLE]
	
	-- transfer item main table HALFEN to main table AX-BI ITEMTABLE

	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HALF',
	'HALF-' + [Itemno],
	[Itemdescription],
	case when [CRHProductgroupid] is null then ' ' else [CRHProductgroupid] end,
	'HALF-' + [Productline],
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm
	from [base_dw_halfen_2_dwh].[DIM_ARTICLE]
	where [Itemno] <> ' ' -- ohne Dummy Artikel blank 

	
	-- Dummy article for the Budget
	DECLARE @t_applicationId_HALFEN varchar(50) 
	SET @t_applicationId_HALFEN = 'DW_HALFEN_0_HLP'+'_'+ @axbiDataBaseEnvSuffix

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
    insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-O.1.', 'CONSTRUCTION FOILS', 'K.1.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-O.2.', 'DRAINAGE FOILS', 'K.2.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID, t_applicationId,t_jobId,t_jobDtm,t_jobBy,t_extractionDtm) VALUES('HALF', 'HALF-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'K.3.', ' ',@t_applicationId_HALFEN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	
	
	-- Ancon AT, CH, DE Aschwanden CH Plaka BE, FR

	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
	,ITEMID
	,ITEMNAME
	,PRODUCTGROUPID
	,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	case LOWER([DATAAREAID])
	     /*when  'anat' then 'ANAT'
	     when  'anch' then 'ANCH'
		 when  'ande' then 'ANDE'
		 when  'ass'  then 'ASCH'*/
		 when  'plb'  then 'PLBE'
		 when  'plf'  then 'PLFR'
	end,
	case LOWER([DATAAREAID])
	     /*when 'anat' then 'ANAT-' + [ITEMID]
	     when 'anch' then 'ANCH-' + [ITEMID]
		 when 'ande' then 'ANDE-' + [ITEMID]
		 when 'ass'  then 'ASCH-' + [ITEMID]*/
		 when 'plb'  then 'PLBE-' + [ITEMID]
		 when 'plf'  then 'PLFR-' + [ITEMID]
	end,
	[ITEMNAME],
	substring([ADUTYPECRHCA], 1, 4),
	case LOWER([DATAAREAID])
	     /*when 'anat' then 'ANAT-' + [ITEMGROUPID]
	     when 'anch' then 'ANCH-' + [ITEMGROUPID]
		 when 'ande' then 'ANDE-' + [ITEMGROUPID]
		 when 'ass'  then 'ASCH-'  + [ADUASCHWITEMGROUP4]*/
		 when 'plb'  then 'PLBE-'  + [ADUASCHWITEMGROUP4]
		 when 'plf'  then 'PLFR-'  + [ADUASCHWITEMGROUP4]
	end,
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm
	from [base_tx_crh_2_dwh].[DIM_INVENTTABLE] where LOWER(DATAAREAID) in ('plb', 'plf')

	-- Dummy article for the Budget
    DECLARE @t_applicationId_CRH varchar(50) 
	SET @t_applicationId_CRH = 'TX_CRH_2_DWH'+'_'+ @axbiDataBaseEnvSuffix

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLBE', 'PLBE-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('PLFR', 'PLFR-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_CRH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

/*
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-A.3.', 'MURFOR', 'A.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-A.4.', 'HELIFIX', 'A.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-C.3.', 'PLASTIC', 'C.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-C.4.', 'STEEL', 'C.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.8.', 'COLUMN SHOE', 'E.8.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-E.9.', 'POST TENSION', 'E.9.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-F.4.', 'MAGNETS', 'F.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES', 'F.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-I.3.', 'BOLTS', 'I.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-I.4.', 'INSERTS', 'I.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-I.6.', 'FRAMING', 'I.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-I.7.', 'OTHER FIXING', 'I.7.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-K.3.', 'OTHERS', 'K.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-N.3.', 'OTHERS', 'N.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ASCH', 'ASCH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-A.3.', 'MURFOR', 'A.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-A.4.', 'HELIFIX', 'A.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-C.3.', 'PLASTIC', 'C.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-C.4.', 'STEEL', 'C.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-D.1.', 'BALCONY INSULATION', 'D.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.8.', 'COLUMN SHOE', 'E.8.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-E.9.', 'POST TENSION', 'E.9.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-F.4.', 'MAGNETS', 'F.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES', 'F.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-G.1.', 'DILATATION JOINTS', 'G.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-H.1.', 'LOOPING DEVICES', 'H.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-I.3.', 'BOLTS', 'I.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-I.4.', 'INSERTS', 'I.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-I.6.', 'FRAMING', 'I.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-I.7.', 'OTHER FIXING', 'I.7.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-K.3.', 'OTHERS', 'K.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-L.1.', 'MORTARS & PASTES', 'L.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-N.3.', 'OTHERS', 'N.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAT', 'ANAT-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-A.3.', 'MURFOR', 'A.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-A.4.', 'HELIFIX', 'A.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-C.3.', 'PLASTIC', 'C.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-C.4.', 'STEEL', 'C.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.8.', 'COLUMN SHOE', 'E.8.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-E.9.', 'POST TENSION', 'E.9.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-F.4.', 'MAGNETS', 'F.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-I.3.', 'BOLTS', 'I.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-I.4.', 'INSERTS', 'I.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-I.6.', 'FRAMING', 'I.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-I.7.', 'OTHER FIXING', 'I.7.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-K.3.', 'OTHERS', 'K.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-N.3.', 'OTHERS', 'N.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANCH', 'ANCH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-A.3.', 'MURFOR', 'A.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-A.4.', 'HELIFIX', 'A.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-C.3.', 'PLASTIC', 'C.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-C.4.', 'STEEL', 'C.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-D.1.', 'BALCONY INSULATION', 'D.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.8.', 'COLUMN SHOE', 'E.8.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-E.9.', 'POST TENSION', 'E.9.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-F.4.', 'MAGNETS', 'F.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-G.1.', 'DILATATION JOINTS', 'G.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-H.1.', 'LOOPING DEVICES', 'H.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-I.3.', 'BOLTS', 'I.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-I.4.', 'INSERTS', 'I.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-I.6.', 'FRAMING', 'I.6.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-I.7.', 'OTHER FIXING', 'I.7.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-K.3.', 'OTHERS', 'K.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-L.1.', 'MORTARS & PASTES', 'L.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-N.3.', 'OTHERS', 'N.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANDE', 'ANDE-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ','TX_CRH_2_DWH_PROD',@t_jobId,@t_jobDtm,@t_jobBy,NULL)
*/

	-- Korrektur leere Itemgroups
	update [intm_axbi].[dim_ITEMTABLE]
	set ITEMGROUPID = ' '
	where ITEMGROUPID = 'PLBE-'

	-- Korrektur R.x. Itemgroups
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.1.'
	where UPPER(DATAAREAID) in ('PLBE', 'PLFR') and PRODUCTGROUPID in ('R.1.','R.6.','R.7.','R.9.') 
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where UPPER(DATAAREAID) in ('PLBE', 'PLFR') and PRODUCTGROUPID = 'R.3.' 

	-- Ancon AU, NZ, Helifix

	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
	,ITEMID
	,ITEMNAME
	,PRODUCTGROUPID
	,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	case LOWER([DATAAREAID])
	     when 'anau' then 'ANAU'
	     when 'hlau' then 'ANAH'
	     when 'hlnz' then 'ANNZ'
	End,
	case LOWER([DATAAREAID])
	     when 'anau' then 'ANAU-' + [ITEMID]
	     when 'hlau' then 'ANAH-' + [ITEMID]
	     when 'hlnz' then 'ANNZ-' + [ITEMID]
	End,
	[ITEMNAME],
	substring([ADUTYPECRHCA], 1, 4),
	case LOWER([DATAAREAID])
	     when 'anau' then 'ANAU-' + ISNULL([ITEMGROUPID], ' ')
	     when 'hlau' then 'ANAH-' + ISNULL([ITEMGROUPID], ' ')
		 when 'hlnz' then 'ANNZ-' + ISNULL([ITEMGROUPID], ' ')
	end,
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	t_extractionDtm
	from [base_ancon_australia_2_dwh].[DIM_INVENTTABLE] where LOWER(DATAAREAID) in ('anau', 'hlau', 'hlnz')

	-- Dummy article for the Budget
	DECLARE @t_applicationId_ANCON_AUSTRALIA varchar(50) 
	SET @t_applicationId_ANCON_AUSTRALIA = 'ANCON_AUSTRALIA_2_DWH'+'_'+ @axbiDataBaseEnvSuffix

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAU', 'ANAU-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAH', 'ANAH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE] (DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANNZ', 'ANNZ-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_ANCON_AUSTRALIA,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	-- Korrektur leere Itemgroups
	update [intm_axbi].[dim_ITEMTABLE]
	set ITEMGROUPID = ' '
	where ITEMGROUPID in ('ANAU-', 'ANAH-', 'ANNZ-')
		
	-- Ancon UK
	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	[DATAAREAID],
	'ANUK-' + [ITEMID],
	[ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
	ISNULL('ANUK-' + [ITEMGROUPID], ' '),
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_ancon_uk].[ITEMTABLE_ANUK]

	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'A.4.'
	where DATAAREAID = 'ANUK' and UPPER(ITEMGROUPID) = 'ANUK-HELI'  

	-- Dummy article for the Budget
	DECLARE @t_applicationId_ANUK varchar(10) 
	SET @t_applicationId_ANUK = 'ancon-uk'

	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANUK', 'ANUK-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_ANUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	c.DATAAREAID,
	c.ITEMID,
	'Missing Article in Itemtable',
	'N.3.',
	'ANUK-OTH',
	c.t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	c.t_extractionDtm
	from [intm_axbi].[fact_CUSTINVOICETRANS] as c
	left outer join [intm_axbi].[dim_ITEMTABLE] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ITEMID = i.ITEMID
	where c.DATAAREAID = 'ANUK' and i.ITEMID is null	

	-- Ancon Australia CONNOLLY
	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	[DATAAREAID],
	'ANAC-' + [ITEMID],
	ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	ISNULL('ANAC-' + Cast([STOCKGROUP] as nvarchar(2)), ' '),
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_ancon_conolly_aus].[ITEMTABLE_ANAC]

	-- Dummy article for the Budget
	DECLARE @t_applicationId_ANAC varchar(20) 
	SET @t_applicationId_ANAC = 'ancon-conolly-aus'

	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANAC', 'ANAC-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_ANAC,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	c.DATAAREAID,
	c.ITEMID,
	'Missing Article in Itemtable',
	'N.3.',
	'ANAC-0',
	c.t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	c.t_extractionDtm
	from [intm_axbi].[fact_CUSTINVOICETRANS] as c
	left outer join [intm_axbi].[dim_ITEMTABLE] as i
	on c.DATAAREAID = i.DATAAREAID and
	   c.ITEMID = i.ITEMID
	where c.DATAAREAID = 'ANAC' and i.ITEMID is null
	
	-- Ancon Middle East
	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'ANME',
	[ITEMID],
	'ANME-' + ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	' ',
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_ancon_me].[ITEMTABLE_ANME]

	-- Dummy article for the Budget
	DECLARE @t_applicationId_ANME varchar(10) 
	SET @t_applicationId_ANME = 'ancon-me'

	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ANME', 'ANME-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_ANME ,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	-- Ancon Isedio UK

	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	[DATAAREAID],
	[ITEMID],
	[ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
    CASE
        WHEN ISNULL([ITEMGROUPID],' ')=' '
        THEN ' '
        ELSE 'ANUK-' + [ITEMGROUPID]
    END,
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_isedio].[ITEMTABLE_ISUK]

	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'A.4.'
	where DATAAREAID = 'ISUK' and UPPER(ITEMGROUPID) = 'ANUK-HELI'  

	-- Dummy article for the Budget
	DECLARE @t_applicationId_ISUK varchar(10) 
	SET @t_applicationId_ISUK = 'isedio'

	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISUK', 'ISUK-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_ISUK,@t_jobId,@t_jobDtm,@t_jobBy,NULL)


	-- Halfen Moment Malaysia
	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HMMY',
	'HMMY-' + [ITEMID],
	'HMMY-' + ISNULL([ITEMNAME], ' '),
	ISNULL([PRODUCTGROUPID], ' '),
	'HMMY-' + [ITEMGROUPID],
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_halfen_moment_my].[ITEMTABLE_HMMY]

	DECLARE @t_applicationId_HMMY varchar(20) 
	SET @t_applicationId_HMMY = 'halfen-moment-my'

	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMMY', 'HMMY-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_HMMY,@t_jobId,@t_jobDtm,@t_jobBy,NULL)


	-- Halfen Moment Singapur
	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HMSG',
	'HMSG-' + [ITEMID],
	'HMSG-' + ISNULL([ITEMNAME], ' '),
	ISNULL([PRODUCTGROUPID], ' '),
	'HMSG-' + [ITEMGROUPID],
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_halfen_moment_sg].[ITEMTABLE_HMSG]

	DECLARE @t_applicationId_HMSG varchar(20) 
	SET @t_applicationId_HMSG = 'halfen-moment-sg'

	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMSG', 'HMSG-103-09XX-XX0003', 'HMSG-103-09XX-XX0003', 'N.3.', ' ',@t_applicationId_HMSG,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	-- Halfen Indien
	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HMIN',
	[ITEMID],
	'HMIN-' + ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	' ',
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_halfen_moment_in].[ITEMTABLE_HMIN]

	DECLARE @t_applicationId_HMIN varchar(20) 
	SET @t_applicationId_HMIN = 'halfen-moment-in'

	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-Moment Red Coupler 16mm-12mm', 'HMIN-Moment Reducer Coupler 16mm-12mm', 'E.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-Moment Red Coupler 20mm-12mm', 'HMIN-Moment Reducer Coupler 20mm-12mm', 'E.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-Moment Red Coupler 25mm-12mm', 'HMIN-Moment Reducer Coupler 25mm-12mm', 'E.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-Moment Red Coupler 32mm-12mm', 'HMIN-Moment Reducer Coupler 32mm-12mm', 'E.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMIN', 'HMIN-Moment Red Coupler 40mm-12mm', 'HMIN-Moment Reducer Coupler 40mm-12mm', 'E.2.', ' ',@t_applicationId_HMIN,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	-- Halfen Philippinen
	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	'HMPH',
	[ITEMID],
	'HMPH-' + ISNULL([ITEMNAME], ' '),
	ISNULL([CRHPRODUCTGROUPID], ' '),
	' ',
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_halfen_moment_ph].[ITEMTABLE_HMPH]

	
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-H.2.', 'SPHERICAL HEAD ANCHCORS', 'H.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('HMPH', 'HMPH-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_HMPH,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where ISNULL(PRODUCTGROUPID, ' ') = ' ' 

--old logic commented by Erich
	/* -- Alle ANUK Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where PRODUCTGROUPID < 'A.1.' */

	-- Isedio Australien
	insert [intm_axbi].[dim_ITEMTABLE]
	(DATAAREAID
    ,ITEMID
    ,ITEMNAME
    ,PRODUCTGROUPID
    ,ITEMGROUPID
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select distinct
	[DATAAREAID],
	'ISAU-' + [ITEMID],
	'ISAU-' + [ITEMNAME],
	ISNULL([CRH PRODUCTGROUPID], ' '),
    CASE
        WHEN ISNULL([STOCKGROUP],' ')=' '
        THEN ' '
        ELSE 'ISAU-' + [STOCKGROUP]
    END,
	t_applicationId,
	@t_jobId as t_jobId,
	@t_jobDtm as t_jobDtm,
	@t_jobBy as t_jobBy,
	REPLACE(reverse(SUBSTRING(reverse(t_filePath),5,10)),'_','-') as t_extractionDtm
	from [base_isedio_aus].[ITEMTABLE_ISAU]

	-- Dummy article for the Budget
	DECLARE @t_applicationId_ISAU varchar(20) 
	SET @t_applicationId_ISAU = 'isedio-aus'

	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-A.1.', 'BRICKWORK SUPPORT', 'A.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-A.2.', 'WALL TIES & FIXINGS', 'A.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-A.3.', 'MURFOR', 'A.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-A.4.', 'HELIFIX', 'A.4.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-B.1.', 'NATURAL STONE FIXING', 'B.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-B.2.', 'CONCRETE FACADE SYSTEMS', 'B.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-B.3.', 'CURTAIN WALL SYSTEM', 'B.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-B.4.', 'OTHER FACADE PRODUCTS', 'B.4.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-C.1.', 'CONCRETE : WET CAST', 'C.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-C.2.', 'CONCRETE : FIBERS + EXTRUDED', 'C.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-C.3.', 'PLASTIC', 'C.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-C.4.', 'STEEL', 'C.4.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-D.1.', 'BALCONY INSULATION', 'D.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-D.2.', 'ACOUSTIC PANELS & FORMS', 'D.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-D.3.', 'ACOUSTIC COMPONENTS', 'D.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.1.', 'REBEND REINFORCEMENT', 'E.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.2.', 'REBAR COUPLERS + CONNECTORS', 'E.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.3.', 'INVISIBLE CONNECTION', 'E.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.4.', 'PUNCHING SHEAR', 'E.4.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.5.', 'STEEL REINFORCEMENT', 'E.5.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.6.', 'SYNTHETIC REINFORCEMENT', 'E.6.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.7.', 'SHEAR LOAD CONNECTOR', 'E.7.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.8.', 'COLUMN SHOE', 'E.8.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-E.9.', 'POST TENSION', 'E.9.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-F.1.', 'SINGLE-USE FORMWORK', 'F.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-F.2.', 'RE-USABLE FORMWORK', 'F.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-F.3.', 'TUBULAR COLUMNS', 'F.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-F.4.', 'MAGNETS', 'F.4.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-F.5.', 'OTHER FORMWORK ACC. (DYWIDAG; PLASTIC PROFILES)', 'F.5.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-G.1.', 'DILATATION JOINTS', 'G.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-G.2.', 'JOINT COVER & SEPARATION', 'G.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-H.1.', 'LOOPING DEVICES', 'H.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-H.2.', 'SPHERICAL HEAD ANCHORS', 'H.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-H.3.', 'FLAT STEEL ANCHORS', 'H.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-H.4.', 'THREADED SYSTEMS', 'H.4.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-H.5.', 'CHAINS AND CABLES', 'H.5.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-H.6.', 'OTHER LIFTING SYSTEMS', 'H.6.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-I.1.', 'CAST IN CHANNELS', 'I.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-I.2.', 'ANCHORING ACCESSORIES', 'I.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-I.3.', 'BOLTS', 'I.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-I.4.', 'INSERTS', 'I.4.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-I.5.', 'CHEMICAL ANCHORING', 'I.5.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-I.6.', 'FRAMING', 'I.6.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-I.7.', 'OTHER FIXING', 'I.7.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-J.1.', 'BUILDING & CONSTRUCTION BEARINGS', 'J.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-J.2.', 'CIVIL ENGINEERING BEARINGS', 'J.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-K.1.', 'WATERSTOP + INJECTION SYSTEM', 'K.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-K.2.', 'STRIPS & PROFILES', 'K.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-K.3.', 'OTHERS', 'K.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-L.1.', 'MORTARS & PASTES', 'L.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-L.2.', 'DEMOULDING AGENTS', 'L.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-L.3.', 'ADMIXTURES & GROUTS', 'L.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-L.4.', 'OTHER CHEMICAL PRODUCTS', 'L.4.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-M.1.', 'SITE EQUIPMENT', 'M.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-N.1.', 'TENSION ROD SYSTEMS', 'N.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-N.2.', 'HEAVY LOAD SYSTEMS', 'N.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-N.3.', 'OTHERS', 'N.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-O.1.', 'CONSTRUCTION FOILS', 'O.1.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-O.2.', 'DRAINAGE FOILS', 'O.2.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-O.3.', 'VAPOUR BARRIER FOILS + OTHERS', 'O.3.', ' ',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)
	insert into [intm_axbi].[dim_ITEMTABLE](DATAAREAID,ITEMID,ITEMNAME,PRODUCTGROUPID,ITEMGROUPID,t_applicationId,t_jobId,t_jobDtm,t_jobBy, t_extractionDtm) VALUES('ISAU', 'ISAU-ARMOURFIXEND', 'ISAU-ARMOURFIXEND', 'G.1.', 'ISAU-2',@t_applicationId_ISAU,@t_jobId,@t_jobDtm,@t_jobBy,NULL)

	-- Alle Artikel, die keinen CRH Productgroup Eintrag haben, auf N.3. setzen
	update [intm_axbi].[dim_ITEMTABLE]
	set PRODUCTGROUPID = 'N.3.'
	where DATAAREAID = 'ISAU' and PRODUCTGROUPID = ' ' 

END