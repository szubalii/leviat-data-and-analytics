CREATE VIEW [edw].[vw_Plant]
AS SELECT 
     [Plant] AS [PlantID]
,    [PlantName] AS [Plant]
,    [ValuationArea]
,    [PlantCustomer]
,    [PlantSupplier]
,    [FactoryCalendar]
,    [DefaultPurchasingOrganization]
,    [SalesOrganization]
,    [AddressID]
,    [PlantCategory]
,    [DistributionChannel]
,    [Division]
,    [t_applicationId]
,    [t_extractionDtm]
FROM 
     [base_s4h_cax].[I_Plant] Plant
-- WHERE 
--      Plant.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
