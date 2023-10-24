CREATE VIEW [edw].[vw_fact_PurchasingDocument_FirstInvoiceCreationDate]
AS
  SELECT
    pd.[PurchasingDocument],
    pd.[SupplierID],
    pd.[PurchasingDocumentCategoryID],
    pd.[PurchasingDocumentTypeID],
    pd.[CreationDate],
    pd.[CreatedByUser],
    pd.[CompanyCodeID],
    pd.[PurchasingDocumentOrderDate],
    pd.[PurchasingOrganizationID],
    pd.[PurchasingGroupID],
    pd.[SupplyingPlantID],
    pd.[PurchasingProcessingStatusID],
    pd.[PurchaseContract],
    pd.[PurchasingDocumentCondition],
    MIN(si.[CreationDate]) AS [FirstInvoiceCreationDate]
  FROM
    [edw].[fact_PurchasingDocument] pd
  LEFT JOIN
    [edw].[fact_VendorInvoice_ApprovedAndPosted] vim
    ON
      vim.PurchasingDocument COLLATE DATABASE_DEFAULT = pd.PurchasingDocument COLLATE DATABASE_DEFAULT
  LEFT JOIN
    [edw].[fact_SupplierInvoice] si
    ON
      si.SupplierInvoiceID COLLATE DATABASE_DEFAULT = vim.HDR2_SupplierInvoiceID COLLATE DATABASE_DEFAULT
  GROUP BY
    pd.[PurchasingDocument],
    pd.[SupplierID],
    pd.[PurchasingDocumentCategoryID],
    pd.[PurchasingDocumentTypeID],
    pd.[CreationDate],
    pd.[CreatedByUser],
    pd.[CompanyCodeID],
    pd.[PurchasingDocumentOrderDate],
    pd.[PurchasingOrganizationID],
    pd.[PurchasingGroupID],
    pd.[SupplyingPlantID],
    pd.[PurchasingProcessingStatusID],
    pd.[PurchaseContract],
    pd.[PurchasingDocumentCondition]
