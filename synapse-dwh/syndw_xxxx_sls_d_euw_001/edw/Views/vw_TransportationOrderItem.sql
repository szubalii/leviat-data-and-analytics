CREATE VIEW [edw].[vw_TransportationOrderItem]
AS
SELECT
    [TransportationOrderItemUUID]
    , RIGHT([TranspOrdDocReferenceID],10)           AS [TranspOrdDocReferenceID]
    , RIGHT([TranspOrdDocReferenceItmID],6)         AS [TranspOrdDocReferenceItmID]
FROM [base_s4h_cax].[I_TransportationOrderItem]