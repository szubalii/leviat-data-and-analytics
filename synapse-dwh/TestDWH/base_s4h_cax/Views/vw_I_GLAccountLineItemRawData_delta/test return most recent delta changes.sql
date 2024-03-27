CREATE PROCEDURE [tc.base_s4h_cax.vw_I_GLAccountLineItemRawData_delta].[test return most recent delta changes]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_GLAccountLineItemRawData_delta]';

  -- #2
  INSERT INTO base_s4h_cax.I_GLAccountLineItemRawData_delta (
    [TS_SEQUENCE_NUMBER],
    [MANDT],
    [SourceLedger],
    [CompanyCode],
    [FiscalYear],
    [AccountingDocument],
    [LedgerGLLineItem],
    [t_extractionDtm]
  )
  VALUES
    (0, 200, 'SL', 'CoCo', '2024', 'AcDocument', 'GLItm1', '2024-01-01'),
    (1, 200, 'SL', 'CoCo', '2024', 'AcDocument', 'GLItm2', '2024-01-01'),
    (2, 200, 'SL', 'CoCo', '2024', 'AcDocument', 'GLItm1', '2024-01-01'),
    (3, 200, 'SL', 'CoCo', '2024', 'AcDocument', 'GLItm2', '2024-01-01'),
    (0, 200, 'SL', 'CoCo', '2024', 'AcDocument', 'GLItm1', '2024-02-01'),
    (1, 200, 'SL', 'CoCo', '2024', 'AcDocument', 'GLItm2', '2024-02-01');

  -- Act: 
  SELECT
    [TS_SEQUENCE_NUMBER],
    [MANDT],
    [SourceLedger],
    [CompanyCode],
    [FiscalYear],
    [AccountingDocument],
    [LedgerGLLineItem],
    [t_extractionDtm]
  INTO actual
  FROM [base_s4h_cax].[vw_I_GLAccountLineItemRawData_delta];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [TS_SEQUENCE_NUMBER],
    [MANDT],
    [SourceLedger],
    [CompanyCode],
    [FiscalYear],
    [AccountingDocument],
    [LedgerGLLineItem],
    [t_extractionDtm]
  )
  VALUES
    (0, 200, 'SL', 'CoCo', '2024', 'AcDocument', 'GLItm1', '2024-02-01'),
    (1, 200, 'SL', 'CoCo', '2024', 'AcDocument', 'GLItm2', '2024-02-01');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
