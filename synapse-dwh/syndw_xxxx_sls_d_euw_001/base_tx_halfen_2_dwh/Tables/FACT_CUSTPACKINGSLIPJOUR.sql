CREATE TABLE [base_tx_halfen_2_dwh].[FACT_CUSTPACKINGSLIPJOUR]
(
    [DW_Id]                [bigint]       NOT NULL,
    [DATAAREAID]           [nvarchar](4)  NULL,
    [PACKINGSLIPID]        [nvarchar](20) NOT NULL,
    [DLVCOUNTRYREGIONID]   [nvarchar](10) NULL,
    [DELIVERYDATE]         [datetime]     NULL,
    [DLVMODE]              [nvarchar](10) NULL,
    [SALESID]              [nvarchar](20) NULL,
    [HALINVENTSITEID]      [nvarchar](10) NULL,
    [INVENTLOCATIONID]     [nvarchar](10) NULL,
    [DateKey_DeliveryDate] [bigint]       NULL,
    [CountryRegion_DW_Id]  [bigint]       NULL,
    [ORDERACCOUNT]         [nvarchar](20) NULL,
    [DW_Batch]             [bigint]       NULL,
    [DW_SourceCode]        [varchar](15)  NOT NULL,
    [DW_TimeStamp]         [datetime]     NOT NULL,
    [t_applicationId]      VARCHAR(32)    NULL,
    [t_jobId]              VARCHAR(36)    NULL,
    [t_jobDtm]             DATETIME,
    [t_jobBy]              NVARCHAR(128)  NULL,
    [t_extractionDtm]      DATETIME,
    [t_filePath]           NVARCHAR(1024) NULL,
    CONSTRAINT [PK_FACT_CUSTPACKINGSLIPJOUR] PRIMARY KEY NONCLUSTERED ([PACKINGSLIPID]) NOT ENFORCED
)
    WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);