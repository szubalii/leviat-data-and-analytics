CREATE PROCEDURE [tc.intm_s4h.vw_SalesDocumentEarliestConfirmedDeliveryDate].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';

  INSERT INTO [base_s4h_cax].[I_SalesDocumentScheduleLine](
    [SalesDocument],
    [SalesDocumentItem],
    [ScheduleLine],
    [ConfirmedDeliveryDate],
    [GoodsIssueDate],
    [IsConfirmedDelivSchedLine]
  )
  VALUES
  ('1', '1','0001','2023-02-07','2023-01-01',''),
  ('1', '1','0002','2023-02-08','2023-05-15','X'),
  ('1', '1','0003','2023-02-08','2023-05-15','X'),
  ('1', '1','0004','2023-02-10','2023-05-10','X');


  -- Act: 
  SELECT    
    [SalesDocument],
    [SalesDocumentItem],
    [ScheduleLine],
    [ConfirmedDeliveryDate],
    [GoodsIssueDate],
    [IsConfirmedDelivSchedLine]
  INTO actual
  FROM [intm_s4h].[vw_SalesDocumentEarliestConfirmedDeliveryDate]
  GROUP BY
    [SalesDocument],
    [SalesDocumentItem],
    [ScheduleLine],
    [ConfirmedDeliveryDate],
    [GoodsIssueDate],
    [IsConfirmedDelivSchedLine]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
