CREATE TABLE [base_tx_halfen_2_dwh].[FACT_SALESLINE_Archive] (
    [DW_Id]                                  BIGINT           NOT NULL,
    [DATAAREAID]                             NVARCHAR (4)     NULL,
    [CUSTACCOUNT]                            NVARCHAR (20)    NULL,
    [HPLBusinessRule]                        NVARCHAR (30)    NULL,
    [INVOICEAACOUNT]                         NVARCHAR (20)    NULL,
    [INVENTTRANSID]                          NVARCHAR (24)    NOT NULL,
    [SHIPPINGDATEREQUESTED]                  DATETIME         NULL,
    [ShippingDateRequested_RunningDayNumber] BIGINT           NULL,
    [SHIPPINGDATECONFIRMED]                  DATETIME         NULL,
    [SHIPPINGDATECONFIRMED_tf]               DATETIME         NULL,
    [SALESID]                                NVARCHAR (20)    NOT NULL,
    [CREATEDDATETIME]                        DATETIME         NULL,
    [DELIVERYCOUNTRYREGIONID]                NVARCHAR (10)    NULL,
    [DLVMODE]                                NVARCHAR (10)    NULL,
    [DIMENSION]                              NVARCHAR (10)    NULL,
    [ITEMID]                                 NVARCHAR (20)    NULL,
    [NAME]                                   NVARCHAR (1000)  NULL,
    [SALESTYPE]                              BIGINT           NULL,
    [SALESSTATUS]                            INT              NULL,
    [HPLCOSTPRICE]                           DECIMAL (38, 12) NULL,
    [HPLSALESMARGIN]                         DECIMAL (38, 12) NULL,
    [LINEAMOUNT]                             DECIMAL (38, 12) NULL,
    [LINEAMOUNT_MOD]                         DECIMAL (38, 12) NULL,
    [SALESQTY]                               DECIMAL (38, 12) NULL,
    [REMAINSALESPHYSICAL]                    DECIMAL (38, 12) NULL,
    [REMAINSALESFINANCIAL]                   DECIMAL (38, 12) NULL,
    [OpenQty]                                DECIMAL (38, 12) NULL,
    [OpenQtyWithoutCO]                       DECIMAL (38, 12) NULL,
    [INVENTDIMID]                            NVARCHAR (20)    NULL,
    [INVENTSITEID]                           NVARCHAR (10)    NULL,
    [INVENTLOCATIONID]                       NVARCHAR (10)    NULL,
    [SalesTaker]                             NVARCHAR (20)    NULL,
    [DLVTerm]                                NVARCHAR (10)    NULL,
    [Payment]                                NVARCHAR (10)    NULL,
    [HLFSEGMENTID]                           NVARCHAR (4)     NULL,
    [SALESGROUP]                             NVARCHAR (10)    NULL,
    [CURRENCYCODE]                           NVARCHAR (3)     NULL,
    [adm_CompCurrency]                       NVARCHAR (3)     NULL,
    [CurrentDate]                            DATETIME         NULL,
    [ExchRate_MST_CurrentDate]               DECIMAL (38, 12) NULL,
    [LineAmount_MST_TransDate]               DECIMAL (38, 12) NULL,
    [MarginValue]                            DECIMAL (38, 12) NULL,
    [MarginValuePerOne]                      DECIMAL (38, 12) NULL,
    [PartialDeliveries]                      BIGINT           NULL,
    [PartialDeliveries2]                     BIGINT           NULL,
    [PartialYesNo]                           BIGINT           NULL,
    [PartialYesNo2]                          BIGINT           NULL,
    [adm_Calendar]                           NVARCHAR (10)    NULL,
    [ClosingDate]                            BIGINT           NULL,
    [DateKey_CreatedDate]                    BIGINT           NULL,
    [DeliveryCountryRegion_DW_Id]            BIGINT           NULL,
    [DateKey_ShippingDateRequested]          BIGINT           NULL,
    [DateKey_Shippingdate_Confirmed_tf]      BIGINT           NULL,
    [DateKey_Currentdate]                    BIGINT           NULL,
    [bomlines]                               BIGINT           NULL,
    [ReqItemTable_DW_Id]                     BIGINT           NULL,
    [SalesType_Name]                         NVARCHAR (1999)  NULL,
    [HLFISKITCOMPONENT]                      BIGINT           NULL,
    [LineAmountMSTPerOne]                    DECIMAL (38, 12) NULL,
    [HPLInvoiceCountryRegionId]              NVARCHAR (10)    NULL,
    [InvoiceCountryRegion_DW_Id]             BIGINT           NULL,
    [SameDayDelivery]                        BIGINT           NULL,
    [HALMANUALPRICE]                         BIGINT           NULL,
    [SalesArea_DW_Id]                        BIGINT           NULL,
    [ExchRate_EUR_Createddatetime]           DECIMAL (38, 12) NULL,
    [LineAmount_EUR_Createddatetime]         DECIMAL (38, 12) NULL,
    [LineAmountEURPerOne]                    DECIMAL (38, 12) NULL,
    [Segment_DW_Id]                          BIGINT           NULL,
    [HALORIGINALCOMPANYID]                   NVARCHAR (4)     NULL,
    [HALORIGINALORDERREF]                    NVARCHAR (20)    NULL,
    [HALORIGINALLOTNUMBER]                   NVARCHAR (24)    NULL,
    [HALORIGINALLINENUMBER]                  INT              NULL,
    [HALLINENUMBER]                          INT              NULL,
    [DW_Id_CustomerObject]                   BIGINT           NULL,
    [DW_Id_SalesPerson]                      BIGINT           NULL,
    [Createddatetime_Datekey_SALESTABLE]     BIGINT           NULL,
    [RETURNREASONCODEID]                     NVARCHAR (10)    NULL,
    [RETURNREASONCODEDESC]                   NVARCHAR (60)    NULL,
    [DW_Id_Itemid]                           BIGINT           NULL,
	[OpenOrderId]                            NVARCHAR (20)    NULL,
    [DW_Batch]                               BIGINT           NULL,
    [DW_SourceCode]                          VARCHAR (15)     NOT NULL,
    [DW_TimeStamp]                           DATETIME         NOT NULL,
    [t_applicationId]                        VARCHAR    (32)  NULL,
    [t_jobId]                                VARCHAR    (36)  NULL,
    [t_jobDtm]                               DATETIME,
    [t_jobBy]                                NVARCHAR  (128)  NULL,
    [t_extractionDtm]                        DATETIME,
    [t_filePath]                             NVARCHAR (1024)  NULL,
    CONSTRAINT [PK_FACT_SALESLINE_Archive] PRIMARY KEY NONCLUSTERED ([SALESID], [INVENTTRANSID]) NOT ENFORCED
)
WITH
(
	DISTRIBUTION = HASH ([INVENTTRANSID]),
	CLUSTERED COLUMNSTORE INDEX
);