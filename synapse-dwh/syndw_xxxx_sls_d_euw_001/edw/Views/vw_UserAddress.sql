CREATE VIEW [edw].[vw_UserAddress]
AS
	SELECT 
	  [bname] as [UserName]
	, [persnumber] as [UserID]
	, [class] as [UserClass]
	, [t_applicationId]
	, [t_jobId]
	, [t_jobDtm]
	, [t_jobBy]
	, [t_extractionDtm]

	FROM [base_s4h_cax].[P_UserAddress]