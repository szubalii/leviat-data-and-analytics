CREATE PROCEDURE [tc.edw.vw_fact_ScheduleLineShippedNotBilled_agg].[test OpenInvoicedValue]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ScheduleLineShippedNotBilled]';

  INSERT INTO edw.fact_ScheduleLineShippedNotBilled (
    CompanyCodeID,
    ReportDate,
    SDI_ODB_LatestActualGoodsMovmtDate,
    OpenInvoicedValue
  )
  VALUES
    ('TST1', '2020-01-01', '2020-01-01', 100)
  , ('TST1', '2020-01-01', '2020-02-01', 200)
  , ('TST1', '2020-01-01', '2019-12-01', 300)
  , ('TST1', '2020-01-01', '2019-11-01', 400)
  , ('TST1', '2020-01-01', '2019-10-01', 500)
  , ('TST1', '2020-01-01', '2019-10-01', 500)
  , ('TST1', '2019-12-01', '2019-09-01', 100);

  -- Collect non-unique records
  SELECT
    *
  INTO actual
  FROM [edw].[vw_fact_ScheduleLineShippedNotBilled_agg]

  -- Assert:
  CREATE TABLE expected (
    CompanyCodeID VARCHAR(8),
    FiscalYear INT,
    FiscalPeriod INT,
    FiscalYearPeriod VARCHAR(8),
    SOShippedNotBilledAmount INT
  )

  INSERT INTO expected (
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod,
    SOShippedNotBilledAmount
  )
  VALUES
    ('TST1', 2019, 12, '2019012',  100),
    ('TST1', 2020,  1, '2020001', 1000);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END
