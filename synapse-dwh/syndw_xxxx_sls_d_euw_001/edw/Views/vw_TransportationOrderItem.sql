CREATE VIEW [edw].[vw_TransportationOrderItem]
AS
SELECT
    [MANDT]
    , [TransportationOrderItemUUID]
    , [TransportationOrderUUID]
    , [TranspOrdItem]
    , [TranspOrdItemType]
    , [IsMultiItem]
    , [TranspOrdItemParentItemUUID]
    , [SourceStopUUID]
    , [DestinationStopUUID]
    , [TranspOrdItemDesc]
    , [TranspOrdItemCategory]
    , [IsMainCargoItem]
    , [PredecessorTransportationOrder]
    , [Shipper]
    , [Consignee]
    , [TransportationMode]
    , [TransportationModeCategory]
    , [MeansOfTransport]
    , [TranspOrdActvVehRscePltNmbr]
    , [TranspOrdItemGrossWeight]
    , [TranspOrdItemGrossWeightUnit]
    , [TranspOrdItemGrossVolume]
    , [TranspOrdItemGrossVolumeUnit]
    , [TranspOrdItemNetWeight]
    , [TranspOrdItemNetWeightUnit]
    , [TranspOrdItemQuantity]
    , [TranspOrdItemQuantityUnit]
    , [TranspOrdItemAltvQty]
    , [TranspOrdItemAltvQtyUnit]
    , [TranspOrdItemBaseQty]
    , [TranspOrdItemBaseQtyUnit]
    , [TranspOrdItemTareWeight]
    , [TranspOrdItemTareWeightUnit]
    , [TranspOrdItemNumberOfCtns]
    , [TranspOrdItemNumberOfCtnsUnit]
    , [TranspOrdItemLength]
    , [TranspOrdItemWidth]
    , [TranspOrdItemHeight]
    , [TranspOrdItemLengthUnit]
    , [TranspOrdItemGoodsValue]
    , [TranspOrdItemGoodsValueCrcy]
    , [TranspOrdItemIsDangerousGood]
    , [TranspOrdItemDngrsGdsSts]
    , [MaterialFreightGroup]
    , [MaterialFreightGroupName]
    , [TransportationGroup]
    , [TransportationGroupName]
    , [ProductID]
    , [ProductName]
    , RIGHT([TranspOrdDocReferenceID],10)           AS [TranspOrdDocReferenceID]
    , RIGHT([TranspOrdDocReferenceItmID],6)         AS [TranspOrdDocReferenceItmID]
    , [TranspOrdDocReferenceType]
    , [TranspOrdDocReferenceItmType]
    , [TranspOrdItemSorting]
    , [ShipperUUID]
    , [ConsigneeAddressID]
    , [ConsigneeUUID]
    , [ProductUUID]
    , [IncotermsClassification]
    , [TranspOrdItemVoyage]
    , [TranspOrdItemFlight]
    , [TranspOrdItemVessel]
    , [TranspOrdItemIMOShip]
    , [TranspOrdFlightNumber]
    , [TranspOrdBookingConfSts]
    , [CargoIsHighValue]
    , [Plant]
    , [TranspOrdItmWhseNmbr]
    , [TranspOrdShippingCondition]
FROM [base_s4h_cax].[I_TransportationOrderItem]