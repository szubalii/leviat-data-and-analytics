CREATE TABLE [edw].[fact_BillingDocumentItem_US]
(
     [sk_fact_BillingDocumentItem]              INT IDENTITY (1,1)                                   NOT NULL
    ,[BillingDocument]                          NVARCHAR(40)                                         NOT NULL
    ,[BillingDocumentItem]                      CHAR(7) collate Latin1_General_100_BIN2              NOT NULL
    ,[CurrencyTypeID]                           CHAR(2)                                              NOT NULL
    ,[CurrencyType]                             NVARCHAR(20)                                         NOT NULL
    ,[BillingDocumentTypeID]                    NVARCHAR(8)                                          NULL
    ,[SDDocumentCategoryID]                     NVARCHAR(8)                                          NULL
    ,[BillingDocumentDate]                      DATETIME                                             NULL
    ,[SalesOrganizationID]                      NVARCHAR(24)                                         NULL
    ,[Material]                                 NVARCHAR(80)                                         NULL
    ,[MaterialGroupID]                          NVARCHAR(40)                                         NULL
    ,[NetAmount]                                DECIMAL(28,12)                                       NULL
    ,[TransactionCurrencyID]                    CHAR(6) collate Latin1_General_100_BIN2              NULL
    ,[TaxAmount]                                DECIMAL(28,12)                                       NULL
    ,[CostAmount]                               DECIMAL(38,12)                                       NULL
    ,[CostCenter]                               NVARCHAR(30)                                         NULL
    ,[CurrencyID]                               NVARCHAR(3) collate Latin1_General_100_BIN2          NULL
    ,[SalesDocumentID]                          NVARCHAR(40)                                         NULL
    ,[SalesDistrictID]                          NVARCHAR(20)                                         NULL
    ,[CustomerGroupID]                          NVARCHAR(8)                                          NULL
    ,[CountryID]                                NVARCHAR(20)                                         NULL
    ,[QuantitySold]                             DECIMAL(28,12)                                       NULL
    ,[BillingQuantity]                          DECIMAL(28,12)                                       NULL
    ,[GrossMargin]                              DECIMAL(19, 6)                                       NULL
    ,[ExchangeRate]                             NUMERIC(15,6)                                        NULL
    ,[FinNetAmount]                             DECIMAL(28,12)                                       NULL
    ,[FinNetAmountFreight]                      DECIMAL(19, 6)                                       NULL
    ,[FinNetAmountMinQty]                       DECIMAL(19, 6)                                       NULL
    ,[FinNetAmountEngServ]                      DECIMAL(19, 6)                                       NULL
    ,[FinNetAmountMisc]                         DECIMAL(19, 6)                                       NULL
    ,[FinNetAmountServOther]                    DECIMAL(19, 6)                                       NULL
    ,[FinNetAmountVerp]                         DECIMAL(19, 6)                                       NULL
    ,[FinRebateAccrual]                         DECIMAL(19, 6)                                       NULL
    ,[PaymentTermCashDiscountPercentageRate]    DECIMAL(5, 3)                                        NULL
    ,[FinNetAmountOtherSales]                   DECIMAL(19, 6)                                       NULL
    ,[FinReserveCashDiscount]                   DECIMAL(19, 6)                                       NULL
    ,[FinNetAmountAllowances]                   DECIMAL(19, 6)                                       NULL
    ,[FinSales100]                              DECIMAL(19, 6)                                       NULL
    ,[AccountingDate]                           DATETIME                                             NULL
    ,[MaterialCalculated]                       NVARCHAR(80)                                         NULL
    ,[SoldToPartyCalculated]                    NVARCHAR(100)                                        NULL
    ,[InOutID]                                  NVARCHAR(6) collate Latin1_General_100_BIN2          NULL
    ,[axbi_MaterialID]                          NVARCHAR (100)                                       NULL
    ,[axbi_CustomerID]                          NVARCHAR (100)                                       NULL
    ,[axbi_SalesTypeID]                         CHAR(10)                                             NULL
    ,[SalesOrgname]                             NVARCHAR(80)                                         NULL
    ,[Pillar]                                   NVARCHAR(40)                                         NULL
    ,[MaterialLongDescription]                  NVARCHAR(2000)                                       NULL
    ,[MaterialShortDescription]                 NVARCHAR(2000)                                       NULL
    ,[CustomerName]                             NVARCHAR(120)                                        NULL
    ,[axbi_StorageLocationID]                   NVARCHAR(40)                                         NULL
    ,[axbi_CostCenter]                          NVARCHAR(30)                                         NULL
    ,[t_applicationId]                          VARCHAR(32)
    ,[t_extractionDtm]                          DATETIME
    ,[t_jobId]                                  VARCHAR(36)
    ,[t_jobDtm]                                 DATETIME
    ,[t_lastActionCd]                           VARCHAR(1)
    ,[t_jobBy]                                  NVARCHAR(128)
    ,CONSTRAINT [PK_fact_BillingDocumentItem_US] PRIMARY KEY NONCLUSTERED ([BillingDocument], [BillingDocumentItem], [CurrencyTypeID]) NOT ENFORCED
    --,[sk_fact_SalesDocumentItem
    --,[nk_fact_SalesDocumentItem
)
WITH
(
    DISTRIBUTION = HASH (BillingDocument),
    CLUSTERED COLUMNSTORE INDEX
)
GO
