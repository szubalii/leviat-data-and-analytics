CREATE PROC [edw].[sp_load_dim_ProfitCenter]
     @t_jobId [varchar](36)
    ,@t_jobDtm [datetime]
    ,@t_lastActionCd [varchar](1)
    ,@t_jobBy [nvarchar](128) 
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_ProfitCenter', 'U') is not null TRUNCATE TABLE [edw].[dim_ProfitCenter]

    INSERT INTO [edw].[dim_ProfitCenter](
       [ControllingArea]
      ,[ProfitCenterID]
      ,[ProfitCenter]
      ,[ProfitCenterLongName]
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
      ,[DataCommunicationPhoneNumber]
      ,[ProfitCenterPrinterName]
      ,[ProfitCenterCreatedByUser]
      ,[ProfitCenterCreationDate]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
      ,[t_jobBy]
    )
    SELECT
       ProfitCenter.[ControllingArea]
      ,ProfitCenter.[ProfitCenter] as [ProfitCenterID]
      ,ProfitCenterText.[ProfitCenterName] as [ProfitCenter]
      ,ProfitCenterText.[ProfitCenterLongName]
      ,ProfitCenter.[ValidityEndDate]
      ,[ProfitCtrResponsiblePersonName]
      ,[CompanyCode]
      ,[ProfitCtrResponsibleUser]
      ,ProfitCenter.[ValidityStartDate]
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
      ,[District]
      ,[Country]
      ,[Region]
      ,[TaxJurisdiction]
      ,ProfitCenter.[Language]
      ,[PhoneNumber1]
      ,[PhoneNumber2]
      ,[TeleboxNumber]
      ,[TelexNumber]
      ,[FaxNumber]
      ,[DataCommunicationPhoneNumber]
      ,[ProfitCenterPrinterName]
      ,[ProfitCenterCreatedByUser]
      ,[ProfitCenterCreationDate]
      ,ProfitCenter.[t_applicationId]
      ,@t_jobId AS t_jobId
      ,@t_jobDtm AS t_jobDtm
      ,@t_lastActionCd AS t_lastActionCd
      ,@t_jobBy AS t_jobBy
    FROM 
        [base_s4h_uat_caa].[I_ProfitCenter] ProfitCenter
    LEFT JOIN 
        [base_s4h_uat_caa].[I_ProfitCenterText] ProfitCenterText
        ON 
            ProfitCenter.[ProfitCenter] = ProfitCenterText.[ProfitCenter]
            AND
            ProfitCenterText.[Language] = 'E'
   where ProfitCenter.[MANDT] = 200 and ProfitCenterText.[MANDT] = 200
END