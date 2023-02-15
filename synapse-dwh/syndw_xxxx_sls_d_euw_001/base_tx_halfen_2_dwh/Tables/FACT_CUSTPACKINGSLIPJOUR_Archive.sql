CREATE TABLE [base_tx_halfen_2_dwh].[FACT_CUSTPACKINGSLIPJOUR_Archive]
(
    [DW_Id]                BIGINT       NOT NULL,
    [DATAAREAID]           NVARCHAR(4)  NULL,
    [PACKINGSLIPID]        NVARCHAR(20) NOT NULL,
    [DLVCOUNTRYREGIONID]   NVARCHAR(10) NULL,
    [DELIVERYDATE]         DATETIME     NULL,
    [DLVMODE]              NVARCHAR(10) NULL,
    [SALESID]              NVARCHAR(20) NULL,
    [HALINVENTSITEID]      NVARCHAR(10) NULL,
    [INVENTLOCATIONID]     NVARCHAR(10) NULL,
    [DateKey_DeliveryDate] BIGINT       NULL,
    [CountryRegion_DW_Id]  BIGINT       NULL,
    [ORDERACCOUNT]         NVARCHAR(20) NULL,
    [DW_Batch]             BIGINT       NULL,
    [DW_SourceCode]        VARCHAR(15)  NOT NULL,
    [DW_TimeStamp]         DATETIME     NOT NULL,
    [t_applicationId]      VARCHAR(32)    NULL,
    [t_jobId]              VARCHAR(36)    NULL,
    [t_jobDtm]             DATETIME,
    [t_jobBy]              NVARCHAR(128)  NULL,
    [t_extractionDtm]      DATETIME,
    [t_filePath]           NVARCHAR(1024) NULL,
    CONSTRAINT [PK_FACT_CUSTPACKINGSLIPJOUR_Archive] PRIMARY KEY NONCLUSTERED ([PACKINGSLIPID]) NOT ENFORCED
)
WITH 
(
	DISTRIBUTION = HASH ([DW_Id]),
	CLUSTERED COLUMNSTORE INDEX
);