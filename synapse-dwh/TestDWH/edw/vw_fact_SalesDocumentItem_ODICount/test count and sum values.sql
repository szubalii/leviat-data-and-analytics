CREATE PROCEDURE [tc.edw.vw_fact_SalesDocumentItem_ODICount].[test count and sum values]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

  INSERT INTO [base_s4h_cax].[I_OutboundDeliveryItem](
     [OutboundDelivery]
    ,[OutboundDeliveryItem]
    ,[ActualDeliveryQuantity]
    ,[ReferenceSDDocument]
    ,[ReferenceSDDocumentItem])
  VALUES('1','1',32.000,'1','1'),('1','1',10.000,'',''),
  ('1','1',7.000,NULL,NULL),,('1','1',10.000,'1','1');

  INSERT INTO [edw].[fact_SalesDocumentItem] (
    [SalesDocument],
    [SalesDocumentItem],
    [CurrencyTypeID],
    [t_applicationId])
  VALUES ('1','1','30','s4h-cad'),
  ('2','2','30','axbi'),
  ('1','1','10','s4h-cad'),
  ('4','4','10','axbi');

  -- Act: 
  SELECT
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[NrODIPerSDIAndQtyNot0]
    ,[ActDelQtyTotalForSDI]
  INTO actual
  FROM [edw].[vw_fact_SalesDocumentItem_ODICount];

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[NrODIPerSDIAndQtyNot0]
    ,[ActDelQtyTotalForSDI])
  VALUES
    ('1','1',2,42.000);

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;