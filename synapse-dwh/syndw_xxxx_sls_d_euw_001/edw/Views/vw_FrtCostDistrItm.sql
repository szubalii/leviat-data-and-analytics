CREATE VIEW [edw].[vw_FrtCostDistrItm]
AS
SELECT
    [MANDT]
    , [FrtCostDistrItemUUID]
    , [FrtCostDistrRootUUID]
    , [FrtCostDistrItmRefUUID]
    , [FrtCostDistrItemAmount]
    , [FrtCostDistrItemAmtCrcy]
    , [FrtCostDistrItmQty]
    , [FrtCostDistrItmQtyUnit]
    , [TransportationOrderUUID]
FROM [base_s4h_cax].[I_FrtCostDistrItm]