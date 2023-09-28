CREATE TABLE [edw].[fact_GRIRAccountReconciliation]
(
    [CompanyCodeID]                                     NVARCHAR(4) NOT NULL,
    [PurchasingDocument]                                NVARCHAR(10) NOT NULL,
    [PurchasingDocumentItem]                            CHAR(5) NOT NULL,
    [PurchasingDocumentItemUniqueID]                    NVARCHAR(15),
    [OldestOpenItemPostingDate]                         DATE,
    [LatestOpenItemPostingDate]                         DATE,
    [Supplier]                                          NVARCHAR(10),
    [SupplierName]                                      NVARCHAR(80),
    [HasNoInvoiceReceiptPosted]                         NVARCHAR(1),
    [BalAmtInCompanyCodeCrcy]                           DECIMAL(23,2),
    [BalAmtInEUR]                                       DECIMAL(23,2),
    [BalAmtInUSD]                                       DECIMAL(23,2),
    [CompanyCodeCurrency]                               CHAR(5),
    [BalanceQuantityInRefQtyUnit]                       DECIMAL(23,3),
    [ReferenceQuantityUnit]                             NVARCHAR(3),
    [NumberOfGoodsReceipts]                             INT,
    [NumberOfInvoiceReceipts]                           INT,
    [ResponsibleDepartment]                             NVARCHAR(30),
    [ResponsiblePerson]                                 NVARCHAR(12),
    [GRIRClearingProcessStatus]                         NVARCHAR(2),
    [GRIRClearingProcessPriority]                       NVARCHAR(2),
    [HasNote]                                           NVARCHAR(1),
    [AccountAssignmentCategory]                         NVARCHAR(1),
    [ValuationType]                                     NVARCHAR(10),
    [IsGoodsRcptGoodsAmtSurplus]                        NVARCHAR(1),
    [IsGdsRcptDelivCostAmtSurplus]                      NVARCHAR(1),
    [SystemMessageType]                                 NVARCHAR(1),
    [SystemMessageNumber]                               NVARCHAR(3),
    [t_applicationId]                                   VARCHAR(32),
    [t_extractionDtm]                                   DATETIME,
    [t_jobId]                                           VARCHAR(36),
    [t_jobDtm]                                          DATETIME,
    [t_lastActionCd]                                    VARCHAR(1),
    [t_jobBy]                                           VARCHAR(128),
    CONSTRAINT [PK_fact_GRIRAccountReconciliation] PRIMARY KEY NONCLUSTERED (
      [CompanyCodeID]
    , [PurchasingDocument]
    , [PurchasingDocumentItem]
    ) NOT ENFORCED
)
WITH ( DISTRIBUTION = HASH ([PurchasingDocument]), CLUSTERED COLUMNSTORE INDEX )