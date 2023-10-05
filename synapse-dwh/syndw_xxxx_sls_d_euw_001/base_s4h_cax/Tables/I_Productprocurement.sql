CREATE TABLE [base_s4h_cax].[I_Productprocurement](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Product] nvarchar(40) NOT NULL
, [PurchaseOrderQuantityUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [VarblPurOrdUnitStatus] nvarchar(1)
, [PurchasingAcknProfile] nvarchar(4)
, [ProcurementRule] nvarchar(1)
, [SourceOfSupplyCategory] nvarchar(1)
, [PurchasingGroup] nvarchar(3)
, [IsActiveEntity] nvarchar(1)
, [AuthorizationGroup] nvarchar(4)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_Productprocurement] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Product]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
