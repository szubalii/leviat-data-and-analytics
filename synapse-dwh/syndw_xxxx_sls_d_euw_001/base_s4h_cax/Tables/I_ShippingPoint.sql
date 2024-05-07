CREATE TABLE [base_s4h_cax].[I_ShippingPoint](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ShippingPoint] nvarchar(4) NOT NULL
, [ActiveDepartureCountry] nvarchar(3)
, [AddressID] nvarchar(10)
, [PickingConfirmation] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ShippingPoint] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ShippingPoint]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
