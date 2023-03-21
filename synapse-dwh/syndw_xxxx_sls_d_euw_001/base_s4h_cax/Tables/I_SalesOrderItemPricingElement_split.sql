CREATE TABLE [base_s4h_cax].[I_SalesOrderItemPricingElement_split](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [SALESORDER] nvarchar(10) NOT NULL
, [SALESORDERITEM] char(6) collate Latin1_General_100_BIN2 NOT NULL
, [PRICINGPROCEDURESTEP] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [PRICINGPROCEDURECOUNTER] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [CONDITIONAPPLICATION] nvarchar(2)
, [CONDITIONTYPE] nvarchar(4)
, [PRICINGDATETIME] nvarchar(14)
, [CONDITIONCALCULATIONTYPE] nvarchar(3)
, [CONDITIONBASEVALUE] decimal(24,9)
, [CONDITIONRATEVALUE] decimal(24,9)
, [CONDITIONCURRENCY] char(5) collate Latin1_General_100_BIN2
, [CONDITIONQUANTITY] decimal(5)
, [CONDITIONQUANTITYUNIT] nvarchar(3) collate Latin1_General_100_BIN2
, [CONDITIONCATEGORY] nvarchar(1)
, [CONDITIONISFORSTATISTICS] nvarchar(1)
, [PRICINGSCALETYPE] nvarchar(1)
, [ISRELEVANTFORACCRUAL] nvarchar(1)
, [CNDNISRELEVANTFORINVOICELIST] nvarchar(1)
, [CONDITIONORIGIN] nvarchar(1)
, [ISGROUPCONDITION] nvarchar(1)
, [CONDITIONRECORD] nvarchar(10)
, [CONDITIONSEQUENTIALNUMBER] char(3) collate Latin1_General_100_BIN2
, [TAXCODE] nvarchar(2)
, [WITHHOLDINGTAXCODE] nvarchar(2)
, [CNDNROUNDINGOFFDIFFAMOUNT] decimal(5,2)
, [CONDITIONAMOUNT] decimal(15,2)
, [TRANSACTIONCURRENCY] char(5) collate Latin1_General_100_BIN2
, [CONDITIONCONTROL] nvarchar(1)
, [CONDITIONINACTIVEREASON] nvarchar(1)
, [CONDITIONCLASS] nvarchar(1)
, [PRCGPROCEDURECOUNTERFORHEADER] char(3) collate Latin1_General_100_BIN2
, [FACTORFORCONDITIONBASISVALUE] float
, [STRUCTURECONDITION] nvarchar(1)
, [PERIODFACTORFORCNDNBASISVALUE] float
, [PRICINGSCALEBASIS] nvarchar(3)
, [CONDITIONSCALEBASISVALUE] decimal(24,9)
, [CONDITIONSCALEBASISUNIT] nvarchar(3) collate Latin1_General_100_BIN2
, [CONDITIONSCALEBASISCURRENCY] char(5) collate Latin1_General_100_BIN2
, [CNDNISRELEVANTFORINTCOBILLING] nvarchar(1)
, [CONDITIONISMANUALLYCHANGED] nvarchar(1)
, [CONDITIONISFORCONFIGURATION] nvarchar(1)
, [VARIANTCONDITION] nvarchar(26)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_SalesOrderItemPricingElement_split] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SalesOrder], [SalesOrderItem], [PricingProcedureStep], [PricingProcedureCounter]
  ) NOT ENFORCED
)
WITH (
  HEAP
)