CREATE PROCEDURE [tc.edw.vw_ACDOCA_ReferenceSalesDocument].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_GLAccountLineItemRawData_202301]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SDDocumentProcessFlow]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';
  
  INSERT INTO base_s4h_cax.I_GLAccountLineItemRawData_202301 (
     [SourceLedger]
    ,[CompanyCode]
    ,[FiscalYear]
    ,[AccountingDocument]
    ,[LedgerGLLineItem]
    ,[AccountingDocumentType]
    ,[SalesDocumentID]
    ,[SalesDocumentItemID]
    )
  VALUES 
    ('TS', 'TS35', 2023, '00123', '000001', 'DC', '1', '000001')
    ,('TS', 'TS35', 2023, '00123', '000001', 'AC', '2', '000001');

  INSERT INTO base_s4h_cax.I_SDDocumentProcessFlow (
     [PrecedingDocument]
    ,[PrecedingDocumentItem]
    ,[SubsequentDocumentCategory]
    ,[PrecedingDocumentCategory]
    ,[SubsequentDocument]
    ,[SubsequentDocumentItem]
  )
  VALUES
  ('1', '000001', 'C', 'D', '11', '000010')
  ,('2', '000001', 'C', 'D', '12', '000010')
  ,('10', '000001', 'C', 'C', '1', '000001')
  ,('20', '000001', 'C', 'C', '2', '000001');

  INSERT INTO edw.fact_SalesDocumentItem (
    SalesDocument
    ,SalesDocumentItem
  )
  VALUES
   ('1', '000001')
  ,('2', '000001');

  -- Act: 
  SELECT
    [SourceLedgerID]
    ,[CompanyCodeID]
    ,[FiscalYear]
    ,[AccountingDocument]
    ,[LedgerGLLineItem]
  INTO actual
  FROM [edw].[vw_ACDOCA_ReferenceSalesDocument]
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
