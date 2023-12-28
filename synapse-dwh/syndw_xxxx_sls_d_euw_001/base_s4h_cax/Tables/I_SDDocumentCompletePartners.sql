CREATE TABLE [base_s4h_cax].[I_SDDocumentCompletePartners]( -- SD Document Complete Partners 
  [MANDT]					NCHAR(3) NOT NULL --	collate Latin1_General_100_BIN2	NOT NULL
, [SDDocument]				NVARCHAR(10) NOT NULL --	collate Latin1_General_100_BIN2	NOT NULL
, [SDDocumentItem]			CHAR(6) NOT NULL --	collate Latin1_General_100_BIN2	NOT NULL
, [PartnerFunction]			NVARCHAR(2) NOT NULL --	collate Latin1_General_100_BIN2	NOT NULL
, [Customer]				NVARCHAR(10) -- collate Latin1_General_100_BIN2
, [Supplier]				NVARCHAR(10) -- collate Latin1_General_100_BIN2
, [Personnel]				CHAR(8) -- collate Latin1_General_100_BIN2
, [AddressID]				NVARCHAR(10) -- collate Latin1_General_100_BIN2
, [ContactPerson]			CHAR(10) -- collate Latin1_General_100_BIN2
, [PartnerIsOneTimeAccount]	NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [t_applicationId]         VARCHAR (32)
, [t_jobId]                 VARCHAR (36)
, [t_jobDtm]                DATETIME
, [t_jobBy]        	        NVARCHAR (128)
, [t_extractionDtm]	        DATETIME
, [t_filePath]              NVARCHAR (1024)
, CONSTRAINT [PK_I_SDDocumentCompletePartners] PRIMARY KEY NONCLUSTERED (
    [MANDT],[SDDocument],[SDDocumentItem],[PartnerFunction]
  ) NOT ENFORCED
)
WITH (
  HEAP
)