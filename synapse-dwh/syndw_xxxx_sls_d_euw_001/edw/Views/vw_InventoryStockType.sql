CREATE VIEW [edw].[vw_InventoryStockType]
AS
SELECT
    IST.[InventoryStockType] AS [InventoryStockTypeID]
    ,IST.[InventoryStockTypeName]
    ,IST.[t_applicationId]
    ,IST.[t_extractionDtm]
FROM
    [base_s4h_cax].[I_InventoryStockTypeT] IST
WHERE
    IST.[Language] = 'E'