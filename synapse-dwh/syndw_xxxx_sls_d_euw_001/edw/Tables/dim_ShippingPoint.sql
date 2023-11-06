CREATE TABLE [edw].[dim_ShippingPoint] (
  [ShippingPointID]           NVARCHAR(4) NOT NULL
  ,[ShippingPoint]        NVARCHAR(30)
  ,[ActiveDepartureCountry]   NVARCHAR(3)
  ,[AddressID]                NVARCHAR(10)
  ,[PickingConfirmation]      NVARCHAR(1)
  ,[ShippingPointType]        NVARCHAR(13)
  ,[t_applicationId]          VARCHAR(32)
  ,[t_jobId]                  VARCHAR(36)
  ,[t_jobDtm]                 DATETIME
  ,[t_lastActionCd]           VARCHAR(1)
  ,[t_jobBy]                  NVARCHAR(128)
  ,CONSTRAINT [PK_dim_ShippingPoint] PRIMARY KEY NONCLUSTERED ([ShippingPointID]) NOT ENFORCED
)
WITH
  (DISTRIBUTION = REPLICATE, HEAP )
