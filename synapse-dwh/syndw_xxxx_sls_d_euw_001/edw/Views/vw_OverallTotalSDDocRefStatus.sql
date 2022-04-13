CREATE VIEW [edw].[vw_OverallTotalSDDocRefStatus]
AS 
SELECT 
     OverallTotalSDDocRefStatusText.[OverallTotalSDDocRefStatus]     AS [OverallTotalSDDocRefStatusID]
,    OverallTotalSDDocRefStatusText.[OverallTotalSDDocRefStatusDesc] AS [OverallTotalSDDocRefStatus]
,    t_applicationId
FROM
     [base_s4h_cax].[I_OverallTotalSDDocRefStatusT] OverallTotalSDDocRefStatusText
WHERE 
     OverallTotalSDDocRefStatusText.[Language] = 'E' 
     -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
