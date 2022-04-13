CREATE VIEW [edw].[vw_SalesOffice]
AS
     SELECT 
	     [SalesOffice]     AS [SalesOfficeID]
     ,    [SalesOfficeName] AS [SalesOffice]
     ,    [t_applicationId]
     FROM
          [base_s4h_cax].[I_SalesOfficeText] SalesOfficeText
     WHERE
          SalesOfficeText.[Language] = 'E' 
          -- AND
          -- SalesOfficeText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
