CREATE TABLE base_ff.LeviatWarehouse
(
     Region                 VARCHAR(8)  NOT NULL
    ,CountryCode            CHAR(2)     NOT NULL
    ,SAPShippingPoint       VARCHAR(64)
    ,WarehouseName          VARCHAR(32)
    ,Type                   VARCHAR(8)  NOT NULL
    ,SAPCode                VARCHAR(4)
    ,WarehouseType          VARCHAR(20) NOT NULL
    ,Address                VARCHAR(100) NOT NULL
    ,Zipcode                VARCHAR(16)
    ,City                   VARCHAR(32)
    ,LogisticsAreaInM2      DECIMAL(10,2)
    ,FTELogistics           DECIMAL(10,2)
    ,FullAddress            VARCHAR(160)
    ,t_applicationId        VARCHAR(32) 
	,t_jobId                VARCHAR(36) 
	,t_jobDtm               DATETIME
	,t_jobBy                VARCHAR(128)
	,t_filePath             NVARCHAR(1024)
    ,CONSTRAINT [PK_LeviatWarehouse] PRIMARY KEY NONCLUSTERED ([WarehouseName],[WarehouseType]) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = REPLICATE);