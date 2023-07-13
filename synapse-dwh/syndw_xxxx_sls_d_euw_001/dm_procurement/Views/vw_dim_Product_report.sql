CREATE VIEW [dm_procurement].[vw_dim_Product_report]
AS
SELECT
    PartNumber
    ,RevisionNumber
    ,Replace(Replace(Description1,'"',''),CHAR(10),'') AS Description1
    ,Description2
    ,StandardCost
    ,StandardCostCurrency
    ,StandardCostDate
    ,StockIndicator
    ,ManufacturerName
    ,ManufacturerPartNumber
    ,LeadTimeInDays
    ,FlexField1
    ,FlexField2
    ,FlexField3
    ,PartFlexText1
    ,PartFlexText2
    ,PartFlexText3
    ,OriginCountry
    ,MaterialComposition
    ,ForecastUsage1
    ,ForecastUsage2
    ,ForecastUsage3
FROM [dm_procurement].[vw_dim_Product]