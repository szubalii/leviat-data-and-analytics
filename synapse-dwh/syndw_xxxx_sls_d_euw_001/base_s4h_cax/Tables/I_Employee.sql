CREATE TABLE [base_s4h_cax].[I_Employee] (
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [PersonnelNumber] CHAR(8) NOT NULL  -- Object ID
  , [EmployeeInternalID] NVARCHAR(10)  -- Business Partner Number
  , [Employee] NVARCHAR(60)  -- Identification Number
  , [ValidityStartDate] DATE  -- Start Date
  , [ValidityEndDate] DATE  -- End Date
  , [FormOfAddress] NVARCHAR(4)  -- Form-of-Address Key
  , [FamilyName] NVARCHAR(40)  -- Last name of business partner (person)
  , [FirstName] NVARCHAR(40)  -- First name of business partner (person)
  , [GivenName] NVARCHAR(40)  -- First name of business partner (person)
  , [MiddleName] NVARCHAR(40)  -- Middle name or second forename of a person
  , [AdditionalFamilyName] NVARCHAR(40)  -- Other Last Name of a Person
  , [AcademicTitle] NVARCHAR(4)  -- Academic Title: Key
  , [FamilyNamePrefix] NVARCHAR(4)  -- Name Prefix (Key)
  , [Initials] NVARCHAR(10)  -- "Middle Initial" or personal initials
  , [FullName] NVARCHAR(80)  -- Full Name
  , [EmployeeFullName] NVARCHAR(80)  -- Full Name
  , [CorrespondenceLanguage] CHAR(1)  -- Business Partner: Correspondence Language
  , [GenderCode] NVARCHAR(1)
  , [BusinessPartnerRole] NVARCHAR(6)  -- BP Role
  , [Person] NVARCHAR(10)  -- Person number
  , [BusinessPartnerUUID] int  -- Business Partner GUID
  , [BusinessUser] NVARCHAR(12)  -- User ID
  , [UserID] NVARCHAR(12)  -- User ID
  , [EmployeeImageURL] NVARCHAR(1000)  -- EMPLOYEE_IMAGE_URL
  , [CreatedByUser] NVARCHAR(12)  -- User who created the object
  , [CreationDate] DATE  -- Date on which the object was created
  , [CreationTime] TIME(6)  -- Time at which the object was created
  , [LastChangedByUser] NVARCHAR(12)  -- Last user to change object
  , [LastChangeDate] DATE  -- Date when object was last changed
  , [LastChangeTime] TIME(6)  -- Time at which object was last changed
  , [AuthorizationGroup] NVARCHAR(4)  -- Authorization Group
  , [IsBusinessPurposeCompleted] NVARCHAR(1)  -- Business Purpose Completed Flag
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_Employee] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [PersonnelNumber]
  ) NOT ENFORCED
) WITH (
  HEAP
)
