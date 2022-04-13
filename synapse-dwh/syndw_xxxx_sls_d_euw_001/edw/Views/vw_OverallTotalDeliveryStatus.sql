CREATE VIEW [edw].[vw_OverallTotalDeliveryStatus]
AS 
SELECT 
	OverallTotalDeliveryStatusText.[OverallTotalDeliveryStatus]     AS [OverallTotalDeliveryStatusID]
,    OverallTotalDeliveryStatusText.[OverallTotalDeliveryStatusDesc] AS [OverallTotalDeliveryStatus]
,    t_applicationId
FROM 
     [base_s4h_cax].[I_OverallTotalDeliveryStatusT] OverallTotalDeliveryStatusText
WHERE 
     OverallTotalDeliveryStatusText.[Language] = 'E' 
     -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
