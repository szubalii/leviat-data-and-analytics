-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : Pfcg_Role_To_User
-- System Version : SAP S/4HANA 1909, SP 0002
-- Description    : Data from table PFCGROLE2USER_V
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CAACLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[Pfcg_Role_To_User] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [User_Name] NVARCHAR(12) NOT NULL  -- User Name in User Master Record
  , [Role_Name] NVARCHAR(30) NOT NULL  -- Role Name
  , [Valid_From] DATE NOT NULL  -- Date of validity
  , [Valid_To] DATE NOT NULL  -- Date of validity
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_Pfcg_Role_To_User] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [User_Name]
    , [Role_Name]
    , [Valid_From]
    , [Valid_To]
  ) NOT ENFORCED
) WITH (
  HEAP
)
