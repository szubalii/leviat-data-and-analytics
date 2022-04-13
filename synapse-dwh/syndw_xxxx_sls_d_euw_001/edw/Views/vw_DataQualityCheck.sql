CREATE VIEW [edw].[vw_DataQualityCode]
AS
SELECT
    [DataQualityCodeID]
    ,[System]
    ,[Area]
    ,[SubArea]
    ,[DataQualityCodeShortMessage]
    ,[DataQualityCodeLongMessage]
    ,[t_applicationId]
FROM
    [base_ff].[DataQualityCode]