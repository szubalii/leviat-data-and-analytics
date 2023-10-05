CREATE TABLE [base_s4h_cax].[I_StorageLocation](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Plant] nvarchar(4) NOT NULL
, [StorageLocation] nvarchar(4) NOT NULL
, [StorageLocationName] nvarchar(16)
, [SalesOrganization] nvarchar(4)
, [DistributionChannel] nvarchar(2)
, [Division] nvarchar(2)
, [IsStorLocAuthznCheckActive] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_StorageLocation] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Plant], [StorageLocation]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
