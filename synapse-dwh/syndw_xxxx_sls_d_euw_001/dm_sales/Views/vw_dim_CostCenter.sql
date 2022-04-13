CREATE VIEW [dm_sales].[vw_dim_CostCenter] AS 

SELECT
  [ControllingArea]
, [CostCenterID]
, [CostCenter]
, [CostCenterCategory]
, [CostCtrResponsiblePersonName]
, [CostCtrResponsibleUser]
, [IsBlkdForSecondaryCostsPosting]
, [IsBlockedForRevenuePosting]
, [IsBlockedForCommitmentPosting]
, [IsBlockedForPlanSecondaryCosts]
, [IsBlockedForPlanRevenues]
, [CostCenterAllocationMethod]
, [Country]
FROM [edw].[dim_CostCenter]
