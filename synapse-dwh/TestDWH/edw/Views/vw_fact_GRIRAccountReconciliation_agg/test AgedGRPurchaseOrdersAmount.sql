CREATE PROCEDURE [tc.edw.vw_fact_GRIRAccountReconciliation_agg].[test AgedGRPurchaseOrdersAmount]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_GRIRAccountReconciliation]';

  INSERT INTO edw.fact_GRIRAccountReconciliation (
    ReportDate,
    OldestOpenItemPostingDate,
    BalAmtInCompanyCodeCrcy
  )
  VALUES
    ('2020-01-01', '2020-01-01', 100)
  , ('2020-01-01', '2020-02-01', 200)
  , ('2020-01-01', '2019-12-01', 300)
  , ('2020-01-01', '2019-11-01', 400)
  , ('2020-01-01', '2019-10-01', 500)
  , ('2020-01-01', '2019-10-01', 500)
  , ('2019-12-01', '2019-09-01', 100)
  , ('2019-12-01', '2019-09-01', 200);

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
    AgedGRPurchaseOrdersAmount INT
  )

  INSERT INTO expected (
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod,
    AgedGRPurchaseOrdersAmount
  )
  VALUES
    (NULL, 2019, 12, '2019012',  300)
  , (NULL, 2020,  1, '2020001', 1000);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END
