CREATE TABLE [edw].[fact_SDDocumentIncompletionLog]
(
    
    [SDDocument]          NVARCHAR(10) NOT NULL
    , [SDDocumentItem]    CHAR(6) NOT NULL
    , [ScheduleLine]      CHAR(4) NOT NULL
    , [FieldName]         NVARCHAR(55)
    , [t_applicationId]   VARCHAR(32)
    , [t_jobId]           VARCHAR(36)
    , [t_jobDtm]          DATETIME   
    , [t_lastActionCd]    VARCHAR(1)
    , [t_jobBy]           NVARCHAR(128)
    , CONSTRAINT [PK_fact_SDDocumentIncompletionLog] PRIMARY KEY NONCLUSTERED(
          [SDDocument]
        , [SDDocumentItem]
        , [ScheduleLine]
    ) NOT ENFORCED
) WITH (
    HEAP
)
