CREATE VIEW [edw].[vw_SDProcessStatus]
	AS SELECT
	    SDProcessStatusText.[SDProcessStatus]      AS [SDProcessStatusID]
        ,SDProcessStatusText.[SDProcessStatusDesc] AS [SDProcessStatus]
        ,SDProcessStatusText.[t_applicationId]
    FROM
        [base_s4h_cax].[I_SDProcessStatusText] SDProcessStatusText
    WHERE
        SDProcessStatusText.[Language] = 'E'
        -- AND SDProcessStatusText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
