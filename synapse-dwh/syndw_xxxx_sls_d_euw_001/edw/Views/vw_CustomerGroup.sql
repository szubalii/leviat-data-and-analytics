CREATE VIEW [edw].[vw_CustomerGroup]
AS
SELECT 
     [CustomerGroup]     AS [CustomerGroupID]
,    [CustomerGroupName] AS [CustomerGroup]
,    [t_applicationId]
FROM 
     [base_s4h_cax].[I_CustomerGroupText] CustomerGroupText
WHERE 
     CustomerGroupText.[Language] = 'E' 
     -- AND
     -- CustomerGroupText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod

UNION ALL

SELECT
     'ZZ'           AS [CustomerGroupID]
,    'Other'        AS [CustomerGroup]
,    'synapse-dwh'  AS [t_applicationId]

