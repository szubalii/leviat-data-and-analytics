CREATE TABLE base_ff.CountryRegion (

	[CountryID]                    NVARCHAR(3),
    [CountryName]                  NVARCHAR(50),
    [RegionID]                     NVARCHAR(10),
    [RegionName]                   NVARCHAR(80),
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL

)
WITH (HEAP, DISTRIBUTION = REPLICATE);