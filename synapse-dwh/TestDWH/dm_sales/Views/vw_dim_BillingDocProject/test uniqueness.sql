CREATE PROCEDURE [tc.dm_sales.vw_dim_BillingDocProject].[test uniqueness]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_BillingDocProject]';

  INSERT INTO edw.dim_BillingDocProject (
    SDDocument,
    ProjectID
  )
  VALUES
  (1, 'ProjID_A'),
  (2, 'ProjID_A'),
  (3, 'ProjID_B');

  -- Act: 
  SELECT
    ProjectID
  INTO actual
  FROM [dm_sales].[vw_dim_BillingDocProject];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    ProjectID
  )
  VALUES
    ('ProjID_A'),
    ('ProjID_B');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
  
END