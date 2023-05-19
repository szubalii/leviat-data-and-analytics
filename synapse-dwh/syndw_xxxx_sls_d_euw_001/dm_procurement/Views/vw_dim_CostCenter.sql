CREATE VIEW [dm_procurement].[vw_dim_CostCenter]
AS
    CostCenterId
    ,CompanyCode
    ,CostCenter         AS CostCenterName
FROM [edw].[dim_CostCenter]