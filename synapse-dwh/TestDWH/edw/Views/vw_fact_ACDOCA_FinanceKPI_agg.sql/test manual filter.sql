CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_FinanceKPI_agg].[test manual filter]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
    
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_ACDOCA_EPM_Base]';

  SELECT TOP(0) *
  INTO #vw_fact_ACDOCA_EPM_Base
  FROM edw.vw_fact_ACDOCA_EPM_Base;

  INSERT INTO #vw_fact_ACDOCA_EPM_Base (
    [CompanyCodeID],
    [FiscalYear],
    [FiscalPeriod],
    [FiscalYearPeriod],
    [AccountingDocument],
    [LedgerGLLineItem],
    [Manual_JE_KPI],
    [Inventory_Adj_KPI],
    [IC_Balance_KPI]
  )
  VALUES
    ('DE1', 2023, 9, 202309, 'AD1', 'GL1', 10, 10, 20),
    ('DE1', 2023, 8, 202308, 'AD2', 'GL1', 20, 20, 30),
    ('CH1', 2023, 9, 202309, 'AD3', 'GL1', 10, 10, 20),
    ('CH1', 2023, 8, 202308, 'AD4', 'GL1', 20, 20, 30),
    ('DE1', 2023, 9, 202309, 'AD5', 'GL1', NULL, 1, 25),
    ('DE1', 2023, 8, 202308, 'AD6', 'GL1', NULL, NULL, 35),
    ('CH1', 2023, 9, 202309, 'AD7', 'GL1', 2, NULL, 25),
    ('CH1', 2023, 8, 202308, 'AD8', 'GL1', 1, 2, 35);

  EXEC ('INSERT INTO edw.vw_fact_ACDOCA_EPM_Base SELECT * FROM #vw_fact_ACDOCA_EPM_Base');

-- Act: 
  SELECT
    [CompanyCodeID],
    [FiscalYear],
    [FiscalPeriod],
    [FiscalYearPeriod],
    [ManualJournalEntriesCount],
    [ManualInventoryAdjustmentsCount],
    [IC_Balance_KPI]
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_FinanceKPI_agg]

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    [CompanyCodeID],
    [FiscalYear],
    [FiscalPeriod],
    [FiscalYearPeriod],
    [ManualJournalEntriesCount],
    [ManualInventoryAdjustmentsCount],
    [IC_Balance_KPI]
  )
  VALUES
    ('DE1', 2023, 9, 202309, 1, 2, 45),
    ('DE1', 2023, 8, 202308, 1, 1, 65),
    ('CH1', 2023, 9, 202309, 2, 1, 45),
    ('CH1', 2023, 8, 202308, 2, 2, 65);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
