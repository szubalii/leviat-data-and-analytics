CREATE TABLE [base_ff].[ShippingPointLogistics] (
  ShippingPointID NVARCHAR(4) NOT NULL,
  LogisticsAreaInM2 DECIMAL(10, 2),
  FTELogistics DECIMAL(10, 2),
  ,[t_applicationId]           VARCHAR   (32) NULL
  ,[t_jobId]                   VARCHAR   (36) NULL
  ,[t_jobDtm]                 DATETIME        NULL
  ,[t_jobBy]                  NVARCHAR  (128) NULL
  ,[t_filePath]               NVARCHAR (1024) NULL
  ,CONSTRAINT [PK_ShippingPointLogistics] PRIMARY KEY NONCLUSTERED ([ShippingPointID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP 
)
