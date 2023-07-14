CREATE VIEW [dm_procurement].[vw_dim_CostCenter_report]
AS
SELECT
    CostCenterId
    ,CompanyCode
    ,REPLACE(CostCenterName,'"','')         AS CostCenterName
FROM [dm_procurement].[vw_dim_CostCenter]