CREATE VIEW [edw].[vw_MaterialGroup]
	AS SELECT 
		   MaterialGroup.[MaterialGroup]         AS [MaterialGroupID]
         , MaterialGroupText.[MaterialGroupName] AS [MaterialGroup]
         , MaterialGroup.[MaterialAuthorizationGroup]
         , MaterialGroupText.[MaterialGroupText]
         , MaterialGroup.t_applicationId
    FROM [base_s4h_cax].[I_MaterialGroup] MaterialGroup
             LEFT JOIN
         [base_s4h_cax].[I_MaterialGroupText] MaterialGroupText
         ON
                MaterialGroup.[MaterialGroup] =
                MaterialGroupText.[MaterialGroup]
             AND
                MaterialGroupText.[Language] = 'E'
   --  WHERE MaterialGroup.[MANDT] = 200 AND MaterialGroupText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
