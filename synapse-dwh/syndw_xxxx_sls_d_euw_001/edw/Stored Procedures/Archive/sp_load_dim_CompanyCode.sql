CREATE PROC [edw].[sp_load_dim_CompanyCode]
     @t_jobId [varchar](36)
    ,@t_jobDtm [datetime]
    ,@t_lastActionCd [varchar](1)
    ,@t_jobBy [nvarchar](128) 
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_CompanyCode', 'U') is not null TRUNCATE TABLE [edw].[dim_CompanyCode]

    INSERT INTO [edw].[dim_CompanyCode](
       [CompanyCodeID]
      ,[CompanyCode]
      ,[CityName]
      ,[Country]
      ,[Currency]
      ,[Language]
      ,[ChartOfAccounts]
      ,[FiscalYearVariant]
      ,[Company]
      ,[CreditControlArea]
      ,[CountryChartOfAccounts]
      ,[FinancialManagementArea]
      ,[AddressID]
      ,[TaxableEntity]
      ,[VATRegistration]
      ,[ExtendedWhldgTaxIsActive]
      ,[ControllingArea]
      ,[FieldStatusVariant]
      ,[NonTaxableTransactionTaxCode]
      ,[DocDateIsUsedForTaxDetn]
      ,[TaxRptgDateIsActive]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
      ,[t_jobBy]
    )
    SELECT
       [CompanyCode] as [CompanyCodeID]
      ,[CompanyCodeName] as [CompanyCode]
      ,[CityName]
      ,[Country]
      ,[Currency]
      ,[Language]
      ,[ChartOfAccounts]
      ,[FiscalYearVariant]
      ,[Company]
      ,[CreditControlArea]
      ,[CountryChartOfAccounts]
      ,[FinancialManagementArea]
      ,[AddressID]
      ,[TaxableEntity]
      ,[VATRegistration]
      ,[ExtendedWhldgTaxIsActive]
      ,[ControllingArea]
      ,[FieldStatusVariant]
      ,[NonTaxableTransactionTaxCode]
      ,[DocDateIsUsedForTaxDetn]
      ,[TaxRptgDateIsActive]
      ,[t_applicationId]
      ,@t_jobId AS t_jobId
      ,@t_jobDtm AS t_jobDtm
      ,@t_lastActionCd AS t_lastActionCd
      ,@t_jobBy AS t_jobBy
    FROM 
        [base_s4h_uat_caa].[I_CompanyCode]
        
END