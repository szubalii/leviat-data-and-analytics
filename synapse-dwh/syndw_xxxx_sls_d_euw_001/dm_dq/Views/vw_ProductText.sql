CREATE VIEW [dm_dq].[vw_ProductText] AS 

SELECT 
  [Material]      AS ProductID
, [MaterialName]  AS Product
, [Language]   
FROM 
[base_s4h_cax].[I_MaterialText]