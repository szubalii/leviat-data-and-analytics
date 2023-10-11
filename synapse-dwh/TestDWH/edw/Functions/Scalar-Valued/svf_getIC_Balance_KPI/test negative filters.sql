CREATE PROCEDURE [tc.edw.svf_getIC_Balance_KPI].[test negative filters]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#testdata') IS NOT NULL DROP TABLE #testdata;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

   -- Assemble: Fake Table
  SELECT *
  INTO #testdata
  FROM (
      SELECT *
    FROM
    ( SELECT  GLAccountID FROM base_ff.IC_ReconciliationGLAccounts
      UNION ALL SELECT '1111111111'
      UNION ALL SELECT NULL
    ) a
    CROSS JOIN (
        SELECT 'DE35' AS PartnerCompanyID
        UNION ALL SELECT ''
        UNION ALL SELECT NULL
    ) b
    CROSS JOIN (
      SELECT 10 AS AmountInCompanyCodeCurrency
    ) c
  ) d

   -- Act:
  SELECT *
  INTO actual
  FROM (
    SELECT
      [edw].[svf_getIC_Balance_KPI](
        GLAccountID,
        PartnerCompanyID,
        AmountInCompanyCodeCurrency
      ) AS IC_Balance_KPI
    FROM #testdata
    WHERE (
        GLAccountID NOT IN (SELECT GLAccountID FROM base_ff.IC_ReconciliationGLAccounts)
        OR
        PartnerCompanyID = ''
    )
  ) a
  WHERE
    IC_Balance_KPI IS NOT NULL;

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;