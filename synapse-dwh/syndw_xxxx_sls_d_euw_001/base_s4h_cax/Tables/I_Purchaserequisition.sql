CREATE TABLE [base_s4h_cax].[I_Purchaserequisition]
-- Purchase Requisition Header
(
  [MANDT] nchar(3) NOT NULL
, [PurchaseRequisition] nvarchar(10) NOT NULL
, [PurReqnSSPRequestor] nvarchar(60)
, [PurReqnSSPAuthor] nvarchar(12)
, [PurReqnOrigin] nvarchar(1)
, [PurchaseRequisitionType] nvarchar(4)
, [PurReqnIsCreatedInExpertMode] nvarchar(1)
, [IsOnBehalfCart] nvarchar(1)
, [PurReqnRequestor] nvarchar(60)
, [LastChangeDateTime] decimal(21,7)
, [CreationDate] date
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]             DATETIME
, [t_jobBy]        NVARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [PK_I_Purchaserequisition] PRIMARY KEY NONCLUSTERED([MANDT],[PurchaseRequisition]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
