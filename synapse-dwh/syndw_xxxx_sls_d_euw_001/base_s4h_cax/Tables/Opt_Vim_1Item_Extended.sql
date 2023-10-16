CREATE TABLE [base_s4h_cax].[Opt_Vim_1Item_Extended]
(
  MANDT              NVARCHAR(3) NOT NULL
, DOCID              NVARCHAR(12) NOT NULL
, ITEMID             NVARCHAR(5) NOT NULL
, BUKRS              NVARCHAR(4)
, EBELN              NVARCHAR(10)
, EBELP              NVARCHAR(5)
, MATNR              NVARCHAR(40)
, MENGE              DECIMAL(13, 3)
, BSTME              NVARCHAR(3)
, BPRME              NVARCHAR(3)
, WRBTR              DECIMAL(23, 2)
, WERKS              NVARCHAR(4)
, SHKZG              NVARCHAR(1)
, COND_TYPE          NVARCHAR(4)
, NETPR              DECIMAL(11, 2)
, KOSTL              NVARCHAR(10)
, EREKZ              NVARCHAR(1)
, HKONT              NVARCHAR(10)
, AUFNR              NVARCHAR(12)
, SGTXT              NVARCHAR(50)
, KOKRS              NVARCHAR(4)
, PRCTR              NVARCHAR(10)
, VBELN              NVARCHAR(10)
, VBELP              NVARCHAR(6)
, ETENR              NVARCHAR(4)
, MWSKZ              NVARCHAR(2)
, REF_DOC            NVARCHAR(10)
, REF_DOC_YEAR       NVARCHAR(4)
, REF_DOC_IT         NVARCHAR(4)
, BWKEY              NVARCHAR(4)
, BSMNG              DECIMAL(13, 3)
, REMNG              DECIMAL(13, 3)
, WEMNG              DECIMAL(13, 3)
--from Opt_Vim_1Head
, DOCTYPE            NVARCHAR(10)
, BUS_OBJTYPE        NVARCHAR(10)
, STATUS             NVARCHAR(2)
, NOFIRSTPASS        NVARCHAR(1)
, GJAHR              NVARCHAR(4)
, BLART              NVARCHAR(2)
, BLDAT              DATE
, BUDAT              DATE
, XBLNR              NVARCHAR(16)
, WAERS              NVARCHAR(5)
, LIFNR              NVARCHAR(10)
, BKTXT              NVARCHAR(25)
, LAND1              NVARCHAR(3)
--from Opt_Vim_2Head                
, BELNR_MM           NVARCHAR(10)
, BELNR_FI           NVARCHAR(10)
, POSTING_USER       NVARCHAR(12)
, [t_applicationId]  NVARCHAR (32)
, [t_jobId]          NVARCHAR (36)
, [t_jobDtm]         DATETIME
, [t_jobBy]          NVARCHAR (128)
, [t_filePath]       NVARCHAR (1024)
, [t_extractionDtm]  DATETIME
, CONSTRAINT [PK_OPT_VIM_1ITEM] PRIMARY KEY NONCLUSTERED (
    [MANDT], [DOCID], [ITEMID]
  ) NOT ENFORCED
)
WITH ( 
  HEAP
)
    