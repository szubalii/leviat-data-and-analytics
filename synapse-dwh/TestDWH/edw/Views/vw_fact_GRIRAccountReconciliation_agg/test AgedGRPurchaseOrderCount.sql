CREATE PROCEDURE [tc.edw.vw_fact_GRIRAccountReconciliation_agg].[test AgedGRPurchaseOrderCount]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_GRIRAccountReconciliation]';

  INSERT INTO edw.fact_GRIRAccountReconciliation (
    ReportDate,
    OldestOpenItemPostingDate,
    PurchasingDocument,
    t_extractionDtm
  )
  VALUES
    ('2020-01-01', '2020-01-01', 1, '2020-01-01')
  , ('2020-01-01', '2020-02-01', 2, '2020-01-01')
  , ('2020-01-01', '2019-12-01', 3, '2020-01-01')
  , ('2020-01-01', '2019-11-01', 4, '2020-01-01')
  , ('2020-01-01', '2019-10-01', 5, '2020-01-01')
  , ('2020-01-01', '2019-10-01', 5, '2020-01-01')
  , ('2019-12-01', '2019-09-01', 1, '2019-12-01')
  , ('2019-12-01', '2019-09-01', 2, '2019-12-01');

  -- Collect non-unique records
  SELECT
    *
  INTO actual
  FROM [edw].[vw_fact_GRIRAccountReconciliation_agg]

  -- Assert:
  CREATE TABLE expected (
    CompanyCodeID INT,
    FiscalYear INT,
    FiscalPeriod INT,
    FiscalYearPeriod VARCHAR(8),
    AgedGRPurchaseOrderCount INT
  )

  INSERT INTO expected (
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod,
    AgedGRPurchaseOrderCount
  )
  VALUES
    (NULL, 2020,  1, '2020001', 1)
  , (NULL, 2019, 12, '2019012', 2);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END
