CREATE VIEW [edw].[vw_OverallSDDocReferenceStatus]
AS 
     SELECT 
		[OverallSDDocReferenceStatus] AS [OverallSDDocReferenceStatusID]
     ,    [OverallSDDocRefStatusDesc]   AS [OverallSDDocReferenceStatus]
     ,    t_applicationId
     FROM 
          [base_s4h_cax].[I_OverallSDDocReferenceStatusT] 
     WHERE 
          [Language] = 'E' 
          -- AND
          -- [MANDT] = 200  MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
