CREATE VIEW [edw].[vw_ACDOCA_DummyRecords] 
AS
SELECT 
     CONCAT('(MA)-',[GLAccountID])             AS DummyID
    ,[GLAccountLongName]                       AS DummyName
    ,CONCAT('(MA)-'
            ,[GLAccountID]
            ,'_'
            ,[GLAccountLongName]
    )             COLLATE DATABASE_DEFAULT     AS DummyIDName
FROM edw.vw_GLAccountText




