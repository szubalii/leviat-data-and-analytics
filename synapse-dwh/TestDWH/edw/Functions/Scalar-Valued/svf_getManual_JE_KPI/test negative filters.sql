CREATE PROCEDURE [tc.edw.svf_getManual_JE_KPI].[test negative filters]
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
      UNION ALL SELECT 'TEST'
    ) a
    CROSS JOIN (
    SELECT 'RFBU' AS BusinessTransactionTypeID
      UNION ALL SELECT 'RFPT'
      UNION ALL SELECT 'RFCL'
      UNION ALL SELECT 'AZUM'
      UNION ALL SELECT 'RFCV'
      UNION ALL SELECT 'TEST'
    ) b
    CROSS JOIN (
    SELECT 'BKPFF' AS ReferenceDocumentTypeID
      UNION ALL SELECT 'BKPF'
      UNION ALL SELECT 'TEST'
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
    WHERE (
      AccountingDocumentTypeID NOT IN ('SA', 'JR', 'AB')
      OR
      BusinessTransactionTypeID NOT IN ('RFBU', 'RFPT', 'RFCL', 'AZUM', 'RFCV')
      OR
      ReferenceDocumentTypeID NOT IN ('BKPFF', 'BKPF')
    )
  ) a
  WHERE
    Manual_JE_KPI IS NOT NULL;

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
