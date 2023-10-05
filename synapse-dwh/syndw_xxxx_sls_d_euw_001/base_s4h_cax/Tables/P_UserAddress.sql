CREATE TABLE [base_s4h_cax].[P_UserAddress]
-- General CDS View for Address
(
  [MANDT] nchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [BNAME] nvarchar(12) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [KOSTL] nvarchar(8) -- collate Latin1_General_100_BIN2
, [IDADTYPE] char(2) -- collate Latin1_General_100_BIN2
, [PERSNUMBER] nvarchar(10) -- collate Latin1_General_100_BIN2
, [ADDRNUMBER] nvarchar(10) -- collate Latin1_General_100_BIN2
, [BPPERSON] binary(16)
, [TEMPLATE_ORGADDR] nvarchar(10) -- collate Latin1_General_100_BIN2
, [TECHDESC] nvarchar(80) -- collate Latin1_General_100_BIN2
, [CLASS] nvarchar(12) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]             DATETIME
, [t_jobBy]        NVARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [PK_P_UserAddress] PRIMARY KEY NONCLUSTERED([MANDT],[BNAME]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
