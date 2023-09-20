CREATE VIEW [dm_sales].[vw_dim_Locations]
AS
SELECT
    Region                  
    ,CountryCode
    ,SAPShippingPoint   
    ,WarehouseName              
    ,Type                   
    ,SAPCode                
    ,WarehouseType              
    ,Address                
    ,Zipcode                
    ,City                   
    ,LogisticsAreaInM2           
    ,FTELogistics           
    ,FullAddress            
FROM edw.vw_Locations