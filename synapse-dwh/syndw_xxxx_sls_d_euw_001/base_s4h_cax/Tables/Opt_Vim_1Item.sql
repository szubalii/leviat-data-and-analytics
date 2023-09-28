CREATE TABLE [base_s4h_cax].[Opt_Vim_1Item]
(
    MANDT               VARCHAR(3)      NOT NULL
    ,DocID              NVARCHAR(12)    NOT NULL
    ,ItemID             NVARCHAR(5)     NOT NULL
    ,BUKRS              VARCHAR(4)
    ,EBELN              VARCHAR(10)
    ,EBELP              NVARCHAR(5)
    ,MATNR              VARCHAR(40)
    ,MAKTX              VARCHAR(40)
    ,MENGE              DECIMAL(13,3)
    ,BSTME              VARCHAR(3)
    ,BPRME              VARCHAR(3)
    ,WRBTR              DECIMAL(23,2)
    ,WERKS              VARCHAR(4)
    ,SHKZG              VARCHAR(1)                
    ,Cond_Type          VARCHAR(4)
    ,NetPr              DECIMAL(11,2)
    ,KOSTL              VARCHAR(10)                
    ,EREKZ              VARCHAR(1)
    ,HKONT              VARCHAR(10)
    ,AUFNR              VARCHAR(12)
    ,SGTXT              VARCHAR(50)
    ,KOKRS              VARCHAR(4)
    ,PRCTR              VARCHAR(10)
    ,VBELN              VARCHAR(10)
    ,VBELP              VARCHAR(6)
    ,ETENR              NVARCHAR(4)
    ,MWSKZ              VARCHAR(2)
    ,Ref_Doc            VARCHAR(10)
    ,Ref_Doc_Year       NVARCHAR(4)
    ,Ref_Doc_It         NVARCHAR(4)
    ,BWKEY              VARCHAR(4)
    ,BSMNG              DECIMAL(13,3)
    ,REMNG              DECIMAL(13,3)
    ,WEMNG              DECIMAL(13,3)
    , [t_applicationId]       VARCHAR (32)
    , [t_jobId]               VARCHAR (36)
    , [t_jobDtm]             DATETIME
    , [t_jobBy]        NVARCHAR (128)
    , [t_filePath]            NVARCHAR (1024)
    , [t_extractionDtm]             DATETIME
    , CONSTRAINT [PK_OPT_VIM_1ITEM] PRIMARY KEY NONCLUSTERED (
    [MANDT], [DocID], [ItemID]
  ) NOT ENFORCED
)
WITH ( 
  HEAP
)
    