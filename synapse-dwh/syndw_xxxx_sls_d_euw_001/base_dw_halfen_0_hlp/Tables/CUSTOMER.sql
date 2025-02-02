﻿CREATE TABLE [base_dw_halfen_0_hlp].[CUSTOMER] (
    [DATAAREAID]            NVARCHAR (8)    NOT NULL,
    [ACCOUNTNUM]            NVARCHAR (40)   NOT NULL,
    [NAME]                  NVARCHAR (280)  NOT NULL,
    [ADDRESS]               NVARCHAR (500)  NOT NULL,
    [STREET]                NVARCHAR (500)  NOT NULL,
    [CITY]                  NVARCHAR (280)  NOT NULL,
    [ZIPCODE]               NVARCHAR (20)   NOT NULL,
    [COUNTRYREGIONID]       NVARCHAR (20)   NOT NULL,
    [AMDALTNUM1]            NVARCHAR (40)   NOT NULL,
    [LINEOFBUSINESS]        NVARCHAR (10)   NULL,
    [SALESGROUP]            NVARCHAR (10)   NULL,
    [SALESDISTRICTID]       NVARCHAR (20)   NULL,
    [CUSTGROUP]             NVARCHAR (10)   NULL,
    [DIMENSION]             NVARCHAR (10)   NULL,
    [DIMENSION2_]           NVARCHAR (10)   NULL,
    [DIMENSION3_]           NVARCHAR (10)   NULL,
    [DIMENSION4_]           NVARCHAR (10)   NULL,
    [DIMENSION5_]           NVARCHAR (10)   NULL,
    [DIMENSION6_]           NVARCHAR (10)   NULL,
    [COMPANYCHAINID]        NVARCHAR (20)   NULL,
    [HALBONUSCUSTOMERGROUP] NVARCHAR (10)   NULL,
    [CURRENCY]              NVARCHAR (3)    NULL,
    [STATISTICSGROUP]       NVARCHAR (10)   NULL,
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);

