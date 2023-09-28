CREATE TABLE [base_s4h_cax].[Opt_Vim_1Item]
(
    MANDT               NVARCHAR(3)      NOT NULL
    ,DocID              NVARCHAR(12)    NOT NULL
    ,ItemID             NVARCHAR(5)     NOT NULL
    ,BUKRS              NVARCHAR(4)
    ,EBELN              NVARCHAR(10)
    ,EBELP              NVARCHAR(5)
    ,MATNR              NVARCHAR(40)
    ,MAKTX              NVARCHAR(40)
    ,MENGE              DECIMAL(13,3)
    ,BSTME              NVARCHAR(3)
    ,BPRME              NVARCHAR(3)
    ,WRBTR              DECIMAL(23,2)
    ,WERKS              NVARCHAR(4)
    ,SHKZG              NVARCHAR(1)                
    ,Cond_Type          NVARCHAR(4)
    ,NetPr              DECIMAL(11,2)
    ,KOSTL              NVARCHAR(10)                
    ,EREKZ              NVARCHAR(1)
    ,HKONT              NVARCHAR(10)
    ,AUFNR              NVARCHAR(12)
    ,SGTXT              NVARCHAR(50)
    ,KOKRS              NVARCHAR(4)
    ,PRCTR              NVARCHAR(10)
    ,VBELN              NVARCHAR(10)
    ,VBELP              NVARCHAR(6)
    ,ETENR              NVARCHAR(4)
    ,MWSKZ              NVARCHAR(2)
    ,Ref_Doc            NVARCHAR(10)
    ,Ref_Doc_Year       NVARCHAR(4)
    ,Ref_Doc_It         NVARCHAR(4)
    ,BWKEY              NVARCHAR(4)
    ,BSMNG              DECIMAL(13,3)
    ,REMNG              DECIMAL(13,3)
    ,WEMNG              DECIMAL(13,3)
    --from Opt_Vim_1Head
    ,Bus_ObjType        NVARCHAR(10)
    ,Status             NVARCHAR(2)
    ,NoFirstPass        NVARCHAR(1)
    ,GJAHR              NVARCHAR(4)
    ,BLART              NVARCHAR(2)
    ,BLDAT              DATE    
    ,BUDAT              DATE
    ,XBLNR              NVARCHAR(16)     
    ,WAERS              NVARCHAR(5)                       
    ,LIFNR              NVARCHAR(10)                
    ,BKTXT              NVARCHAR(25)                
    ,LAND1              NVARCHAR(3)                
    --from Opt_Vim_2Head                
    ,BELNR_MM           NVARCHAR(10)
    ,BELNR_FI           NVARCHAR(10)  
    ,POSTING_USER       NVARCHAR(12)          
    , [t_applicationId]       NVARCHAR (32)
    , [t_jobId]               NVARCHAR (36)
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
    