CREATE TABLE [base_s4h_cax].[I_PaymentTermsConditions](
  [PaymentTerms] nvarchar(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [PaymentTermsValidityMonthDay] char(2) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [PaymentTermsFinAccountType] nvarchar(1) -- collate Latin1_General_100_BIN2
, [CashDiscount1Days] decimal(3)
, [CashDiscount2Days] decimal(3)
, [NetPaymentDays] decimal(3)
, [CashDiscount1Percent] decimal(5,3)
, [CashDiscount2Percent] decimal(5,3)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_PaymentTermsConditions] PRIMARY KEY NONCLUSTERED (
    [PaymentTerms], [PaymentTermsValidityMonthDay]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
