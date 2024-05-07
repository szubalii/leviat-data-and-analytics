CREATE TABLE [base_s4h_cax].[MSTA](
-- Material Master Status
  [MANDT]           CHAR(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [MATNR]           NVARCHAR(40) NOT NULL
, [STATM]           CHAR(1) NOT NULL
, [ZHLER]           CHAR(5) NOT NULL
, [ERSDA]           DATE
, [ERNAM]           NVARCHAR(12)
, [LAEDA]           DATE
, [AENAM]           NVARCHAR(12)
, [WERKS]           NVARCHAR(4)
, [LGORT]           NVARCHAR(4)
, [LGNUM]           NVARCHAR(3)
, [LGTYP]           NVARCHAR(3)
, [VKORG]           NVARCHAR(4)
, [VTWEG]           NVARCHAR(2)
, [BWKEY]           NVARCHAR(4)
, [BWTAR]           NVARCHAR(10)
, [t_applicationId] VARCHAR (32)
, [t_jobId]         VARCHAR (36)
, [t_jobDtm]        DATETIME
, [t_jobBy]        	NVARCHAR (128)
, [t_extractionDtm]	DATETIME
, [t_filePath]      NVARCHAR (1024)
, CONSTRAINT [PK_MSTA] PRIMARY KEY NONCLUSTERED (
    [MANDT],[MATNR],[STATM],[ZHLER]
  ) NOT ENFORCED
)
WITH (
  HEAP
)