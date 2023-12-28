CREATE TABLE [base_s4h_cax].[I_DeliveryDocumentType]
-- Delivery Document Type
(
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [DeliveryDocumentType] nvarchar(4) NOT NULL
, [SDDocumentCategory] nvarchar(4)
, [PrecedingDocumentRequirement] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_DeliveryDocumentType] PRIMARY KEY NONCLUSTERED([MANDT],[DeliveryDocumentType]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
