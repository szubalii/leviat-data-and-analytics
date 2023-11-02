
CREATE PROCEDURE [tc.intm_s4h.vw_SalesDocumentFirstScheduleLine].[test condition]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';

  
  INSERT INTO [base_s4h_cax].[I_SalesDocumentScheduleLine] ([SalesDocument],[SalesDocumentItem],[IsConfirmedDelivSchedLine])
  VALUES ('1','1','X'),('2','2','');

  -- Act: 
  SELECT    
    [SalesDocument],
    [SalesDocumentItem]
  INTO actual
  FROM [intm_s4h].[vw_SalesDocumentFirstScheduleLine];

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected([SalesDocument],[SalesDocumentItem])
  VALUES('1','1');
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;