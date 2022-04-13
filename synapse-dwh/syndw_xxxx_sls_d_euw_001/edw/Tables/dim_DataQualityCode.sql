CREATE TABLE [edw].[dim_DataQualityCode]
(
[DataQualityCodeID]             NVARCHAR(10) NOT NULL
,[System]                       NVARCHAR(10)
,[Area]                         NVARCHAR(20)
,[SubArea]                      NVARCHAR(50)
,[DataQualityCodeShortMessage]  NVARCHAR(100)
,[DataQualityCodeLongMessage]   NVARCHAR(500)
,[t_applicationId]              VARCHAR (32)
,[t_jobId]                      VARCHAR (36)
,[t_jobDtm]                     DATETIME
,[t_lastActionCd]               VARCHAR   (1)
,[t_jobBy]                      NVARCHAR(128)
,CONSTRAINT [PK_dim_DataQualityCode] PRIMARY KEY NONCLUSTERED ([DataQualityCodeID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO