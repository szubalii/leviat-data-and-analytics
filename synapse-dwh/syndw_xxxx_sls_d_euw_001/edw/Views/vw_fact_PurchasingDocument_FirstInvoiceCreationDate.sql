CREATE VIEW [edw].[vw_fact_PurchasingDocument_FirstInvoiceCreationDate]
AS
  SELECT
    [PurchasingDocument],
    [SupplierID],
    [PurchasingDocumentCategoryID],
    [PurchasingDocumentTypeID],
    [CreationDate],
    [CreatedByUser],
    [CompanyCodeID],
    [PurchasingDocumentOrderDate],
    [PurchasingOrganizationID],
    [PurchasingGroupID],
    [SupplyingPlantID],
    [PurchasingProcessingStatusID],
    [PurchaseContract],
    [PurchasingDocumentCondition],
    MIN(si.[CreationDate]) AS [FirstInvoiceCreationDate]
  FROM
    [edw].[fact_PurchasingDocument] pd
  LEFT JOIN
    [edw].[fact_VendorInvoice_ApprovedAndPosted] vim
    ON
      vim.PurchasingDocument = pd.PurchasingDocument
  LEFT JOIN
    [edw].[fact_SupplierInvoice] si
    ON
      si.SupplierInvoiceID = vim.HDR2_SupplierInvoiceID
  GROUP BY
    [PurchasingDocument],
    [SupplierID],
    [PurchasingDocumentCategoryID],
    [PurchasingDocumentTypeID],
    [CreationDate],
    [CreatedByUser],
    [CompanyCodeID],
    [PurchasingDocumentOrderDate],
    [PurchasingOrganizationID],
    [PurchasingGroupID],
    [SupplyingPlantID],
    [PurchasingProcessingStatusID],
    [PurchaseContract],
    [PurchasingDocumentCondition]
