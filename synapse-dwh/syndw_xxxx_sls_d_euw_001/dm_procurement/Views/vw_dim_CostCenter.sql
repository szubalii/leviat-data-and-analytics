CREATE VIEW [dm_procurement].[vw_dim_CostCenter]
AS
SELECT
    CostCenterID        AS CostCenterId
    ,CompanyCode
    ,REPLACE(CostCenter,'"','') AS CostCenterName
FROM [edw].[dim_CostCenter]