CREATE VIEW [edw].[vw_PackingStatus]
AS
    SELECT PST.[PackingStatus] as [PackingStatusID],
           PST.[PackingStatusDesc],
           PST.[t_applicationId]
    FROM [base_s4h_cax].[I_PackingStatusText] PST
    WHERE PST.[Language] = 'E'