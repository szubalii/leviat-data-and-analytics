CREATE VIEW [dm_procurement].[vw_dim_Product]
AS
WITH dm_sales_product AS
(
    SELECT
        P.[ProductExternalID],
        P.[Product]          
    FROM
        [edw].[dim_Product] P

UNION ALL

    SELECT
        [ProductExternalID],
        [Product]
    FROM
        [edw].[dim_AXProductSAPHierarchy]
)
SELECT
    ProductExternalID               AS PartNumber
    ,''                             AS RevisionNumber
    ,Replace(Replace(Replace(Product,'"',''),CHAR(10),''),CHAR(13),'') AS Description1
    ,''                             AS Description2
    ,''                             AS StandardCost
    ,''                             AS StandardCostCurrency
    ,''                             AS StandardCostDate
    ,''                             AS StockIndicator
    ,''                             AS ManufacturerName
    ,''                             AS ManufacturerPartNumber
    ,''                             AS LeadTimeInDays
    ,''                             AS FlexField1
    ,''                             AS FlexField2
    ,''                             AS FlexField3
    ,''                             AS PartFlexText1
    ,''                             AS PartFlexText2
    ,''                             AS PartFlexText3
    ,''                             AS OriginCountry
    ,''                             AS MaterialComposition
    ,''                             AS ForecastUsage1
    ,''                             AS ForecastUsage2
    ,''                             AS ForecastUsage3
FROM dm_sales_product