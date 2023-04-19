CREATE TABLE [edw].[fact_SalesOrderItemPricingElement] 
(
    [SalesOrder] NVARCHAR(10) NOT NULL  
  , [SalesOrderItem] CHAR(6) NOT NULL  
  , [nk_SalesOrderItem] NVARCHAR(20) NOT NULL 
  , [ConditionType] NVARCHAR(4) 
  , [ConditionBaseValue] DECIMAL(24,9)  
  , [ConditionRateValue] DECIMAL(24,9)  
  , [ConditionAmount] DECIMAL(15,2)  
  , [ExchangeRate] DECIMAL(15,6)  
  , [TransactionCurrencyID] CHAR(5) 
  , [CurrencyTypeID] CHAR(2)
  , [CurrencyType] NVARCHAR(20) 
  , [CurrencyID] CHAR(5)  
  , [ConditionInactiveReason] NVARCHAR(1)
  , [t_applicationId]       VARCHAR (32)
  , [t_jobId]               VARCHAR (36)
  , [t_jobDtm]              DATETIME
  , [t_lastActionCd]        VARCHAR(1)
  , [t_jobBy]               NVARCHAR(128)  
    CONSTRAINT [PK_fact_SalesOrderItemPricingElement] PRIMARY KEY NONCLUSTERED ([SalesOrder], [SalesOrderItem]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = HASH (nk_SalesOrderItem), CLUSTERED COLUMNSTORE INDEX
)
GO