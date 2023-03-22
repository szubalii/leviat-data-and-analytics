CREATE TABLE [base_tx_halfen_2_dwh].[FACT_PURCHLINE_Archive]
(
    [DW_Id]                             BIGINT                NOT NULL,
    [CONFIRMEDDLV]                      DATETIME              NULL,
    [DATAAREAID]                        NVARCHAR(4)           NULL,
    [DELIVERYDATE]                      DATETIME              NULL,
    [DELIVERYDATE_tf]                   DATETIME              NULL,
    [INVENTTRANSID]                     NVARCHAR(24)          NULL,
    [INVENTREFTRANSID]                  NVARCHAR(24)          NULL,
    [INVENTREFID]                       NVARCHAR(20)          NULL,
    [PURCHID]                           NVARCHAR(20)          NULL,
    [VENDACCOUNT]                       NVARCHAR(20)          NULL,
    [ITEMREFTYPE]                       BIGINT                NULL,
    [SOLink]                            BIGINT                NULL,
    [ITEMID]                            NVARCHAR(20)          NULL,
    [INVENTDIMID]                       NVARCHAR(20)          NULL,
    [QTYORDERED]                        DECIMAL(38, 12)       NULL,
    [Open_Qty]                          DECIMAL(38, 12)       NULL,
    [REMAININVENTPHYSICAL]              DECIMAL(38, 12)       NULL,
    [REMAININVENTFINANCIAL]             DECIMAL(38, 12)       NULL,
    [HALSURCHARGEAMOUNT1]               DECIMAL(38, 12)       NULL,
    [HALSURCHARGEAMOUNT2]               DECIMAL(38, 12)       NULL,
    [LINEAMOUNT]                        DECIMAL(38, 12)       NULL,
    [CURRENCYCODE]                      NVARCHAR(3)           NULL,
    [CREATEDDATETIME]                   DATETIME              NULL,
    [Company_DefaultCurrency2]          NVARCHAR(3)           NULL,
    [ExchRate_EUR_Createddatetime]      DECIMAL(38, 12)       NULL,
    [ExchRate_EUR_Createddatetime_2]    DECIMAL(38, 12)       NULL,
    [LineAmount_EUR]                    DECIMAL(38, 12)       NULL,
    [Open_Amount_EUR]                   DECIMAL(38, 12)       NULL,
    [ReqDateLinkedSO]                   BIGINT                NULL,
    [InventSite]                        NVARCHAR(10)          NULL,
    [InventLocation]                    NVARCHAR(10)          NULL,
    [DateKey_DeliveryDate]              BIGINT                NULL,
    [VendTable_DW_Id]                   BIGINT                NULL,
    [ReqItemTable_DW_Id]                BIGINT                NULL,
    [DateKey_Deliverydate_tf]           BIGINT                NULL,
    [DW_Id_Itemid]                      BIGINT                NULL,
    [DW_Batch]                          BIGINT                NULL,
    [DW_SourceCode]                     VARCHAR(15)           NOT NULL,
    [DW_TimeStamp]                      DATETIME              NOT NULL,
    [t_applicationId]                   VARCHAR    (32)       NULL,
    [t_jobId]                           VARCHAR    (36)       NULL,
    [t_jobDtm]                          DATETIME,
    [t_jobBy]                           NVARCHAR  (128)       NULL,
    [t_extractionDtm]                   DATETIME,
    [t_filePath]                        NVARCHAR (1024)       NULL,
    CONSTRAINT [PK_FACT_PURCHLINE_Archive] PRIMARY KEY NONCLUSTERED (
       [DW_Id]
    ) NOT ENFORCED

)
WITH
(
	HEAP,  
    DISTRIBUTION = REPLICATE 
);

