-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <12.07.2019>
-- Description:	<Aufbau Artikel- und Kundenstamm für TX Construction Accessories>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_CollectSales_CA] 
	-- Add the parameters for the stored procedure here
(
	@P_Year smallint,
	@P_Month tinyint,
	@P_DelNotInv nvarchar(1),
	@t_jobId varchar(36),
	@t_jobDtm datetime, 
	@t_jobBy nvarchar(128),
	@axbiDataBaseEnvSuffix nvarchar(3)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    --logic commented by Erich
	/*EXEC intm_axbi.up_ReadSales_ANUK_pkg
	EXEC intm_axbi.up_ReadSales_ANAC_pkg
	EXEC intm_axbi.up_ReadSales_ANME_pkg*/

	EXEC intm_axbi.up_createAxBiBasicData @t_jobId, @t_jobDtm, @t_jobBy, @axbiDataBaseEnvSuffix

	EXEC intm_axbi.up_ReadSales_HALF @P_Year, @P_Month, @t_jobId, @t_jobDtm, @t_jobBy, @axbiDataBaseEnvSuffix

	EXEC intm_axbi.up_ReadSales_PLAKA_BE @P_Year, @P_Month, @P_DelNotInv, @t_jobId, @t_jobDtm, @t_jobBy, @axbiDataBaseEnvSuffix
	EXEC intm_axbi.up_ReadSales_PLAKA_FR @P_Year, @P_Month, @P_DelNotInv, @t_jobId, @t_jobDtm, @t_jobBy, @axbiDataBaseEnvSuffix

    --logic commented by Erich
	--EXEC intm_axbi.up_ReadSales_ANAT @P_Year, @P_Month
	--EXEC intm_axbi.up_ReadSales_ANCH @P_Year, @P_Month 

	--EXEC intm_axbi.up_ReadSales_ANDE @P_Year, @P_Month, @t_jobId, @t_jobDtm, @t_jobBy, @axbiDataBaseEnvSuffix

	EXEC intm_axbi.up_ReadSales_ANAU @P_Year, @P_Month, @t_jobId, @t_jobDtm, @t_jobBy, @axbiDataBaseEnvSuffix
	EXEC intm_axbi.up_ReadSales_ANAH @P_Year, @P_Month, @t_jobId, @t_jobDtm, @t_jobBy, @axbiDataBaseEnvSuffix
	EXEC intm_axbi.up_ReadSales_ANNZ @P_Year, @P_Month, @t_jobId, @t_jobDtm, @t_jobBy, @axbiDataBaseEnvSuffix
	
	--logic commented by Erich
	/* EXEC dbo.up_ReadSales_ASCH @P_Year, @P_Month */

--old logic commented by Erich
	-- EXEC up_ReadSales_ANAC -- Hie muss ab Januar das Jahr und der Monat übergeben werden.

END
GO

