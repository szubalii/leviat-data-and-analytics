CREATE VIEW [dm_procurement].[vw_dim_PurchaseOrder]
AS
SELECT
    PurchaseOrder                       AS POId
    ,''                                 AS ExtraPOKey
    ,PurchaseOrderItem                  AS POLineNumber
    ,''                                 AS ExtraPOLineKey
    ,''                                 AS SplitAccountingNumber
    ,PD.PurchasingDocumentOrderDate     AS OrderedDate
    ,PDI.PurchaseOrderQuantity          AS Quantity
    ,PDI.NetAmount                      AS Amount
    ,PDI.DocumentCurrencyID             AS AmountCurrency
    ,''                                 AS Description
    ,PDI.MaterialGroupID                AS CommodityId
    ,REPLACE(LTRIM(REPLACE(PDI.MaterialID,'0',' ')),' ','0')                    
                                        AS PartNumber
    ,''                                 AS PartRevisionNumber
    ,PDI.OrderQuantityUnit              AS UnitOfMeasure
    ,REPLACE(LTRIM(REPLACE(PD.SupplierID,'0',' ')),' ','0')
                                        AS SupplierId
    ,''                                 AS SupplierLocationId
    ,PD.CreatedByUser                   AS RequesterId
    ,REPLACE(LTRIM(REPLACE(PDI.GLAccountID,'0',' ')),' ','0')
                                        AS AccountId
    ,''                                 AS AccountCompanyCode
    ,PD.PurchasingOrganizationID       AS CompanySiteId
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
JOIN [edw].[fact_PurchasingDocument]                            PD
    ON PDI.PurchasingDocument = PD.PurchasingDocument
LEFT JOIN [edw].[fact_SupplierInvoiceItemPurOrdRef] SIIPOR
    ON PDI.sk_fact_PurchasingDocumentItem = SIIPOR.sk_fact_PurchasingDocumentItem