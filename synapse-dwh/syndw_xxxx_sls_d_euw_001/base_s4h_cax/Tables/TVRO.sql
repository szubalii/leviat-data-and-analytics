CREATE TABLE [base_s4h_cax].[TVRO](
  [MANDT]           CHAR(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ROUTE]           NVARCHAR(6) NOT NULL
, [TRAZT]           DECIMAL(5,2) NOT NULL
, [TRAZTD]          DECIMAL(11)
, [TDVZT]           DECIMAL(5,2) NOT NULL
, [TDVZTD]          DECIMAL(11)
, [TDVZND]          DECIMAL(11)
, [SPFBK]           NVARCHAR(2) NOT NULL
, [EXPVZ]           NVARCHAR(1) NOT NULL
, [TDIIX]           NVARCHAR(1) NOT NULL
, [SPZST]           NVARCHAR(10)
, [FAHZTD]          DECIMAL(11)
, [DISTZ]           DECIMAL(13,3)
, [MEDST]           NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [VSART]           NVARCHAR(2)
, [VSAVL]           NVARCHAR(2)
, [VSANL]           NVARCHAR(2)
, [TDLNR]           NVARCHAR(10)
, [ROUTID]          NVARCHAR(100)
, [TCTAB]           NVARCHAR(1)
, [ALLOWED_TWGT]    DECIMAL(8)
, [ALLOWED_UOM]     NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [t_applicationId] VARCHAR (32)
, [t_jobId]         VARCHAR (36)
, [t_jobDtm]        DATETIME
, [t_jobBy]        	NVARCHAR (128)
, [t_extractionDtm]	DATETIME
, [t_filePath]      NVARCHAR (1024)
, CONSTRAINT [PK_TVRO] PRIMARY KEY NONCLUSTERED (
    [MANDT],[ROUTE]
  ) NOT ENFORCED
)
WITH (
  HEAP
)