CREATE PROC [edw].[sp_load_dim_Warehouse]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN
 IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_Warehouse', 'U') is not null
        TRUNCATE TABLE [edw].[dim_Warehouse]
    INSERT INTO [edw].[dim_Warehouse] ( 
       [WarehouseId]
      ,[Warehouse]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
      ,[t_jobBy])
    SELECT Warehouse.[Warehouse] as [WarehouseId]
           ,WarehouseText.[WarehouseName] as [Warehouse]
           ,Warehouse.t_applicationId
           ,@t_jobId AS t_jobId
           ,@t_jobDtm AS t_jobDtm
           ,@t_lastActionCd AS t_lastActionCd
           ,@t_jobBy AS t_jobBy
    FROM [base_s4h_uat_caa].[I_Warehouse] Warehouse
    LEFT JOIN [base_s4h_uat_caa].[I_WarehouseText] WarehouseText 
    ON Warehouse.[Warehouse] = WarehouseText.[Warehouse]
   AND WarehouseText.[Language] = 'E' 
    WHERE Warehouse.[MANDT] = 200 AND WarehouseText.[MANDT] = 200
END
