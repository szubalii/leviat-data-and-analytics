CREATE TABLE [base_tx_halfen_2_dwh].[FACT_PRODJOURNALPROD]
(
    [DW_Id]                 BIGINT              NOT NULL,
    [DATAAREAID]            NVARCHAR(4)         NULL,
    [INVENTDIMID]           NVARCHAR(20)        NULL,
    [INVENTSITE]            NVARCHAR(10)        NULL,
    [PRODID]                NVARCHAR(20)        NULL,
    [QTYGOOD]               DECIMAL(38, 12)     NULL,
    [QTYERROR]              DECIMAL(38, 12)     NULL,
    [TRANSDATE]             DATETIME            NULL,
    [INVENTTRANSID]         NVARCHAR(24)        NULL,
    [ITEMID]                NVARCHAR(20)        NULL,
    [Unit]                  NVARCHAR(10)        NULL,
    [ItemWeight]            DECIMAL(38, 12)     NULL,
    [ProductionScrap]       DECIMAL(38, 12)     NULL,
    [TransDate_DateKey]     BIGINT              NULL,
    [ReqItemTable_DW_Id]    BIGINT              NULL,
    [DW_Id_Itemid]          BIGINT              NULL,
    [DW_Batch]              BIGINT              NULL,
    [DW_SourceCode]         VARCHAR(15)         NOT NULL,
    [DW_TimeStamp]          DATETIME            NOT NULL,
    [t_applicationId]       VARCHAR(32)         NULL,
    [t_jobId]               VARCHAR(36)         NULL,
    [t_jobDtm]              DATETIME,
    [t_jobBy]               NVARCHAR(128)       NULL,
    [t_extractionDtm]       DATETIME,
    [t_filePath]            NVARCHAR(1024)      NULL,
    CONSTRAINT [PK_FACT_PRODJOURNALPROD] PRIMARY KEY NONCLUSTERED (
        [DW_Id]
    ) NOT ENFORCED
)
    WITH (HEAP, DISTRIBUTION = HASH(INVENTTRANSID));