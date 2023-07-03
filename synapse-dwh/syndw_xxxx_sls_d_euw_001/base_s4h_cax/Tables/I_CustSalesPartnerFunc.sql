CREATE TABLE [base_s4h_cax].[I_CustSalesPartnerFunc]
(    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [CUSTOMER] NVARCHAR(10) NOT NULL  -- Customer Number
  , [SalesOrganization] NVARCHAR(4) NOT NULL  -- Sales Organization
  , [DistributionChannel] NVARCHAR(2) NOT NULL  -- Distribution Channel
  , [Division] NVARCHAR(2) NOT NULL  -- Division
  , [PartnerCounter] CHAR(3) NOT NULL  -- Partner counter
  , [PartnerFunction] NVARCHAR(2) NOT NULL  -- Partner Function
  , [BPCustomerNumber] NVARCHAR(10)  -- Customer number of business partner
  , [CustomerPartnerDescription] NVARCHAR(30)  -- Customer description of partner (plant, storage location)
  , [DefaultPartner] NVARCHAR(1)  -- Default Partner
  , [Supplier] NVARCHAR(10)  -- Account Number of Vendor or Creditor
  , [PersonnelNumber] CHAR(8)  -- Personnel Number
  , [ContactPerson] CHAR(10)  -- Number of contact person
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_CustSalesPartnerFunc] PRIMARY KEY NONCLUSTERED
  (      
      [MANDT]
    , [CUSTOMER]
    , [SalesOrganization]
    , [DistributionChannel]
    , [Division]
    , [PartnerCounter]
    , [PartnerFunction]
  ) NOT ENFORCED
) WITH (
  HEAP
)
