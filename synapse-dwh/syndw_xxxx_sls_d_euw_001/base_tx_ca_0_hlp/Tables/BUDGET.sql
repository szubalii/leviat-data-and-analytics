CREATE TABLE [base_tx_ca_0_hlp].[BUDGET] (
    [DATAAREAID]      NVARCHAR(8)     NOT NULL,
    [INOUT]           NVARCHAR(1)     NOT NULL,
    [DIM3DATAR]       NVARCHAR(20)    NOT NULL,
    [ITEMID]          NVARCHAR(40)    NOT NULL,
    [ACCOUNTINGDATE]  DATETIME        NOT NULL,
    [BUDGETLOC]       NUMERIC(38, 12) NOT NULL,
    [BUDGETEUR]       NUMERIC(38, 12) NOT NULL,
    [t_applicationId] VARCHAR(32)     NULL,
    [t_jobId]         VARCHAR(36)     NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR(128)   NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR(1024)  NULL
)
    WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);