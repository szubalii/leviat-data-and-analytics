CREATE VIEW [edw].[vw_InventorySpecialStockType]
AS
SELECT
    PST.[InventorySpecialStockType] AS [InventorySpecialStockTypeID]
    ,PST.[InventorySpecialStockTypeName]
    ,PST.[t_applicationId]
    ,PST.[t_extractionDtm]
FROM
    [base_s4h_cax].[I_InventorySpecialStockTypeT] PST
WHERE
    PST.[Language] = 'E'