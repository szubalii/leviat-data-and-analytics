CREATE PROCEDURE [tc.dm_finance.vw_fact_FinanceKPI].[test no FiscalCalendar duplicates]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_FiscalCalendar]'; 
  EXEC tSQLt.FakeTable '[edw]', '[dim_CompanyCode]';
  
  INSERT INTO edw.dim_FiscalCalendar (
    FiscalYearVariant,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod
  )
  VALUES
    ('DL', '2023', '008', '2023008'),
    ('V6', '2023', '008', '2023008');

  INSERT INTO edw.dim_CompanyCode (
    CompanyCodeID
  )
  VALUES
    ('NZ35');

-- Act: 
  SELECT
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod,
    count(*)  AS cnt
  INTO actual
  FROM [dm_finance].[vw_fact_FinanceKPI]
  GROUP BY
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod
  HAVING COUNT(*)>1;
  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
