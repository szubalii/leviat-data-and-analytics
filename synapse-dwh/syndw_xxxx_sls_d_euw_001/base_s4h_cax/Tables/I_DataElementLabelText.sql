-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : I_DataElementLabelText
-- System Version : SAP S/4HANA 1909, SP 0002
-- Description    : Data from table IDATLABELTXT
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CAACLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[I_DataElementLabelText] (
    
    [ABAPDATAELEMENT] NVARCHAR(30) NOT NULL  -- Data element (semantic domain)
  , [LANGUAGE] CHAR(1) NOT NULL  -- Language Key
  , [ABAPDATAELEMENTDESCRIPTION] NVARCHAR(60)  -- Short Description of Repository Objects
  , [ABAPDATAELEMENTHEADING] NVARCHAR(55)  -- Heading
  , [ABAPSHORTFIELDLABEL] NVARCHAR(10)  -- Short Field Label
  , [ABAPMEDIUMFIELDLABEL] NVARCHAR(20)  -- Medium Field Label
  , [ABAPLONGFIELDLABEL] NVARCHAR(40)  -- Long Field Label
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_DataElementLabelText] PRIMARY KEY NONCLUSTERED(
      [ABAPDATAELEMENT]
    , [LANGUAGE]
  ) NOT ENFORCED
) WITH (
  HEAP
)
