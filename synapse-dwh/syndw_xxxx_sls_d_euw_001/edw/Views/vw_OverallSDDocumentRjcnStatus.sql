CREATE VIEW [edw].[vw_OverallSDDocumentRjcnStatus]
AS 
     SELECT 
	     [OverallSDDocumentRejectionSts]  AS [OverallSDDocumentRjcnStatusID]
     ,    [OvrlSDDocumentRejectionStsDesc] AS [OverallSDDocumentRjcnStatus]
     ,    t_applicationId
     FROM 
          [base_s4h_cax].[I_OverallSDDocumentRjcnStatusT]
     WHERE      
          [Language] = 'E' 
          -- AND
          -- [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
