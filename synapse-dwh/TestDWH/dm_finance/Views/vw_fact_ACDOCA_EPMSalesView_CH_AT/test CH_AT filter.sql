CREATE PROCEDURE [tc.dm_finance.vw_fact_ACDOCA_EPMSalesView_CH_AT].[test CH_AT filter]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_fact_ACDOCA_EPM_Base') IS NOT NULL DROP TABLE #vw_fact_ACDOCA_EPM_Base;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_ACDOCA_EPM_Base]';
   
  SELECT TOP(0) *
  INTO #vw_fact_ACDOCA_EPM_Base
  FROM edw.vw_fact_ACDOCA_EPM_Base;

  -- #2
  INSERT INTO #vw_fact_ACDOCA_EPM_Base (
    CompanyCodeID
  )
  VALUES
    ('CH35'),
    ('AT35'),
    ('DE35');

  EXEC ('INSERT INTO edw.vw_fact_ACDOCA_EPM_Base SELECT * FROM #vw_fact_ACDOCA_EPM_Base');

  -- Act: 
  SELECT CompanyCodeID
  INTO actual
  FROM [dm_finance].[vw_fact_ACDOCA_EPMSalesView_CH_AT]
  WHERE CompanyCodeID NOT IN ('CH35', 'AT35');

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
