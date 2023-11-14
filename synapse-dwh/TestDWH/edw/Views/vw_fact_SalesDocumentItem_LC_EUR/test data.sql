
CREATE PROCEDURE [tc.edw.vw_fact_SalesDocumentItem_LC_EUR].[test data]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

  
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
  ('3','3',12.000,382.580000,1099.440000,'10','s4h-cad'),
  ('4','4',12.000,382.580000,1099.440000,'10','axbi');

  -- Act: 
  SELECT
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[SDI_PricePerPiece_LC]
    ,[SDI_PricePerPiece_EUR]
    ,[SDI_CostAmount_LC]
    ,[SDI_CostAmount_EUR]
    ,[SDI_NetAmount_LC]
    ,[SDI_NetAmount_EUR]    
    ,[SDI_OrderQuantity]
  INTO actual
  FROM [edw].[vw_fact_SalesDocumentItem_LC_EUR];

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[SDI_PricePerPiece_LC]
    ,[SDI_PricePerPiece_EUR]
    ,[SDI_CostAmount_LC]
    ,[SDI_CostAmount_EUR]
    ,[SDI_NetAmount_LC]
    ,[SDI_NetAmount_EUR]
    ,[SDI_OrderQuantity])
  VALUES('3','3',91.6200000000000000000000,NULL,382.580000,NULL,1099.440000,NULL,12.000),
  ('1','1',NULL,10.2800000000000000000000,NULL,8114.000000,NULL,2056.000000,200.000);
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;