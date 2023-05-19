CREATE VIEW [dm_procurement].[vw_dim_User]
AS
SELECT
    UserID      AS UserId
    ,UserName
    ,''         AS SupervisorId
FROM [edw].[dim_UserAddress]