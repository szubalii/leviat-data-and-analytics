CREATE PROCEDURE [tc.edw.vw_ACDOCA_ReferenceSalesDocument].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('#vw_GLAccountLineItemRawData') IS NOT NULL DROP TABLE #vw_GLAccountLineItemRawData;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_GLAccountLineItemRawData]';
  
  SELECT TOP(0) *
  INTO #vw_GLAccountLineItemRawData
  FROM edw.vw_GLAccountLineItemRawData;

  INSERT INTO edw.vw_GLAccountLineItemRawData (
     [SourceLedgerID]
    ,[CompanyCodeID]
    ,[FiscalYear]
    ,[AccountingDocument]
    ,[LedgerGLLineItem]
    ,[AccountingDocumentTypeID]
    )
  VALUES 
    ('TS', 'TS35', 2023, '00123', '000001', 'DC')
    ,('TS', 'TS35', 2023, '00123', '000001', 'AC');

  -- Act: 
  SELECT
    [SourceLedgerID]
    ,[CompanyCodeID]
    ,[FiscalYear]
    ,[AccountingDocument]
    ,[LedgerGLLineItem]
  INTO actual
  FROM [edw].[vw_GLAccountLineItemRawData]
  GROUP BY
    [SourceLedgerID]
    ,[CompanyCodeID]
    ,[FiscalYear]
    ,[AccountingDocument]
    ,[LedgerGLLineItem]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
