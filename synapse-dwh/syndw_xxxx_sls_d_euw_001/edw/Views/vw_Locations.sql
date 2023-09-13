CREATE VIEW [edw].[vw_Locations]
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
FROM base_ff.LeviatLocations    