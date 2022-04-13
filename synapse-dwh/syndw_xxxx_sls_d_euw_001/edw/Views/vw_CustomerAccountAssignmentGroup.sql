CREATE VIEW [edw].[vw_CustomerAccountAssignmentGroup]
AS SELECT 
     [CustomerAccountAssignmentGroup] AS [CustomerAccountAssignmentGroupID]
,    [CustomerAccountAssgmtGrpName] AS [CustomerAccountAssignmentGroup]
,    [t_applicationId]
FROM 
     [base_s4h_cax].[I_CustomerAccountAssgmtGroupT] I_CustomerAccountAssgmtGroupT
WHERE 
     I_CustomerAccountAssgmtGroupT.[Language] = 'E' 
     -- AND
     -- I_CustomerAccountAssgmtGroupT.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
