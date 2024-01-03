CREATE TABLE [edw].[dim_BillingDocProject] (
  [SDDocument]     NVARCHAR(10) NOT NULL
, [ProjectID]      NVARCHAR(10)
, [Project]        NVARCHAR(80)
, [ProjectID_Name] NVARCHAR(91)
, [t_applicationId] VARCHAR(32)
, [t_extractionDtm] DATETIME
, CONSTRAINT [PK_dim_BillingDocProject] PRIMARY KEY NONCLUSTERED ([SDDocument]) NOT ENFORCED
)
WITH
  ( DISTRIBUTION = REPLICATE, HEAP )
