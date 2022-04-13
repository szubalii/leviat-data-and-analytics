CREATE PROC [edw].[sp_load_dim_Plant] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_Plant', 'U') is not null
        TRUNCATE TABLE [edw].[dim_Plant]
    INSERT INTO [edw].[dim_Plant]( [PlantID]
                                 , [Plant]
                                 , [ValuationArea]
                                 , [PlantCustomer]
                                 , [PlantSupplier]
                                 , [FactoryCalendar]
                                 , [DefaultPurchasingOrganization]
                                 , [SalesOrganization]
                                 , [AddressID]
                                 , [PlantCategory]
                                 , [DistributionChannel]
                                 , [Division]
                                 , [t_applicationId]
                                 , [t_jobId]
                                 , [t_jobDtm]
                                 , [t_lastActionCd]
                                 , [t_jobBy])
    select Plant
         , PlantName
         , [ValuationArea]
         , [PlantCustomer]
         , [PlantSupplier]
         , [FactoryCalendar]
         , [DefaultPurchasingOrganization]
         , [SalesOrganization]
         , [AddressID]
         , [PlantCategory]
         , [DistributionChannel]
         , [Division]
         , [t_applicationId]
         , @t_jobId        AS t_jobId
         , @t_jobDtm       AS t_jobDtm
         , @t_lastActionCd AS t_lastActionCd
         , @t_jobBy        AS t_jobBy
    FROM [base_s4h_uat_caa].[I_Plant] Plant
    where Plant.MANDT = 200
END