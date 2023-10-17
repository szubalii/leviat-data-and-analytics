CREATE TABLE [edw].[dim_Address](
  AddressID NVARCHAR(10) NOT NULL,
  Region NVARCHAR(3),
  CountryID NVARCHAR(3),
  CityName NVARCHAR(40),
  PostalCode NVARCHAR(10),
  StreetName NVARCHAR(60),
  HouseNumber NVARCHAR(10),
  FullAddress NVARCHAR(170),
  [t_applicationId]        VARCHAR(32),
  [t_jobId]                VARCHAR(36),
  [t_jobDtm]               DATETIME,
  [t_lastActionCd]         VARCHAR(1),
  [t_jobBy]                NVARCHAR(128),
  CONSTRAINT [PK_dim_Address] PRIMARY KEY NONCLUSTERED ([AddressID]) NOT ENFORCED
)
WITH (
  DISTRIBUTION = REPLICATE, HEAP
)
