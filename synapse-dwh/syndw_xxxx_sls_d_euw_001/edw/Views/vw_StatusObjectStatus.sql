CREATE VIEW [edw].[vw_StatusObjectStatus]
AS 
    SELECT 
	    [StatusObject] AS [StatusObjectStatusID] 
    ,   [StatusName] AS [UserStatus]
    ,   [StatusShortName] AS [UserStatusShort]
    ,   stost.[StatusProfile]
    ,   stost.[StatusIsActive]
    ,   stost.[StatusIsInactive]
    ,   stost.[t_applicationId]
    FROM 
        [base_s4h_cax].[I_StatusObjectStatus] stost
    JOIN 
        [base_s4h_cax].[I_StatusCodeText] sct 
        ON 
            stost.[StatusCode] = sct.[StatusCode]
            AND
            stost.[StatusProfile] = sct.[StatusProfile]
    WHERE 
        -- stost.[MANDT] = 200 
        -- AND
        -- sct.[MANDT] = 200 
        -- AND MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
        sct.[Language] = 'E'
