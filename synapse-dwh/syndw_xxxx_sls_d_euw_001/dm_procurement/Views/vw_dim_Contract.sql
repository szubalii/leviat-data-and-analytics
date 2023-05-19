CREATE VIEW [dm_procurement].[vw_dim_Contract]
AS
SELECT
    ContractID
    ,ContractName
FROM [edw].[fact_PurchasingDocumentItem]
GROUP BY ContractID
        ,ContractName