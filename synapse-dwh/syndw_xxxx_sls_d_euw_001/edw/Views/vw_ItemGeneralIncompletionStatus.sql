CREATE VIEW [edw].[vw_ItemGeneralIncompletionStatus]
	AS SELECT 
		   ItemGeneralIncompletionStatusText.[ItemGeneralIncompletionStatus] AS [ItemGeneralIncompletionStatusID]
         , ItemGeneralIncompletionStatusText.[ItemGenIncompletionStatusDesc] AS [ItemGeneralIncompletionStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_ItemGenIncompletionStatusT] ItemGeneralIncompletionStatusText
    WHERE ItemGeneralIncompletionStatusText.[Language] = 'E'
      -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
