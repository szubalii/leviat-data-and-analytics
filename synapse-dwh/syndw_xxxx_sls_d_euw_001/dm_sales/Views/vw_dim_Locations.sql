CREATE VIEW [dm_sales].[vw_dim_Locations]
AS
SELECT
    Region                  
    ,CountryCode            
    ,Country                
    ,ShippingPointNameSAP   
    ,NameOfWHS              
    ,Type                   
    ,SAPCode                
    ,TypeOfWHS              
    ,Address                
    ,Zipcode                
    ,City                   
    ,LogisticArea           
    ,FTELogistics           
    ,FullAddress            
FROM edw.vw_Locations