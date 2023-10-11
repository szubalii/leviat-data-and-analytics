
-- Join IncompletionLog with C_SalesDocumentItemDEX
CREATE PROCEDURE [tc.dm_sales.vw_fact_OrderBacklog].[test join IncompletionLog]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[C_SalesDocumentItemDEX]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentScheduleLine]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SDDocumentIncompletionLog]';

  INSERT INTO base_s4h_cax.C_SalesDocumentItemDEX (SalesDocument, SalesDocumentItem)
  VALUES (1, 1), (1, 2);

  INSERT INTO edw.dim_SalesDocumentScheduleLine (SalesDocumentID, SalesDocumentItem, ScheduleLine)
  VALUES (1, 1, 1), (1, 1, 2);

  INSERT INTO edw.dim_SDDocumentIncompletionLog (SDDocument, SDDocumentItem, ScheduleLine, SDDocumentTableField)
  VALUES (1, 1, 1, 1), (1, 1, 1, 2);

  -- Act: 
  SELECT
    SalesDocument,
    SalesDocumentItem,
    ScheduleLine
  INTO actual
  FROM [dm_sales].[vw_fact_OrderBacklog]
  GROUP BY
    SalesDocument,
    SalesDocumentItem,
    ScheduleLine
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
