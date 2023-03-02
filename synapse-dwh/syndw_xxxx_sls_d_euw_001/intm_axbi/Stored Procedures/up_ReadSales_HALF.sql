-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <31.07.2019>
-- Description:	<Übernahme Umsatzdaten Halfen für TX Construction Accessories>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_HALF] 
	-- Add the parameters for the stored procedure here
(
	@P_Year smallint,
	@P_Month tinyint,
	@t_jobId varchar(36),
	@t_jobDtm datetime, 
	@t_jobBy nvarchar(128) 

)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	-- Halfen

	delete from [intm_axbi].[fact_CUSTINVOICETRANS] where substring(DATAAREAID, 1, 2) = 'HA' and datepart(YYYY, ACCOUNTINGDATE) = @P_Year and datepart(MM, ACCOUNTINGDATE) = @P_Month

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
    ,COSTAMOUNTEUR
	,t_applicationId
	,t_jobId
	,t_jobDtm
	,t_jobBy
	,t_extractionDtm)
	select case DACONO
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
		   else DACONO end,
	DAORNO, DAIVNO, DAPONR, ISNULL(DASETK, ' '), DAACDT,
	 case DACONO
	       when '5300' then 'HADP-' + DACUNO
		   when '5302' then 'HAIN-' + DACUNO 
		   when '5303' then 'HADE-' + DACUNO 
		   when '5307' then 'HAFR-' + DACUNO 
		   when '5308' then 'HASE-' + DACUNO 
		   when '5309' then 'HABE-' + DACUNO 
		   when '5310' then 'HAUK-' + DACUNO 
		   when '5311' then 'HACH-' + DACUNO 
		   when '5313' then 'HAAT-' + DACUNO 
		   when '5314' then 'HANL-' + DACUNO 
		   when '5315' then 'HAIT-' + DACUNO 
		   when '5316' then 'HAPL-' + DACUNO 
		   when '5317' then 'HACZ-' + DACUNO 
		   when '5320' then 'HAES-' + DACUNO 
		   when '5321' then 'HAPP-' + DACUNO 
		   when '5325' then 'HANO-' + DACUNO 
		   when '5327' then 'HACN-' + DACUNO 
		   when '5330' then 'HAUS-' + DACUNO
		   else DACONO end,
	'HALF-' + DAITNO, substring(DADRID, 1, 2), ISNULL(DADLIX, ' '), ISNULL(DAIVQT,0), DASAAM, DASAAC, DAOSAL, DAOSAC, DAALOL, DAALOC, DA100L, DA100C, DAVSCL + isnull(DAVE10,0), DAVSCC + isnull(DCVE10,0), DAHCOS, DAHCOC,
	t_applicationId,
	@t_jobId,
	@t_jobDtm,
	@t_jobBy,
	t_extractionDtm
	from [base_dw_halfen_0_hlp].[HGDAWA] 
	where DACONO <> '5330' and DAJAHR = @P_Year and DAMONA = @P_Month -- Ohne Halfen USA 5330

END