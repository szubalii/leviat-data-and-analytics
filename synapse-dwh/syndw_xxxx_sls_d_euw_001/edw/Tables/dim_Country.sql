CREATE TABLE [edw].[dim_Country]
(
    [CountryID]                 nvarchar(3) NOT NULL,
    [Country]                   nvarchar(50),
    [CountryThreeLetterISOCode] nvarchar(3),
    [CountryThreeDigitISOCode]  char(3),
    [CountryCurrency]           char(5),
    [IndexBasedCurrency]        char(5),
    [HardCurrency]              char(5),
    [TaxCalculationProcedure]   nvarchar(6),
    [CountryAlternativeCode]    nvarchar(3),
    [NationalityName]           nvarchar(15),
    [NationalityLongName]       nvarchar(50),
    [t_applicationId]           VARCHAR(32),
    [t_jobId]                   VARCHAR(36),
    [t_jobDtm]                  DATETIME,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_Country] PRIMARY KEY NONCLUSTERED ([CountryID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO
