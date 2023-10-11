
-- Test IsIncomplete field
CREATE PROCEDURE [tc.dm_sales.vw_fact_OrderBacklog].[test IsIncomplete field]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_SDDocumentIncompletionLog]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[C_SalesDocumentItemDEX]';

  INSERT INTO base_s4h_cax.C_SalesDocumentItemDEX (SalesDocument, SalesDocumentItem, SDDocumentCategory)
  VALUES (1, 1, 'C'), (1, 2, 'C'), (2, 1, 'C');

  INSERT INTO edw.dim_SDDocumentIncompletionLog (SDDocument, SDDocumentItem, ScheduleLine)
  VALUES (1, 1, 1), (1, 1, 2);

  -- Act: 
  SELECT
    SalesDocument,
    SalesDocumentItem,
    IsIncomplete
  INTO actual
  FROM [dm_sales].[vw_fact_OrderBacklog]

  -- Assert:
  CREATE TABLE expected (
    SalesDocument INT,
    SalesDocumentItem INT,
    IsIncomplete VARCHAR(3)
  );

  INSERT INTO expected(
    SalesDocument,
    SalesDocumentItem,
    IsIncomplete
  )
  VALUES
    (1, 1, 'Yes'),
    (1, 2, 'No'),
    (2, 1, 'No');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
