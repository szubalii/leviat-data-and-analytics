CREATE TABLE base_ff.LeviatLocations
(
    Region                  VARCHAR(8)  NOT NULL
    ,CountryCode            CHAR(2)     NOT NULL
    ,Country                VARCHAR(32) NOT NULL
    ,ShippingPointNameSAP   VARCHAR(64)
    ,NameOfWHS              VARCHAR(32)
    ,Type                   VARCHAR(8)  NOT NULL
    ,SAPCode                VARCHAR(4)
    ,TypeOfWHS              VARCHAR(20) NOT NULL
    ,Address                VARCHAR(100) NOT NULL
    ,Zipcode                VARCHAR(16) NOT NULL
    ,City                   VARCHAR(32) NOT NULL
    ,LogisticArea           DECIMAL(10,2)
    ,FTELogistics           DECIMAL(10,2)
    ,FullAddress            VARCHAR(160)
    ,t_applicationId        VARCHAR(32) 
	,t_jobId                VARCHAR(36) 
	,t_jobDtm               DATETIME
	,t_jobBy                VARCHAR(128)
	,t_filePath             NVARCHAR(1024)
)
WITH (HEAP, DISTRIBUTION = REPLICATE);