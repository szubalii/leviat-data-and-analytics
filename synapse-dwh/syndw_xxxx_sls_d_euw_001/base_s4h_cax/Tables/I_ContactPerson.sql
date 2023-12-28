CREATE TABLE [base_s4h_cax].[I_ContactPerson](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ContactPerson] char(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Customer] nvarchar(10)
, [Supplier] nvarchar(10)
, [ContactPersonFunction] nvarchar(2)
, [ContactPersonDepartment] nvarchar(4)
, [SearchTerm1] nvarchar(10)
, [PersonNumber] nvarchar(10)
, [UpperCaseFirstName] nvarchar(25)
, [UpperCaseLastName] nvarchar(25)
, [FirstName] nvarchar(40)
, [LastName] nvarchar(40)
, [IsBusinessPurposeCompleted] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ContactPerson] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ContactPerson]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
