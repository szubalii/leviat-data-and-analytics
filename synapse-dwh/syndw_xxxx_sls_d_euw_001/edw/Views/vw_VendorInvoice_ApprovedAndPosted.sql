CREATE VIEW [edw].[vw_VendorInvoice_ApprovedAndPosted]
AS
SELECT

-- Fields from /Opt/Vim_1Item
  MANDT
, DOCID        AS DocumentLedgerID
, ITEMID       AS DocumentItemID
, BUKRS        AS CompanyCodeID
, EBELN        AS PurchasingDocumentID
, EBELP        AS PurchasingDocumentItemID
, MATNR        AS MaterialID
, MENGE        AS Quantity
, BSTME        AS OrderUnit
, BPRME        AS OrderPriceUnit
, WRBTR        AS NetAmount
, WERKS        AS PlantID
, SHKZG        AS DebitCreditIndicator
, COND_TYPE    AS ConditionType
, NETPR        AS NetOrderPrice
, KOSTL        AS CostCenterID
, EREKZ        AS FinalInvoice
, HKONT        AS GLAccountID
, AUFNR        AS OrderNumber
, SGTXT        AS LineItemText
, KOKRS        AS ControllingAreaID
, PRCTR        AS ProfitCenterID
, VBELN        AS SalesDocument
, VBELP        AS SalesDocumentItem
, ETENR        AS ScheduleLineNumber
, MWSKZ        AS TaxCode
, REF_DOC      AS MaterialDocument
, REF_DOC_YEAR AS MaterialDocumentYear
, REF_DOC_IT   AS MaterialDocumentItem
, BWKEY        AS ValuationAreaID
, BSMNG        AS QuantityOrdered
, REMNG        AS QuantityInvoiced
, WEMNG        AS QuantityOfGoodsReceived
-- Fields from /Opt/Vim_1Head
, BUS_OBJTYPE  AS HDR1_ObjectType
, STATUS       AS HDR1_DocumentStatus
, NOFIRSTPASS  AS HDR1_NotFirstPass
, BLART        AS HDR1_AccountingDocumentTypeID
, GJAHR        AS HDR1_FiscalYear
, BLDAT        AS HDR1_DocumentDate
, BUDAT        AS HDR1_PostingDate
, LIFNR        AS HDR1_SupplierID
, XBLNR        AS HDR1_ReferenceID
, WAERS        AS HDR1_CurrencyID
, BKTXT        AS HDR1_HeaderText
, LAND1        AS HDR1_CountryID
-- Fields from /Opt/Vim_2Head
, BELNR_MM     AS HDR2_SupplierInvoiceID
, BELNR_FI     AS HDR2_AccountDocumentID
, POSTING_USER AS HDR2_PostingUser

FROM
    [base_s4h_cax].[Opt_Vim_1Item_Extended]
--WHERE
--    DOCTYPE <> 'NPO_S4'