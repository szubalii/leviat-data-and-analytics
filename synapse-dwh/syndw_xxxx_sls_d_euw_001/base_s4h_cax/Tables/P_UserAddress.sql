CREATE TABLE [base_s4h_cax].[P_UserAddress]
-- General CDS View for Address
(
  [MANDT] nchar(3) collate Latin1_General_100_BIN2 NOT NULL
, [bname] nvarchar(12) collate Latin1_General_100_BIN2 NOT NULL
, [kostl] nvarchar(8) collate Latin1_General_100_BIN2
, [idadtype] char(2) collate Latin1_General_100_BIN2
, [persnumber] nvarchar(10) collate Latin1_General_100_BIN2
, [addrnumber] nvarchar(10) collate Latin1_General_100_BIN2
, [bpperson] binary(16)
, [template_orgaddr] nvarchar(10) collate Latin1_General_100_BIN2
, [techdesc] nvarchar(80) collate Latin1_General_100_BIN2
, [class] nvarchar(12) collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]             DATETIME
, [t_jobBy]        NVARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [PK_P_UserAddress] PRIMARY KEY NONCLUSTERED([MANDT],[bname]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
