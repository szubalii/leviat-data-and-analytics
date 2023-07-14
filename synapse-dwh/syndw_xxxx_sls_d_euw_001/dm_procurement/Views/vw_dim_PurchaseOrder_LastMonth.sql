CREATE VIEW [dm_procurement].[vw_dim_PurchaseOrder_LastMonth]
AS
SELECT
    POId
    ,ExtraPOKey
    ,POLineNumber
    ,ExtraPOLineKey
    ,SplitAccountingNumber
    ,FORMAT(OrderedDate,'yyyy-MM-dd')          AS OrderedDate
    ,Quantity
    ,Amount
    ,LEFT(AmountCurrency,3)                             AS AmountCurrency
    ,Description
    ,ERPCommodityId
    ,PartNumber
    ,PartRevisionNumber
    ,UnitOfMeasure
    ,SupplierId
    ,SupplierLocationId
    ,RequesterId
    ,AccountId
    ,AccountCompanyCode
    ,CompanySiteId
    ,CostCenterId
    ,CostCenterCompanyCode
    ,ContractId
    ,DurationInMonths
    ,OpenPOIndicator
    ,LineType
    ,FlexFieldId1
    ,FlexFieldId2
    ,FlexFieldId3
    ,FlexFieldId4
    ,FlexFieldId5
    ,FlexFieldId6
    ,FlexFieldId7
    ,FlexFieldId8
    ,FlexFieldId9
    ,FlexFieldId10
    ,FlexFieldId11
    ,FlexFieldId12
    ,FlexFieldId13
    ,FlexFieldId14
    ,FlexMeasure1
    ,FlexMeasure2
    ,FlexMeasure3
    ,FlexMeasure4
    ,FlexMeasure5
    ,FlexDate1
    ,FlexDate2
    ,FlexDate3
    ,FlexDate4
    ,FlexDate5
    ,FlexString1
    ,FlexString2
    ,FlexString3
    ,FlexString4
    ,FlexString5
    ,FlexString6
    ,FlexString7
    ,FlexString8
    ,FlexString9
    ,FlexString10
FROM [dm_procurement].[vw_dim_PurchaseOrder]
WHERE OrderedDate >= CONVERT(
                        date
                        , DATEADD(
                            month
                            , DATEDIFF(
                                month
                                , 0
                                , GETDATE()
                            ) - 1
                            , 0
                        )
                    )