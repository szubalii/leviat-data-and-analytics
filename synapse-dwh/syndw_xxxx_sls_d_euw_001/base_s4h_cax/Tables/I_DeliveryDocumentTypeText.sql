CREATE TABLE [base_s4h_cax].[I_DeliveryDocumentTypeText]
-- Delivery Document Type Text
(
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [DeliveryDocumentType] nvarchar(4) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [DeliveryDocumentTypeName] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_DeliveryDocumentTypeText] PRIMARY KEY NONCLUSTERED([MANDT],[DeliveryDocumentType],[Language]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
