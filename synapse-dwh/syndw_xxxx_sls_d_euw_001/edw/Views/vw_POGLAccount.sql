CREATE VIEW [edw].[vw_POGLAccount]
AS
SELECT
    RIGHT(
        CONCAT(
            '0000000000'
            ,[GLAccountID]
        )
        ,10
    )                               AS [GLAccountID]
    ,[GLAccountDescription] 
FROM base_ff.POAccount