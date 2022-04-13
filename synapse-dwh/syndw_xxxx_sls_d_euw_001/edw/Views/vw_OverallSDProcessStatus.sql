CREATE VIEW [edw].[vw_OverallSDProcessStatus]
AS
     SELECT 
	     [OverallSDProcessStatus]     AS [OverallSDProcessStatusID]
     ,    [OverallSDProcessStatusDesc] AS [OverallSDProcessStatus]
     ,    [t_applicationId]
     FROM 
          [base_s4h_cax].[I_OverallSDProcessStatusText] OverallSDProcessStatusText
     WHERE
          OverallSDProcessStatusText.[Language] = 'E'
          -- AND
          -- OverallSDProcessStatusText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
