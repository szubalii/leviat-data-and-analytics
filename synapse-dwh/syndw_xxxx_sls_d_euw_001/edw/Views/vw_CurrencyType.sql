CREATE VIEW [edw].[vw_CurrencyType] AS 

SELECT 
     [CurrencyTypeID]
    ,[CurrencyType]
    ,[t_applicationId]
    --,[t_jobId]
    --,[t_jobDtm]
    --,[t_jobBy]
FROM 
    [base_ff].[CurrencyType]