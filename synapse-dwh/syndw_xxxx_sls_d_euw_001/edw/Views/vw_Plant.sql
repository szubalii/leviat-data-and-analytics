CREATE VIEW [edw].[vw_Plant]
AS
SELECT 
        [Plant] AS [PlantID]
    ,   [PlantName] AS [Plant]
    ,   [ValuationArea]
    ,   [PlantCustomer]
    ,   [PlantSupplier]
    ,   [FactoryCalendar]
    ,   [DefaultPurchasingOrganization]
    ,   [SalesOrganization]
    ,   [AddressID]
    ,   [PlantCategory]
    ,   [DistributionChannel]
    ,   [Division]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
FROM 
    [base_s4h_cax].[I_Plant] Plant

UNION ALL

SELECT 
        [SITEID] AS [PlantID]
    ,   [NAME] AS [Plant]
    ,   [DATAAREAID] AS [ValuationArea]
    ,   NULL AS [PlantCustomer]
    ,   NULL AS [PlantSupplier]
    ,   NULL AS [FactoryCalendar]
    ,   NULL AS [DefaultPurchasingOrganization]
    ,   [DATAAREAID] AS [SalesOrganization]
    ,   NULL AS [AddressID]
    ,   NULL AS [PlantCategory]
    ,   NULL AS [DistributionChannel]
    ,   NULL AS [Division]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
FROM 
    [map_AXBI].[InventSite] InvS



-- WHERE 
--      Plant.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
