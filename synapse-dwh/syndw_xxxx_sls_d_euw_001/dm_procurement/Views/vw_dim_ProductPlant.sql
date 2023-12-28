CREATE VIEW [dm_procurement].[vw_dim_ProductPlant]
AS
SELECT
        PP.[Product]
    ,   PP.[Plant]
    ,   PP.[PurchasingGroup]
    ,   PP.[CountryOfOrigin]
    ,   PP.[RegionOfOrigin]
    ,   PP.[MinimumLotSizeQuantity]
    ,   PP.[MaximumLotSizeQuantity]
    ,   NVM.[PLIFZ] AS [PlannedDeliveryTime]
FROM
    [edw].[dim_ProductPlant] PP
LEFT JOIN
    [base_s4h_cax].[NSDM_V_MARC] NVM
    ON PP.Plant = NVM.WERKS 
        AND PP.Product = NVM.MATNR 