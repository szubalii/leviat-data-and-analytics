CREATE PROC [base_s4h_uat_caa].[sp_load_BillingDocumentPartnerFs_base]
	@t_applicationId [varchar](7),
	@t_jobId [varchar](36),
	@t_lastDtm [datetime],
	@t_lastActionBy [nvarchar](20),
	@t_filePath [nvarchar](1024)
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[C_BillingDocumentPartnerFs]

	INSERT INTO [base_s4h_uat_caa].[C_BillingDocumentPartnerFs](
		[SDDocument]
		,[PartnerFunction]
		,[PartnerFunctionName]
		,[AddressID]
		,[Customer]
		,[Personnel]
		,[FullName]
		,[CityName]
		,[StreetName]
		,[PostalCode]
		,[EmailAddress]
		,[PhoneNumber]
		,[MobilePhoneNumber]
		,[t_applicationId]
		,[t_jobId]
		,[t_lastDtm]
		,[t_lastActionBy]
		,[t_filePath]
	)
	SELECT 	
		[SDDocument]
		,[PartnerFunction]
		,[PartnerFunctionName]
		,[AddressID]
		,[Customer]
		,CONVERT([char](8), [Personnel]) AS [Personnel]
		,[FullName]
		,[CityName]
		,[StreetName]
		,[PostalCode]
		,[EmailAddress]
		,[PhoneNumber]
		,[MobilePhoneNumber]		
		,@t_applicationId AS t_applicationId
		,@t_jobId AS t_jobId
		,@t_lastDtm AS t_lastDtm
		,@t_lastActionBy AS t_lastActionBy
		,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[C_BillingDocumentPartnerFs_staging]
END
