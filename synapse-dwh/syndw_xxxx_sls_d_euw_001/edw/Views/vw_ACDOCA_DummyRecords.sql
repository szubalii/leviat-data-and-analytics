CREATE VIEW [edw].[vw_ACDOCA_DummyRecords_new] 
AS
SELECT 
    distinct CONCAT('(MA)-',[GLAccountID])     AS DummyID
    ,[GLAccountLongName]                       AS DummyName
    ,CONCAT('(MA)-'
            ,[GLAccountID]
            ,'_'
            ,[GLAccountLongName]
    )             COLLATE DATABASE_DEFAULT     AS DummyIDName
FROM edw.vw_GLAccountText




