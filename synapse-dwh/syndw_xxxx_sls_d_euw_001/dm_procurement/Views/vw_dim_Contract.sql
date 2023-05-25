CREATE VIEW [dm_procurement].[vw_dim_Contract]
AS
SELECT
    PurchaseContract            AS ContractID
    ,PurchaseContractItem       AS ContractName
FROM [edw].[fact_PurchasingDocumentItem]
GROUP BY PurchaseContract      
        ,PurchaseContractItem 