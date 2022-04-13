﻿CREATE TABLE [base_dw_halfen_2_dwh].[DIM_DISTRIBUTIONCOMPANY] (
    [DW_Id]                                    BIGINT          IDENTITY (1, 1) NOT NULL,
    [Distribution company]                     NVARCHAR (10)   NULL,
    [Distribution company description]         NCHAR (40)      NULL,
    [Distribution company distcmp_description] VARCHAR (500)   NULL,
    [Sales Area]                               VARCHAR (3)     NULL,
    [DESCRIPTION_2]                            NVARCHAR (100)  NULL,
    [Group1]                                   NVARCHAR (1)    NULL,
    [Group1_Description]                       NVARCHAR (100)  NULL,
    [Group2]                                   NVARCHAR (3)    NULL,
    [Group2_Description]                       NVARCHAR (100)  NULL,
    [Group3]                                   NVARCHAR (3)    NULL,
    [Group3_Description]                       NVARCHAR (100)  NULL,
    [Group4]                                   NVARCHAR (3)    NULL,
    [_CRH_Company]                             NVARCHAR (50)   NULL,
    [_CRH_CountryRegion]                       NVARCHAR (2)    NULL,
    [_CRH_CountryRegion_Name]                  NVARCHAR (50)   NULL,
    [_CRH_Region]                              NVARCHAR (50)   NULL,
    [_CRH_ExQL_Company]                        NVARCHAR (10)   NULL,
    [_CRH_Group1]                              NVARCHAR (1)    NULL,
    [_CRH_Group1_Description]                  NVARCHAR (100)  NULL,
    [_CRH_Group2]                              NVARCHAR (3)    NULL,
    [_CRH_Group2_Description]                  NVARCHAR (100)  NULL,
    [_CRH_Group3]                              NVARCHAR (3)    NULL,
    [_CRH_Group3_Description]                  NVARCHAR (100)  NULL,
    [_CRH_Group4]                              NVARCHAR (3)    NULL,
    [DW_Id_Sales_area]                         BIGINT          NULL,
    [Sales area description]                   NVARCHAR (60)   NULL,
    [Sales area salesarea_description]         VARCHAR (500)   NULL,
    [DW_Batch]                                 BIGINT          NULL,
    [DW_SourceCode]                            VARCHAR (15)    NOT NULL,
    [DW_TimeStamp]                             DATETIME        NOT NULL,
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
    CONSTRAINT [PK_DIM_DISTRIBUTIONCOMPANY] PRIMARY KEY NONCLUSTERED ([DW_Id] ASC) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);

