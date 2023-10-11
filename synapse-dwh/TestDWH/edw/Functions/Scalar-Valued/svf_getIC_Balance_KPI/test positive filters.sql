CREATE PROCEDURE [tc.edw.svf_getIC_Balance_KPI].[test positive filters]
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
    ( SELECT GLAccountID 
      FROM base_ff.IC_ReconciliationGLAccounts
    ) a
    CROSS JOIN (
        SELECT 'DE35' AS PartnerCompanyID
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
  ) a
  WHERE
    IC_Balance_KPI <> 10;

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;