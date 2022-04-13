CREATE VIEW [dm_sales].[vw_dim_CustomerCalculated]
AS 
SELECT 
        [CustomerIDCalculated] 
    ,   [CustomerCalculated] 
    ,   [CustomerPillarCalculated] 
    ,   [isReviewed] 
    ,   [mappingType] 
    ,   [axbiCustomeraccount] 
    ,   [axbiCustomerName]
    ,   [axbiCustomerPillarCalculated]
    ,   [t_applicationId]
    ,   [t_extractionDtm]      
FROM [edw].[dim_CustomerCalculated]

UNION ALL

SELECT 
        [CustomerIDCalculated] 
    ,   [CustomerCalculated] 
    ,   [CustomerPillarCalculated] 
    ,   [isReviewed] 
    ,   [mappingType] 
    ,   [axbiCustomeraccount] 
    ,   [axbiCustomerName]
    ,   [axbiCustomerPillarCalculated]
    ,   [t_applicationId]
    ,   [t_extractionDtm]      
FROM [edw].[dim_CustomerCalculated_US]
