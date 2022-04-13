CREATE TABLE [base_ff].[DataQualityCode]
(
[DataQualityCodeID]				NVARCHAR(10)      NOT NULL
,[System]						NVARCHAR(10)
,[Area]							NVARCHAR(50)
,[SubArea]						NVARCHAR(100)
,[DataQualityCodeShortMessage]  NVARCHAR(100)
,[DataQualityCodeLongMessage]   NVARCHAR(500)
,[t_applicationId]				VARCHAR (32)
,[t_jobId]						VARCHAR (36)
,[t_jobDtm]						DATETIME
,[t_jobBy]        				VARCHAR (128)
,[t_filePath]					NVARCHAR (1024)
,CONSTRAINT [PK_DataQualityCode] PRIMARY KEY NONCLUSTERED ([DataQualityCodeID]) NOT ENFORCED
)
WITH
	(HEAP)
GO