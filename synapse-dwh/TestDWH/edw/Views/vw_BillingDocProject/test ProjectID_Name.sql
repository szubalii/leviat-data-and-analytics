CREATE PROCEDURE [tc.edw.vw_BillingDocProject].[test ProjectID_Name]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[C_BillingDocumentPartnerFs]';

  INSERT INTO base_s4h_cax.C_BillingDocumentPartnerFs (
    SDDocument,
    PartnerFunction,
    Customer,
    FullName
  )
  VALUES
  (1, 'ZP', 'ProjectID', 'ProjectName');

  -- Act: 
  SELECT
    SDDocument,
    ProjectID_Name
  INTO actual
  FROM [edw].[vw_BillingDocProject];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    SDDocument,
    ProjectID_Name
  )
  VALUES
    (1, 'ProjectID_ProjectName')

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END