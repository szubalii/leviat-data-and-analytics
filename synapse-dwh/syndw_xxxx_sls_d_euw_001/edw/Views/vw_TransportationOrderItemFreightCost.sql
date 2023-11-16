CREATE VIEW [edw].[vw_TransportationOrderItemFreightCost]
AS
SELECT
    TOI.TranspOrdDocReferenceID
    , TOI.TranspOrdDocReferenceItmID
    , SUM(FCDI.FrtCostDistrItemAmount)              AS FrtCostDistrItemAmount
    , FCDI.FrtCostDistrItemAmtCrcy                  AS FrtCostDistrItemAmtCrcy
FROM [edw].[vw_TransportationOrderItem] TOI
INNER JOIN [edw].[vw_FrtCostDistrItm] FCDI
ON TOI.TransportationOrderItemUUID = FCDI.FrtCostDistrItmRefUUID
GROUP BY
    TOI.TranspOrdDocReferenceID
    , TOI.TranspOrdDocReferenceItmID
    , FCDI.FrtCostDistrItemAmtCrcy