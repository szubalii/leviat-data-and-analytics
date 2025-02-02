﻿CREATE TABLE [base_tx_halfen_2_dwh].[FACT_SALESTABLE](
    [DW_Id]						    BIGINT NOT NULL,
    [DATAAREAID]                    NVARCHAR  (4) NULL,
    [DELIVERYCOUNTRYREGIONID]       NVARCHAR (10) NULL,
    [DELIVERYZIPCODE]               NVARCHAR (10) NULL,
    [DLVMODE]                       NVARCHAR (10) NULL,
    [SALESID]                       NVARCHAR (20) NULL,
    [INVENTSITEID]                  NVARCHAR (10) NULL,
    [INVENTLOCATIONID]              NVARCHAR (10) NULL,
    [SHIPPINGDATEREQUESTED]         DATETIME NULL,
    [SALESTAKER]                    NVARCHAR (20) NULL,
    [DLVTERM]                       NVARCHAR (10) NULL,
    [PAYMENT]                       NVARCHAR (10) NULL,
    [HPLCUSTOMEROBJECTID]           NVARCHAR (20) NULL,
    [INVOICEACCOUNT]                NVARCHAR (20) NULL,
    [HPLBUSINESSRULESTATUSID]       NVARCHAR (30) NULL,
    [HPLINVOICECOUNTRYREGIONID]     NVARCHAR (10) NULL,
    [HLFSEGMENTID]                  NVARCHAR  (4) NULL,
    [SALESGROUP]                    NVARCHAR (10) NULL,
    [RETURNREASONCODEID]            NVARCHAR (10) NULL,
    [CREATEDDATETIME]               DATETIME NULL,
    [SALESTYPE]                     INT NULL,
    [SALESSTATUS]                   INT NULL,
    [QUOTATIONID]                   NVARCHAR (20) NULL,
    [DeliveredAsRequested]			BIGINT NULL,
    [DeliveredAsRequested_2]		BIGINT NULL,
    [Country_DW_Id]				    BIGINT NULL,
    [ZipCode_DW_Id]				    BIGINT NULL,
    [ShippingDateRequested_DateKey]	BIGINT NULL,
    [TotalWeight]			        BIGINT NULL,
    [WeightClass]			        BIGINT NULL,
    [Segment_DW_Id]				    BIGINT NULL,
    [DW_Id_CustomerObject]			BIGINT NULL,
    [Createddatetime_Datekey]		BIGINT NULL,
    [DW_Batch]						BIGINT NULL,
    [DW_SourceCode]                 VARCHAR    (15) NOT NULL,
    [DW_TimeStamp]                  DATETIME        NOT NULL,
    [t_applicationId]               VARCHAR    (32)  NULL,
    [t_jobId]                       VARCHAR    (36)  NULL,
    [t_jobDtm]                      DATETIME,
    [t_jobBy]                       NVARCHAR  (128)  NULL,
    [t_extractionDtm]               DATETIME,
    [t_filePath]                    NVARCHAR (1024)  NULL,
    CONSTRAINT [PK_FACT_SALESTABLE] PRIMARY KEY NONCLUSTERED (
        [DW_Id] ASC
    ) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);