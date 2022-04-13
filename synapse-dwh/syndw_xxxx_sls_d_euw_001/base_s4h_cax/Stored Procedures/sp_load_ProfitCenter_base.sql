CREATE PROC [base_s4h_uat_caa].[sp_load_ProfitCenter_base] 
@t_applicationId [varchar](7),
@t_jobId [varchar](36),
@t_lastDtm [datetime],
@t_lastActionBy [nvarchar](20),
@t_filePath [nvarchar](1024) 
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_ProfitCenter]

	INSERT INTO [base_s4h_uat_caa].[I_ProfitCenter](
	   [ControllingArea]
      ,[ProfitCenter]
      ,[ValidityEndDate]
      ,[ProfitCtrResponsiblePersonName]
      ,[CompanyCode]
      ,[ProfitCtrResponsibleUser]
      ,[ValidityStartDate]
      ,[Department]
      ,[ProfitCenterStandardHierarchy]
      ,[Segment]
      ,[ProfitCenterIsBlocked]
      ,[FormulaPlanningTemplate]
      ,[FormOfAddress]
      ,[AddressName]
      ,[AdditionalName]
      ,[ProfitCenterAddrName3]
      ,[ProfitCenterAddrName4]
      ,[StreetAddressName]
      ,[POBox]
      ,[CityName]
      ,[PostalCode]
      --,[POBoxPostalCode] did not find in source file
      ,[District]
      ,[Country]
      ,[Region]
      ,[TaxJurisdiction]
      ,[Language]
      ,[PhoneNumber1]
      ,[PhoneNumber2]
      ,[TeleboxNumber]
      ,[TelexNumber]
      ,[FaxNumber]
      --,[TeletexNumber] did not find in source file
      ,[DataCommunicationPhoneNumber]
      ,[ProfitCenterPrinterName]
      ,[ProfitCenterCreatedByUser]
      ,[ProfitCenterCreationDate]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_lastDtm]
      ,[t_lastActionBy]
      ,[t_filePath]
	)
	SELECT
	 [ControllingArea]
    ,[ProfitCenter]
    ,CASE [ValidityEndDate]
	     WHEN '00000000' THEN '19000101' 
	     ELSE CONVERT([date], [ValidityEndDate], 112) 
	 END AS [ValidityEndDate]
    ,[ProfitCtrResponsiblePersonName]
    ,[CompanyCode]
    ,[ProfitCtrResponsibleUser]
    ,CASE [ValidityStartDate]
	     WHEN '00000000' THEN '19000101' 
	     ELSE CONVERT([date], [ValidityStartDate], 112) 
	 END AS [ValidityStartDate]
    ,[Department]
    ,[ProfitCenterStandardHierarchy]
    ,[Segment]
    ,[ProfitCenterIsBlocked]
    ,[FormulaPlanningTemplate]
    ,[FormOfAddress]
    ,[AddressName]
    ,[AdditionalName]
    ,[ProfitCenterAddrName3]
    ,[ProfitCenterAddrName4]
    ,[StreetAddressName]
    ,[POBox]
    ,[CityName]
    ,[PostalCode]
    --,[POBoxPostalCode]
    ,[District]
    ,[Country]
    ,[Region]
    ,[TaxJurisdiction]
	,CONVERT([char](1), [Language]) AS [Language]
    ,[PhoneNumber1]
    ,[PhoneNumber2]
    ,[TeleboxNumber]
    ,[TelexNumber]
    ,[FaxNumber]
   -- ,[TeletexNumber]
    ,[DataCommunicationPhoneNumber]
    ,[ProfitCenterPrinterName]
    ,[ProfitCenterCreatedByUser]
    ,CASE [ProfitCenterCreationDate]
	     WHEN '00000000' THEN '19000101' 
	     ELSE CONVERT([date], [ProfitCenterCreationDate], 112) 
	 END AS [ProfitCenterCreationDate]
	,@t_applicationId AS t_applicationId
	,@t_jobId AS t_jobId
	,@t_lastDtm AS t_lastDtm
	,@t_lastActionBy AS t_lastActionBy
	,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_ProfitCenter_staging]
END