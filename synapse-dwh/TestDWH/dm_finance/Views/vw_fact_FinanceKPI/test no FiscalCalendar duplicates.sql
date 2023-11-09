CREATE PROCEDURE [tc.dm_finance.vw_fact_FinanceKPI].[test no FiscalCalendar duplicates]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    
  -- Assemble: Fake Table
  IF OBJECT_ID('tempdb..#dim_FiscalCalendar')                   IS NOT NULL DROP TABLE #dim_FiscalCalendar;
  IF OBJECT_ID('tempdb..#dim_CompanyCode')                      IS NOT NULL DROP TABLE #dim_CompanyCode;
  
  EXEC tSQLt.FakeTable '[edw]', '[dim_FiscalCalendar]'; 
  EXEC tSQLt.FakeTable '[edw]', '[dim_CompanyCode]';
  
  SELECT TOP(0) *
  INTO #dim_FiscalCalendar
  FROM edw.dim_FiscalCalendar;

  INSERT INTO #dim_FiscalCalendar (
    FiscalYearVariant,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod
  )
  VALUES
    ('DL', '2023', '008', '2023008'),
    ('V6', '2023', '008', '2023008');

  INSERT INTO edw.dim_FiscalCalendar SELECT * FROM #dim_FiscalCalendar;

  SELECT TOP(0) *
  INTO #dim_CompanyCode
  FROM edw.dim_CompanyCode;

  INSERT INTO #dim_CompanyCode (
    CompanyCodeID
  )
  VALUES
    ('NZ35');

  INSERT INTO edw.dim_CompanyCode SELECT * FROM #dim_CompanyCode;

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
