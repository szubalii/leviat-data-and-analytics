CREATE VIEW [edw].[vw_StorageLocation]
AS SELECT 
     edw.svf_get2PartNaturalKey (StorageLocation,Plant)  AS [nk_StoragePlantID]
,    [StorageLocation] AS [StorageLocationID]
,    [StorageLocationName] AS [StorageLocation]
,    [Plant]
,    [SalesOrganization]
,    [DistributionChannel]
,    [Division]
,    [IsStorLocAuthznCheckActive]
,    [t_applicationId]
,    [t_extractionDtm]
FROM 
     [base_s4h_cax].[I_StorageLocation] StorageLocation
-- WHERE 
--      StorageLocation.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
