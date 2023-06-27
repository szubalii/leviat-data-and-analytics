CREATE VIEW [dm_sales].[vw_dim_BillingDocProject]
  AS SELECT 
      [Customer]          AS ProjectID
      ,MAX([FullName])    AS Project
      ,[Customer] + '_' + MAX([FullName]) AS ProjectID_Name
      ,[t_applicationId]
      ,[t_extractionDtm]
  FROM [edw].[dim_BillingDocumentPartnerFs]
  WHERE [PartnerFunction] = 'ZP'
  GROUP BY  
      [Customer]
      ,[t_applicationId]
      ,[t_extractionDtm]
