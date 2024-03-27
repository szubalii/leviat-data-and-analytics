CREATE PROCEDURE [tc.dm_sales.vw_dim_BillingDocProject].[test uniqueness]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_BillingDocProject]';

  INSERT INTO edw.dim_BillingDocProject (
    SDDocument,
    ProjectID,
    Project,
    ProjectID_Name
  )
  VALUES
  (1, 'ProjID_A', 'Project1', 'ProjID_A_Project1'),
  (2, 'ProjID_A', 'Project2', 'ProjID_A_Project2'),
  (3, 'ProjID_B', 'Project3', 'ProjID_B_Project3');


  -- Assert:
  SELECT
    ProjectID
  INTO actual
  FROM [dm_sales].[vw_dim_BillingDocProject]
  GROUP BY
    ProjectID
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';

END;