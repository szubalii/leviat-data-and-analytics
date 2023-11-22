-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : I_ChangeDocumentItem
-- System Version : SAP S/4HANA 2022, SP 0001
-- Description    : Data from table ICHANGEDOCITEM
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CAACLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[I_ChangeDocumentItem_VBEP_EDATU] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [ChangeDocObject] NVARCHAR(90) NOT NULL  -- Object Value
  , [ChangeDocObjectClass] NVARCHAR(15) NOT NULL  -- Object class
  , [ChangeDocument] NVARCHAR(10) NOT NULL  -- Change Number of Document
  , [DatabaseTable] NVARCHAR(30) NOT NULL  -- Table Name
  , [ChangeDocTableKey] NVARCHAR(70) NOT NULL  -- Changed table record key
  , [ChangeDocDatabaseTableField] NVARCHAR(30) NOT NULL  -- Field Name
  , [ChangeDocItemChangeType] NVARCHAR(1) NOT NULL  -- Type of Change
  , [ChangeDocPreviousUnit] NVARCHAR(3)  -- Change documents, unit referenced
  , [ChangeDocNewUnit] NVARCHAR(3)  -- Change documents, unit referenced
  , [ChangeDocPreviousCurrency] CHAR(5)  -- Change documents, referenced currency
  , [ChangeDocNewCurrency] CHAR(5)  -- Change documents, referenced currency
  , [ChangeDocNewFieldValue] NVARCHAR(254)  -- New Content of Changed Field
  , [ChangeDocPreviousFieldValue] NVARCHAR(254)  -- Old Content of Changed Field
  , [ChangeDocTextIsChanged] NVARCHAR(1)  -- Flag: X = Text Change
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_ChangeDocumentItem_VBEP_EDATU] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [ChangeDocObject]
    , [ChangeDocObjectClass]
    , [ChangeDocument]
    , [DatabaseTable]
    , [ChangeDocTableKey]
    , [ChangeDocDatabaseTableField]
    , [ChangeDocItemChangeType]
  ) NOT ENFORCED
) WITH (
  HEAP
)
