CREATE PROCEDURE [tc.dm_finance.vw_fact_ACDOCA_EPMSalesView_CH_AT].[test date filter]
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
    PostingDate
  )
  VALUES
    ('2023-01-01'),
    ('2022-01-01');

  EXEC ('INSERT INTO edw.vw_fact_ACDOCA_EPM_Base SELECT * FROM #vw_fact_ACDOCA_EPM_Base');

  -- Act: 
  SELECT PostingDate
  INTO actual
  FROM [dm_finance].[vw_fact_ACDOCA_EPMSalesView_CH_AT]
  WHERE PostingDate < '2023-01-01';

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
