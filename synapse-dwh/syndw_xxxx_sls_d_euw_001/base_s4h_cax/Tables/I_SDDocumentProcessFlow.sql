CREATE TABLE [base_s4h_cax].[I_SDDocumentProcessFlow] (
    [DOCRELATIONSHIPUUID] BINARY(16) NOT NULL  -- SD Unique Document Relationship Identification
  , [PrecedingDocument] NVARCHAR(10) -- Preceding sales and distribution document
  , [PrecedingDocumentItem] CHAR(6)  -- Preceding Item of an SD Document
  , [PrecedingDocumentCategory] NVARCHAR(4)  -- Document Category of Preceding SD Document
  , [SubsequentDocument] NVARCHAR(10)  -- Subsequent Sales and Distribution Document
  , [SubsequentDocumentItem] CHAR(6)  -- Subsequent Item of an SD Document
  , [SubsequentDocumentCategory] NVARCHAR(4)  -- Document Category of Subsequent Document
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_SDDocumentProcessFlow] PRIMARY KEY NONCLUSTERED(
      [DOCRELATIONSHIPUUID]
  ) NOT ENFORCED
) WITH (
  HEAP
)
