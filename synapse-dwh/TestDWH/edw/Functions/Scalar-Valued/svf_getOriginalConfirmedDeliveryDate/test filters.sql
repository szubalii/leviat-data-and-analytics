CREATE PROCEDURE [tc.edw.svf_getOriginalConfirmedDeliveryDate].[test filters]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  ---- Assemble:
  CREATE TABLE testdata (
    ActualDeliveryQuantity decimal(13,3),
    SDI_ConfdDelivQtyInOrderQtyUnit decimal(15,3),
    OriginalConfirmedDeliveryDate DATE,
    MinOriginalConfirmedDeliveryDate DATE,
    ConfirmedDeliveryDate DATE
);

  INSERT INTO testdata (
    ActualDeliveryQuantity,
    SDI_ConfdDelivQtyInOrderQtyUnit,
    OriginalConfirmedDeliveryDate,
    MinOriginalConfirmedDeliveryDate,
    ConfirmedDeliveryDate
    )
  VALUES 
    (10, 10, '2023-11-11', '2023-12-13', NULL),
    (20, 20, NULL,'2023-12-13', '2023-10-22'),
    (30, 10, NULL,'2023-02-13', '2023-10-22'),
    (10, 40, '2023-02-13', NULL, '2023-10-24');

  ---- Act:
    SELECT
    ActualDeliveryQuantity,
    SDI_ConfdDelivQtyInOrderQtyUnit,
    OriginalConfirmedDeliveryDate,
    MinOriginalConfirmedDeliveryDate,
    ConfirmedDeliveryDate
    [edw].[svf_getOriginalConfirmedDeliveryDate](
        ActualDeliveryQuantity
        ,SDI_ConfdDelivQtyInOrderQtyUnit
        ,[OriginalConfirmedDeliveryDate]
        ,[MinOriginalConfirmedDeliveryDate]
        ,[ConfirmedDeliveryDate]
    ) AS SL_OriginalConfirmedDeliveryDate
  INTO actual
  FROM testdata;

  ---- Assert:
  CREATE TABLE expected (
    ActualDeliveryQuantity decimal(13,3),
    SDI_ConfdDelivQtyInOrderQtyUnit decimal(15,3),
    OriginalConfirmedDeliveryDate DATE,
    MinOriginalConfirmedDeliveryDate DATE,
    ConfirmedDeliveryDate DATE
    SL_OriginalConfirmedDeliveryDate DATE
  );

  INSERT INTO expected (
    ActualDeliveryQuantity,
    SDI_ConfdDelivQtyInOrderQtyUnit,
    OriginalConfirmedDeliveryDate1,
    OriginalConfirmedDeliveryDate2,
    ConfirmedDeliveryDate,
    SalesDocumentID,
    SalesDocumentItemID,
    SL_OriginalConfirmedDeliveryDate
  )
  VALUES 
    (10, 10, '2023-11-11', '2023-12-13', NULL, '2023-11-11'),
    (20, 20, NULL, '2023-12-13', '2023-10-22', '2023-10-22'),
    (30, 10, NULL, '2023-02-13', '2023-10-22', '2023-02-13'),
    (10, 40, '2023-02-13', NULL, '2023-10-24', '2023-10-24');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
