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
    ,PROD.EClassCode                    AS CommodityId
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
    ,''                                 AS OpenPOIndicator
    ,''                                 AS LineType
    ,''                                 AS FlexFieldId1
    ,''                                 AS FlexFieldId2
    ,''                                 AS FlexFieldId3
    ,''                                 AS FlexFieldId4
    ,''                                 AS FlexFieldId5
    ,''                                 AS FlexFieldId6
    ,''                                 AS FlexFieldId7
    ,''                                 AS FlexFieldId8
    ,''                                 AS FlexFieldId9
    ,''                                 AS FlexFieldId10
    ,''                                 AS FlexFieldId11
    ,''                                 AS FlexFieldId12
    ,''                                 AS FlexFieldId13
    ,''                                 AS FlexFieldId14
    ,''                                 AS FlexMeasure1
    ,''                                 AS FlexMeasure2
    ,''                                 AS FlexMeasure3
    ,''                                 AS FlexMeasure4
    ,''                                 AS FlexMeasure5
    ,''                                 AS FlexDate1
    ,''                                 AS FlexDate2
    ,''                                 AS FlexDate3
    ,''                                 AS FlexDate4
    ,''                                 AS FlexDate5
    ,''                                 AS FlexString1
    ,''                                 AS FlexString2
    ,''                                 AS FlexString3
    ,''                                 AS FlexString4
    ,''                                 AS FlexString5
    ,''                                 AS FlexString6
    ,''                                 AS FlexString7
    ,''                                 AS FlexString8
    ,''                                 AS FlexString9
    ,''                                 AS FlexString10
FROM [edw].[fact_PurchasingDocumentItem]  PDI 
JOIN [edw].[fact_PurchasingDocument]                            PD
    ON PDI.PurchasingDocument = PD.PurchasingDocument
LEFT JOIN [edw].[fact_SupplierInvoiceItemPurOrdRef] SIIPOR
    ON PDI.sk_fact_PurchasingDocumentItem = SIIPOR.sk_fact_PurchasingDocumentItem
LEFT OUTER JOIN edw.dim_Product PROD 
    ON PDI.MaterialID COLLATE SQL_Latin1_General_CP1_CS_AS = PROD.sk_dim_Product