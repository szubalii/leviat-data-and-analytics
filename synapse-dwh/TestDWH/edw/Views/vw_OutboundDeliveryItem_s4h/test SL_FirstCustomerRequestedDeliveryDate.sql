CREATE PROCEDURE [tc.edw.vw_OutboundDeliveryItem_s4h].[test SL_FirstCustomerRequestedDeliveryDate]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';

  INSERT INTO [base_s4h_cax].[I_OutboundDeliveryItem] ([ReferenceSDDocument], [ReferenceSDDocumentItem])
  VALUES (1, 1), (2, 2);

  INSERT INTO [base_s4h_cax].[I_SalesDocumentScheduleLine] ([SalesDocument], [SalesDocumentItem], [ScheduleLine],[RequestedDeliveryDate])
  VALUES
    (1, 1, '0001','2023-10-11'),
    (1, 1, '0002','2023-10-11'),
    (2, 2, '0001','2023-10-10'),
    (2, 2, '0002','2023-10-09'),
    (2, 2, '0003','2023-10-08');

  -- Act: 
  SELECT
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [SL_FirstCustomerRequestedDeliveryDate]
  INTO actual
  FROM [edw].[vw_OutboundDeliveryItem_s4h]

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [SL_FirstCustomerRequestedDeliveryDate])
  VALUES
    (1, 1,'2023-10-11'),(2, 2,'2023-10-10');

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
