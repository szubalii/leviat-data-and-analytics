CREATE TABLE [edw].[dim_SDDocumentIncompletionLog]
(
    
    [SDDocument]        NVARCHAR(10) NOT NULL
    , [SDDocumentItem]    CHAR(6) NOT NULL
    , [ScheduleLine]      CHAR(4) NOT NULL
    , [FieldText]         NVARCHAR(55)
    , CONSTRAINT [PK_dim_SDDocumentIncompletionLog] PRIMARY KEY NONCLUSTERED(
          [SDDocument]
        , [SDDocumentItem]
        , [ScheduleLine]
    ) NOT ENFORCED
) WITH (
    HEAP
)
