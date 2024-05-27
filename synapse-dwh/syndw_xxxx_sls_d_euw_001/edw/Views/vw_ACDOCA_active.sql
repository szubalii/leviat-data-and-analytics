CREATE VIEW [edw].[vw_ACDOCA_active]
AS
/*
The view is the same as [edw].[fact_ACDOCA_active] table but with [ProductSurrogateKey] field that has incorrect values if added during delta load to the table
*/
WITH 
PA AS (
  SELECT
    PurchaseOrder,
    PurchaseOrderItem,
    ICSalesDocumentID,
    ICSalesDocumentItemID
  FROM
    [edw].[dim_PurgAccAssignment]
  GROUP BY
    PurchaseOrder,
    PurchaseOrderItem,
    ICSalesDocumentID,
    ICSalesDocumentItemID
)

SELECT
    edw.svf_getProductSurrogateKey(
        VC.[ProductSurrogateKey],
        FAA.ProductID,
        FAA.SoldProduct
    ) AS [ProductSurrogateKey],
    FAA.*
FROM [edw].[fact_ACDOCA_active] FAA
LEFT JOIN
  PA
  ON
    PA.PurchaseOrder COLLATE DATABASE_DEFAULT = FAA.[PurchasingDocument]
    AND PA.PurchaseOrderItem = FAA.[PurchasingDocumentItem]
LEFT JOIN
  [edw].[vw_ProductHierarchyVariantConfigCharacteristic] AS VC
  ON
    VC.SalesDocument = CASE
      WHEN FAA.[ReferenceDocumentTypeID] = 'VBRK' AND FAA.SalesDocumentID = ''
      THEN PA.ICSalesDocumentID COLLATE DATABASE_DEFAULT
      ELSE FAA.SalesDocumentID
    END
    AND VC.SalesDocumentItem = CASE
      WHEN FAA.[ReferenceDocumentTypeID] = 'VBRK' AND FAA.SalesDocumentID = ''
      THEN PA.ICSalesDocumentItemID COLLATE DATABASE_DEFAULT
      ELSE FAA.SalesDocumentItemID
    END