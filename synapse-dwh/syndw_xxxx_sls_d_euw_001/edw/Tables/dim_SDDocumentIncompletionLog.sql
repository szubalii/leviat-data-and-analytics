CREATE TABLE [edw].[dim_SDDocumentIncompletionLog]
(
    
      [MANDT] CHAR(3) NOT NULL  -- Client
    , [SDDocument] NVARCHAR(10) NOT NULL
    , [SDDocumentItem] CHAR(6) NOT NULL
    , [ScheduleLine] CHAR(4) NOT NULL
    , [PartnerFunction] NVARCHAR(2) NOT NULL
    , [SDDocumentTextID] NVARCHAR(4) NOT NULL
    , [SDDocumentTable] NVARCHAR(30) NOT NULL
    , [SDDocumentTableField] NVARCHAR(30) NOT NULL
    , [FieldName]         NVARCHAR(55)
    , [FieldDescription]  NVARCHAR(60)
    , [t_applicationId]   VARCHAR(32)
    , [t_jobId]           VARCHAR(36)
    , [t_jobDtm]          DATETIME   
    , [t_lastActionCd]    VARCHAR(1)
    , [t_jobBy]           NVARCHAR(128)
    , CONSTRAINT [PK_dim_SDDocumentIncompletionLog] PRIMARY KEY NONCLUSTERED(
          [MANDT]
        , [SDDocument]
        , [SDDocumentItem]
        , [ScheduleLine]
        , [PartnerFunction]
        , [SDDocumentTextID]
        , [SDDocumentTable]
        , [SDDocumentTableField]
    ) NOT ENFORCED
) WITH (
    DISTRIBUTION = REPLICATE
)
