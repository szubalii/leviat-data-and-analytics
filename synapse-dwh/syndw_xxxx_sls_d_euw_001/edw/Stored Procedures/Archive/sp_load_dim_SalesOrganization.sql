CREATE PROC [edw].[sp_load_dim_SalesOrganization]
     @t_jobId [varchar](36)
    ,@t_jobDtm [datetime]
    ,@t_lastActionCd [varchar](1)
    ,@t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SalesOrganization', 'U') is not null
        TRUNCATE TABLE [edw].[dim_SalesOrganization]

    INSERT INTO [edw].[dim_SalesOrganization]( [SalesOrganizationID]
                                             , [SalesOrganization]
                                             , [SalesOrganizationCurrency]
                                             , [CompanyCode]
                                             , [IntercompanyBillingCustomer]
                                             , [ArgentinaDeliveryDateEvent]
                                             , [t_applicationId]
                                             , [t_jobId]
                                             , [t_jobDtm]
                                             , [t_lastActionCd]
                                             , [t_jobBy])
(
    SELECT SalesOrganization.[SalesOrganization] as [SalesOrganizationID]
         , SalesOrganizationText.[SalesOrganizationName]              as [SalesOrganization]
         , SalesOrganization.[SalesOrganizationCurrency]
         , SalesOrganization.[CompanyCode]
         , SalesOrganization.[IntercompanyBillingCustomer]
         , SalesOrganization.[ArgentinaDeliveryDateEvent]
         , SalesOrganization.t_applicationId
         , @t_jobId                              AS t_jobId
         , @t_jobDtm                             AS t_jobDtm
         , @t_lastActionCd                       AS t_lastActionCd
         , @t_jobBy                              AS t_jobBy
    FROM [base_s4h_uat_caa].[I_SalesOrganization] SalesOrganization
             LEFT JOIN
         [base_s4h_uat_caa].[I_SalesOrganizationText] SalesOrganizationText
         ON
             SalesOrganization.[SalesOrganization] =
             SalesOrganizationText.[SalesOrganization]
         AND
             SalesOrganizationText.[Language] = 'E' 
     where SalesOrganization.MANDT = 200 and SalesOrganizationText.MANDT = 200
     
     UNION

    SELECT SalesOrg.[DATAAREAID]                                    as [SalesOrganizationID]
         , SalesOrg.[NAME]                                          as [SalesOrganization]
         , SalesOrg.[LOCALCURRENCY] collate Latin1_General_100_BIN2 as [SalesOrganizationCurrency]
         , SalesOrg.[CRHCOMPANYID]                                  as [CompanyCode]
         , null                                                     as [IntercompanyBillingCustomer]
         , null                                                     as [ArgentinaDeliveryDateEvent]
         , SalesOrg.[t_applicationId]                               as t_applicationId
         , @t_jobId                                                 AS t_jobId
         , @t_jobDtm                                                AS t_jobDtm
         , @t_lastActionCd                                          AS t_lastActionCd
         , @t_jobBy                                                 AS t_jobBy
    FROM [base_tx_ca_0_hlp_uat].[DATAAREA] SalesOrg
    WHERE SalesOrg.[DATAAREAID] not in (select [SalesOrganization] from [base_s4h_uat_caa].[I_SalesOrganization])
    )
END