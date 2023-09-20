CREATE VIEW [edw].[vw_Locations]
AS
SELECT
    Region                  
    ,CountryCode            
    ,Country                
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
FROM base_ff.LeviatWarehouse 