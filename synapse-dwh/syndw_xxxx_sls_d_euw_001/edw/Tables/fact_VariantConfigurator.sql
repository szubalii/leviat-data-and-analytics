﻿CREATE TABLE [edw].[fact_VariantConfigurator]
(
    [SalesDocument]                 NVARCHAR(20) NOT NULL,
    [SalesDocumentItem]             NVARCHAR(24) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [ProductID]                     NVARCHAR(40),
    [ProductExternalID]             NVARCHAR(40),
    [SO_ITEM_PROD_HIERARCHY]        NVARCHAR(2000),
    [SO_ITEM_PROD_HIERARCHY1]       NVARCHAR(2000),
    [HM_LENGTH]                     DECIMAL (31, 14),
    [HM_MATERIAL]                   NVARCHAR(2000),
    [HM_PROFILE]                    NVARCHAR(2000),
    [HTA_ANCHOR]                    NVARCHAR(2000),
    [HTA_FILLER]                    NVARCHAR(2000),
    [HTA_LENGTH]                    DECIMAL (31, 14),
    [HTA_MATERIAL]                  NVARCHAR(2000),
    [HTA_PROFILE]                   NVARCHAR(2000),
    [HZA_ANCHOR]                    NVARCHAR(2000),
    [HZA_PROFILE]                   NVARCHAR(2000),
    [HZA_PS_ANCHOR]                 NVARCHAR(2000),
    [HZA_PS_MATERIAL]               NVARCHAR(2000),
    [HZA_PS_PROFILE]                NVARCHAR(2000),
    [HDB_DIAM]                      DECIMAL (31, 14),
    [HDB_HEIGHT]                    DECIMAL (31, 14),
    [HDB_LENGTH]                    DECIMAL (31, 14),
    [HDB_STUD_TYPE]                 NVARCHAR(2000),
    [HDB_STUDQTY]                   DECIMAL (31, 14),
    [HDB_TYPE]                      NVARCHAR(2000),
    [HIT_CON_COV]                   DECIMAL (31, 14),
    [HIT_CSB_QTY]                   DECIMAL (31, 14),
    [HIT_HEIGHT]                    DECIMAL (31, 14),
    [HIT_MVX_ES]                    NVARCHAR(2000),
    [HIT_TB_QTY]                    DECIMAL (31, 14),
    [HIT_TYPE]                      NVARCHAR(2000),
    [HIT_WIDTH]                     DECIMAL (31, 14),
    [HDBZ_STUD_DIAM]                DECIMAL (31, 14),
    [HDBZ_STUD_LENGTH]              DECIMAL (31, 14),
    [HIT_QS_DIAM]                   DECIMAL (31, 14),
    [HIT_QS_QTY]                    DECIMAL (31, 14),
    [HIT_QS_TYPE]                   NVARCHAR(2000),
    [HIT_VARRIANT]                  NVARCHAR(2000),
    [HBS05_BAR_DESIGN]              NVARCHAR(2000),
    [HDBZ_CC_BOTTOM]                DECIMAL (31, 14),
    [HDBZ_CC_TOP]                   DECIMAL (31, 14),
    [HDBZ_DIAM]                     DECIMAL (31, 14),
    [HDBZ_HEIGHT]                   DECIMAL (31, 14),
    [HIT_STUFFE]                    NVARCHAR(2000),
    [MAT_DESCRIPTION_S]             NVARCHAR(2000),
    [t_applicationId]               VARCHAR(32),
    [t_extractionDtm]               DATETIME,
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                varchar(1),
    [t_jobBy]                       VARCHAR(128),
    CONSTRAINT [PK_fact_VariantConfigurator] PRIMARY KEY NONCLUSTERED
        ([SalesDocument],
         [SalesDocumentItem])
        NOT ENFORCED)
WITH ( DISTRIBUTION = HASH ([SalesDocument]), CLUSTERED COLUMNSTORE INDEX );
GO