CREATE TABLE [base_s4h_cax].[I_ProductHierarchyNode](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ProductHierarchyNode] nvarchar(18) NOT NULL
, [ProductHierarchyNodeLevel] char(1) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProductHierarchyNode] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ProductHierarchyNode]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
