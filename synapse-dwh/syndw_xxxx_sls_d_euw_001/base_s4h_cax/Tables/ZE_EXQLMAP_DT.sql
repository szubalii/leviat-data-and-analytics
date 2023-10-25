CREATE TABLE [base_s4h_cax].[ZE_EXQLMAP_DT](
    [GLACCOUNT]             VARCHAR(12) NOT NULL
    ,[FUNCTIONALAREA]       VARCHAR(64)
    ,[TRANSACTIONTYPE]      VARCHAR(64)
    ,[TRADINGPARTNER]       VARCHAR(64)
    ,[CONTIGENCY1]          VARCHAR(64)
    ,[CONTIGENCY2]          VARCHAR(64)
    ,[CONTIGENCY3]          VARCHAR(64)
    ,[CONTIGENCY4]          VARCHAR(64)
    ,[CONTIGENCY5]          VARCHAR(64)
    ,[CONTIGENCY6]          VARCHAR(64)
    ,[CONTIGENCY7]          VARCHAR(64)
    ,[REKNR]                VARCHAR(64)
    ,[REKOMS]               VARCHAR(256)
    ,[DI1NR]                VARCHAR(64)
    ,[DI2NR]                VARCHAR(64)
    ,[REFNR]                VARCHAR(64)
    ,[ORGNR_COR]            VARCHAR(64)
    ,[TRANR]                VARCHAR(64)
    ,[CATNR]                VARCHAR(64)
    ,[JNLOMS]               VARCHAR(64)
    ,[XLSBLD]               VARCHAR(64)
    ,[t_applicationId]       VARCHAR(32)    NULL
    ,[t_jobId]               VARCHAR(36)    NULL
    ,[t_jobDtm]              DATETIME       NULL
    ,[t_jobBy]               NVARCHAR(128)  NULL
    ,[t_filePath]            NVARCHAR(1024) NULL
)
WITH (
  HEAP
)


