CREATE PROCEDURE [tc.dm_finance.vw_fact_ACDOCA_EPMSalesView].[test no empty mapping]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_fact_ACDOCA_EPM_Base') IS NOT NULL DROP TABLE #vw_fact_ACDOCA_EPM_Base;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_ACDOCA_EPM_Base]';
   
  SELECT TOP(0) *
  INTO #vw_fact_ACDOCA_EPM_Base
  FROM edw.vw_fact_ACDOCA_EPM_Base;

  -- #2
  INSERT INTO #vw_fact_ACDOCA_EPM_Base (
    GLAccountID,
    EXQL_GLAccountID,
    FunctionalAreaID,
    EXQL_FunctionalAreaID
  )
  VALUES
    (1, 1, 1, 1),
    (2, NULL, 2, NULL),
    (NULL, 3, NULL, 3),
    (4, 4, 4, NULL),
    (5, NULL, 5, 5),
    (NULL, 6, 6, 6);

  EXEC ('INSERT INTO edw.vw_fact_ACDOCA_EPM_Base SELECT * FROM #vw_fact_ACDOCA_EPM_Base');

  -- Act: 
  SELECT *
  INTO actual
  FROM [dm_finance].[vw_fact_ACDOCA_EPMSalesView];

  -- Assert:
  CREATE TABLE expected (
    GLAccountID INT,
    FunctionalAreaID INT
  );

  INSERT INTO expected(
    GLAccountID,
    FunctionalAreaID
  )
  VALUES
    (1, 1);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
