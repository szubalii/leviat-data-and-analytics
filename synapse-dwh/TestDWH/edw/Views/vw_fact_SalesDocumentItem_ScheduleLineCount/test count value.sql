CREATE PROCEDURE [tc.edw.vw_fact_SalesDocumentItem_ScheduleLineCount].[test count value]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

  INSERT INTO [base_s4h_cax].[I_SalesDocumentScheduleLine](
    [SalesDocument],
    [SalesDocumentItem],
    [ScheduleLine],
    [IsConfirmedDelivSchedLine])
  VALUES('1','1','001','X')('1','1','001','');

  INSERT INTO [edw].[fact_SalesDocumentItem] (
    [SalesDocument],
    [SalesDocumentItem],
    [OrderQuantity],
    [CostAmount],
    [NetAmount],
    [CurrencyTypeID],
    [t_applicationId])
  VALUES ('1','1',200.00,8114.000000,2056.000000,'30','s4h-cad'),
  ('2','2',200.00,8114.000000,2056.000000,'30','axbi'),
  ('1','1',12.000,382.580000,1099.440000,'10','s4h-cad'),
  ('4','4',12.000,382.580000,1099.440000,'10','axbi');

  -- Act: 
  SELECT
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[NrSLInScope]
  INTO actual
  FROM [edw].[vw_fact_SalesDocumentItem_ScheduleLineCount];

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[NrSLInScope])
  VALUES
    ('1','1',2);

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;