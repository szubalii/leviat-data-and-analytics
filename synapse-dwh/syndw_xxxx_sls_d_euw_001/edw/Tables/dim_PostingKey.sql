CREATE TABLE [edw].[dim_PostingKey] (
-- Posting Key
  [PostingKeyID] nvarchar(4) NOT NULL --renamed (ex PostingKey)
--, [Language] char(1)  --from [base_s4h_cax].[I_PostingKeyText]
, [PostingKey] nvarchar(40) -- renamed (ex PostingKeyName) from [base_s4h_cax].[I_PostingKeyText]
, [DebitCreditCode] nvarchar(2)
, [FinancialAccountType] nvarchar(2)
, [IsSalesRelated] nvarchar(2)
, [IsUsedInPaymentTransaction] nvarchar(2)
, [ReversalPostingKey] nvarchar(4)
, [IsSpecialGLTransaction] nvarchar(2)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
,    CONSTRAINT [PK_dim_PostingKey] PRIMARY KEY NONCLUSTERED ([PostingKeyID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
