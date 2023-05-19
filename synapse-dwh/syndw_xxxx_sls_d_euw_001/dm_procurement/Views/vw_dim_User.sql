CREATE VIEW [dm_procurement].[vw_dim_User]
AS
SELECT
    UserId
    ,UserName
    ''  AS SupervisorId
FROM [edw].[dimUserAddress]