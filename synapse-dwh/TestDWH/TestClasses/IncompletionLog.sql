
EXEC [tSQLt].[SetFakeViewOn] 'edw';
GO

EXEC tSQLt.NewTestClass 'IncompletionLog';
GO

-- Do not select quotations in vw_SDDocumentIncompletionLog
CREATE PROCEDURE [IncompletionLog].[test edw.vw_SDDocumentIncompletionLog contains no quotations]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SDDocumentIncompletionLog]';

  
  INSERT INTO base_s4h_cax.I_SDDocumentIncompletionLog (SDDocument)
  VALUES
    ('001');

  -- Act: 
  SELECT
    SDDocument
  INTO actual
  FROM [edw].[vw_SDDocumentIncompletionLog]

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO


-- Test IsIncomplete field
CREATE PROCEDURE [IncompletionLog].[test dm_sales.vw_fact_OrderBacklog.IsIncomplete]
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
GO


-- Join IncompletionLog with C_SalesDocumentItemDEX
CREATE PROCEDURE [IncompletionLog].[test dm_sales.vw_fact_OrderBacklog: join IncompletionLog]
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
GO


EXEC [tSQLt].[SetFakeViewOff] 'edw';

GO
