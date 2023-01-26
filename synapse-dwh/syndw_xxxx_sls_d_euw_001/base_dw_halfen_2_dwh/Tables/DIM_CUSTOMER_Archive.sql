CREATE TABLE [base_dw_halfen_2_dwh].[DIM_CUSTOMER_Archive](
    [DW_Id] BIGINT NOT NULL
,   [Company] NVARCHAR(8) NULL
,   [Customerno] NVARCHAR(40) NULL
,   [Customername] NVARCHAR(280) NULL
,   [Customeraddress] NVARCHAR(500) NULL
,   [Customerstreet] NVARCHAR(500) NULL
,   [Customercity] NVARCHAR(280) NULL
,   [Customerzipcode] NVARCHAR(20) NULL
,   [Customercountry] NVARCHAR(20) NULL
,   [Customernoold] NVARCHAR(40) NULL
,   [Customerlineofbusiness] NVARCHAR(10) NULL
,   [Customerno_name] NVARCHAR(500) NULL
,   [Customercurrency] NVARCHAR(3) NULL
,   [Customersalesgroup] NVARCHAR(10) NULL
,   [Customersalesdistrictid] NVARCHAR(20) NULL
,   [Customersales_district_group] NVARCHAR(20) NULL
,   [Customermaindistrict] VARCHAR(20) NULL
,   [Customercompanychainid] NVARCHAR(20) NULL
,   [Customerhalbonuscustomergroup] NVARCHAR(10) NULL
,   [Customerconcern] VARCHAR(20) NULL
,   [Customercustgroup] NVARCHAR(10) NULL
,   [CustomerCustgroup_desc] VARCHAR(50) NULL
,   [Customerdimension] NVARCHAR(10) NULL
,   [Customerdimension2] NVARCHAR(10) NULL
,   [Customerdimension3] NVARCHAR(10) NULL
,   [Customerdimension4] NVARCHAR(10) NULL
,   [Customerdimension5] NVARCHAR(10) NULL
,   [Customerdimension6] NVARCHAR(10) NULL
,   [DW_Id_concern] BIGINT NULL
,   [DW_Id_country_region] BIGINT NULL
,   [DW_Id_line_of_business] BIGINT NULL
,   [Countryname] NVARCHAR(60) NULL
,   [Countrycountry_name] VARCHAR(500) NULL
,   [Lineofbusinessdescription] NVARCHAR(60) NULL
,   [Lineofbusinesslineofbusiness_description] VARCHAR(500) NULL
,   [Concerndescription] NVARCHAR(280) NULL
,   [Concernconcern_name] VARCHAR(500) NULL
,   [DW_Id_Distribution_Company] BIGINT NULL
,   [DW_Id_CustSupp] BIGINT NULL
,   [CustSupp_Description] NVARCHAR(60) NULL
,   [DW_Id_CostCenter] BIGINT NULL
,   [CostCenter_Description] NVARCHAR(60) NULL
,   [Customercostcentercostcenterdescription] NVARCHAR(200) NULL
,   [CustomerPillar] NVARCHAR(10) NULL
,   [DW_Batch] BIGINT NULL
,   [DW_SourceCode] VARCHAR(15) NOT NULL
,   [DW_TimeStamp] [datetime] NOT NULL
,   [t_applicationId] VARCHAR    (32)  NULL
,   [t_jobId]         VARCHAR    (36)  NULL
,   [t_jobDtm]        DATETIME
,   [t_jobBy]         NVARCHAR  (128)  NULL
,   [t_extractionDtm] DATETIME
,   [t_filePath]      NVARCHAR (1024)  NULL
,   CONSTRAINT [PK_DIM_CUSTOMER_Archive] PRIMARY KEY NONCLUSTERED ([DW_Id] ASC) NOT ENFORCED
)
WITH
(
	DISTRIBUTION = HASH ([Customerno]),
	CLUSTERED COLUMNSTORE INDEX
);