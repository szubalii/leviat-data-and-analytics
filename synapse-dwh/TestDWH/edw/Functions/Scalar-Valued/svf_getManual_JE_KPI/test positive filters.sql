CREATE PROCEDURE [tc.edw.svf_getManual_JE_KPI].[test positive filters]
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
    ( select 'SA' AS AccountingDocumentTypeID
      UNION ALL SELECT 'JR'
      UNION ALL SELECT 'AB'
    ) a
    CROSS JOIN (
    SELECT 'RFBU' AS BusinessTransactionTypeID
      UNION ALL SELECT 'RFPT'
      UNION ALL SELECT 'RFCL'
      UNION ALL SELECT 'AZUM'
      UNION ALL SELECT 'RFCV'
    ) b
    CROSS JOIN (
    SELECT 'BKPFF' AS ReferenceDocumentTypeID
      UNION ALL SELECT 'BKPF'
    ) c
    CROSS JOIN (
      SELECT 10 AS AmountInCompanyCodeCurrency
    ) d
  ) e

  -- Act:
  SELECT *
  INTO actual
  FROM (
    SELECT
      [edw].[svf_getManual_JE_KPI](
        AccountingDocumentTypeID,
        BusinessTransactionTypeID,
        ReferenceDocumentTypeID,
        AmountInCompanyCodeCurrency
      ) AS Manual_JE_KPI
    FROM #testdata
  ) a
  WHERE
    Manual_JE_KPI <> 10;

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
