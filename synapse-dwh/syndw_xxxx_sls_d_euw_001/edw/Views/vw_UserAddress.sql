CREATE VIEW [edw].[vw_UserAddress]
AS
	SELECT 
	  [BNAME] as [UserName]
	, [PERSNUMBER] as [UserID]
	, [CLASS] as [UserClass]
	, [t_applicationId]
	, [t_extractionDtm]

	FROM [base_s4h_cax].[P_UserAddress]