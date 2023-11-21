
CREATE PROCEDURE [tc.intm_s4h.vw_SalesDocumentEarliestConfirmedDeliveryDate].[test condition]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';

  
  INSERT INTO [base_s4h_cax].[I_SalesDocumentScheduleLine]
  ([SalesDocument],
   [SalesDocumentItem],
   [IsConfirmedDelivSchedLine],
   [ConfirmedDeliveryDate])
  VALUES ('1','1','X','2023-04-02'),('2','2','','2023-04-01');

  -- Act: 
  SELECT    
    [SalesDocument],
    [SalesDocumentItem],
    [ConfirmedDeliveryDate]
  INTO actual
  FROM [intm_s4h].[vw_SalesDocumentEarliestConfirmedDeliveryDate];

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected([SalesDocument],[SalesDocumentItem],[ConfirmedDeliveryDate])
  VALUES('1','1','2023-04-02');
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;