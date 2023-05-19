CREATE VIEW [dm_procurement].[vw_dim_PurchaseOrder]
AS
SELECT
    PurchaseOrder                       AS POId
    ,''                                 AS ExtraPOKey
    ,PurchaseOrderItem                   AS POLineNumber
    ,''                                 AS ExtraPOLineKey
    ,''                                 AS SplitAccountingNumber
    ,PDI.PurchasingDocumentOrderDate    AS OrderedDate
    ,PDI.PurchaseOrderQuantity          AS Quantity
    ,PDI.NetAmount                      AS Amount
    ,PDI.DocumentCurrencyID             AS AmountCurrency
    ,''                                 AS Description
    ,PDI.MaterialGroupID                AS CommodityId
    ,CAST(CAST(PDI.MaterialID AS INT) AS VARCHAR)                     
                                        AS PartNumber
    ,''                                 AS PartRevisionNumber
    ,PDI.OrderQuantityUnit              AS UnitOfMeasure
    ,CAST(CAST(PDI.SupplierID AS INT) AS VARCHAR)
                                        AS SupplierId
    ,''                                 AS SupplierLocationId
    ,PDI.UserName                       AS RequesterId
    ,CAST(CAST(PDI.GLAccountID AS INT) AS VARCHAR)
                                        AS AccountId
    ,''                                 AS AccountCompanyCode
    ,PDI.PurchasingOrganizationID       AS CompanySiteId
    ,PDI.CostCenterID                   AS CostCenterId
    ,PDI.CompanyCodeID                  AS CostCenterCompanyCode
    ,PDI.PurchaseContract               AS ContractId
    ,''                                 AS DurationInMonths
    ,''                                 AS penPOIndicator  
    ,''                                 AS ineType 
    ,''                                 AS lexFieldId1 
    ,''                                 AS lexFieldId2 
    ,''                                 AS lexFieldId3 
    ,''                                 AS lexFieldId4 
    ,''                                 AS lexFieldId5 
    ,''                                 AS lexFieldId6 
    ,''                                 AS lexFieldId7 
    ,''                                 AS lexFieldId8 
    ,''                                 AS lexFieldId9 
    ,''                                 AS lexFieldId10
    ,''                                 AS lexFieldId11
    ,''                                 AS lexFieldId12
    ,''                                 AS lexFieldId13
    ,''                                 AS lexFieldId14
    ,''                                 AS lexMeasure1 
    ,''                                 AS lexMeasure2 
    ,''                                 AS lexMeasure3 
    ,''                                 AS lexMeasure4 
    ,''                                 AS lexMeasure5 
    ,''                                 AS lexDate1
    ,''                                 AS lexDate2
    ,''                                 AS lexDate3
    ,''                                 AS lexDate4
    ,''                                 AS lexDate5
    ,''                                 AS lexString1  
    ,''                                 AS lexString2  
    ,''                                 AS lexString3  
    ,''                                 AS lexString4  
    ,''                                 AS lexString5  
    ,''                                 AS lexString6  
    ,''                                 AS lexString7  
    ,''                                 AS lexString8  
    ,''                                 AS lexString9  
    ,''                                 AS lexString10 
FROM [edw].[fact_PurchasingDocumentItem]  PDI 
LEFT JOIN [edw].[fact_SupplierInvoiceItemPurOrdRef] SIIPOR
    ON PDI.sk_fact_PurchasingDocumentItem = SIIPOR.sk_fact_PurchasingDocumentItem