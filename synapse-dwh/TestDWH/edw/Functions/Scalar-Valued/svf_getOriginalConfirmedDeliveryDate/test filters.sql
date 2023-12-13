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
    OriginalConfirmedDeliveryDate1 DATE,
    OriginalConfirmedDeliveryDate2 DATE,
    ConfirmedDeliveryDate DATE,
    SalesDocumentID nvarchar(10),
    SalesDocumentItemID nvarchar(6)
);

  INSERT INTO testdata (
    ActualDeliveryQuantity,
    SDI_ConfdDelivQtyInOrderQtyUnit,
    OriginalConfirmedDeliveryDate1,
    OriginalConfirmedDeliveryDate2,
    ConfirmedDeliveryDate,
    SalesDocumentID,
    SalesDocumentItemID
    )
  VALUES 
    (10, 10,'2023-12-13', '2023-11-11', NULL, 1, 10),
    (20, 20,'2023-12-13', NULL, '2023-10-22', 2, 20),
    (30, 10,'2023-02-13', NULL, '2023-10-22', 2, 20),
    (10, 40, NULL, '2023-02-13', '2023-10-24', 4, 40);

  ---- Act:
  SELECT
    [edw].[svf_getOriginalConfirmedDeliveryDate](
        ActualDeliveryQuantity
        ,SDI_ConfdDelivQtyInOrderQtyUnit
        ,[OriginalConfirmedDeliveryDate1]
        ,[OriginalConfirmedDeliveryDate2]
        ,[ConfirmedDeliveryDate]
        ,[SalesDocumentID]
        ,[SalesDocumentItemID]
    ) AS SL_OriginalConfirmedDeliveryDate
  INTO actual
  FROM testdata;

  ---- Assert:
  CREATE TABLE expected (
    ActualDeliveryQuantity decimal(13,3),
    SDI_ConfdDelivQtyInOrderQtyUnit decimal(15,3),
    OriginalConfirmedDeliveryDate1 DATE,
    OriginalConfirmedDeliveryDate2 DATE,
    ConfirmedDeliveryDate DATE,
    SalesDocumentID nvarchar(10),
    SalesDocumentItemID nvarchar(6),
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
    (10, 10,'2023-12-13', '2023-11-11', NULL, 1, 10, '2023-11-11'),
    (20, 20,'2023-12-13', NULL, '2023-10-22', 2, 20, '2023-10-22'),
    (30, 10,'2023-02-13', NULL, '2023-10-22', 2, 20, '2023-02-13'),
    (10, 40, NULL, '2023-02-13', '2023-10-24', 4, 40, '2023-10-24');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
