CREATE PROCEDURE [tc.edw.vw_BillingDocProject].[test PartnerFunction ZP]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[C_BillingDocumentPartnerFs]';

  INSERT INTO base_s4h_cax.C_BillingDocumentPartnerFs (
    SDDocument,
    PartnerFunction
  )
  VALUES
  (1, 'ZP'),
  (2, 'XX');

  -- Act: 
  SELECT
    SDDocument
  INTO actual
  FROM [edw].[vw_BillingDocProject];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    SDDocument
  )
  VALUES
    (1)

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END