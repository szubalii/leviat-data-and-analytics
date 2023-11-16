-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : I_SDDocumentIncompletionLog
-- System Version : SAP S/4HANA 1909, SP 0002
-- Description    : Data from table ISDDOCINCMPLTLOG
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CAACLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[I_SDDocumentIncompletionLog] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [SDDocument] NVARCHAR(10) NOT NULL  -- Sales and Distribution Document Number
  , [SDDocumentItem] CHAR(6) NOT NULL  -- Item number of the SD document
  , [ScheduleLine] CHAR(4) NOT NULL  -- Schedule Line Number
  , [PartnerFunction] NVARCHAR(2) NOT NULL  -- Partner Function
  , [SDDocumentTextID] NVARCHAR(4) NOT NULL  -- Text ID
  , [SDDocumentTable] NVARCHAR(30) NOT NULL  -- Table for documents in Sales
  , [SDDocumentTableField] NVARCHAR(30) NOT NULL  -- Document field name
  , [IncompletionProcedure] NVARCHAR(2)  -- Incompleteness Procedure for Sales Document
  , [IncompletionStatusGroup] NVARCHAR(2)  -- Status group
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_SDDocumentIncompletionLog] PRIMARY KEY NONCLUSTERED(
      
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
  HEAP
)
