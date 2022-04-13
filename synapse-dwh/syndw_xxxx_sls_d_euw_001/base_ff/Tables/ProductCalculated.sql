CREATE TABLE [base_ff].[ProductCalculated] (
    [ProductIDCalculated]           NVARCHAR(255) NOT NULL
,   [ProductExternalIDCalculated]   NVARCHAR(255)
,   [ProductCalculated]             NVARCHAR(280)
,   [ProductPillarIDCalculated]     NVARCHAR(10)
,   [ProductPillarCalculated]       NVARCHAR(50)
,   [ProductGroupIDCalculated]      NVARCHAR(10)
,   [ProductGroupCalculated]        NVARCHAR(100)
,   [MainGroupIDCalculated]         NVARCHAR(10)
,   [MainGroupCalculated]           NVARCHAR(50)
,   [isReviewed]        TINYINT
,   [mappingType]       NVARCHAR  (10) 
,   [axbiDataAreaID]    NVARCHAR (255)
,   [axbiItemNo]        NVARCHAR (255)
,   [axbiItemName]      NVARCHAR (280)
,   [axbiProductPillarIDCalculated] NVARCHAR(10)
,   [axbiProductPillarCalculated]   NVARCHAR(50)
,   [axbiProductGroupIDCalculated]  NVARCHAR(10)
,   [axbiProductGroupCalculated]    NVARCHAR(100)
,   [axbiMainGroupIDCalculated]     NVARCHAR(10)
,   [axbiMainGroupCalculated]       NVARCHAR(50)
,   [t_applicationId]    VARCHAR   (32)
,   [t_jobId]            VARCHAR   (36)
,   [t_jobDtm]          DATETIME
,   [t_jobBy]            VARCHAR  (128)
,   [t_extractionDtm]   DATETIME
,   [t_filePath]        NVARCHAR (1024)
,   [t_source]          NVARCHAR  (100)
,   CONSTRAINT [PK_ProductCalculated] PRIMARY KEY NONCLUSTERED ([ProductIDCalculated]) NOT ENFORCED
)
WITH (
  HEAP
)
GO