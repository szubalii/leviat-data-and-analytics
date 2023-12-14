CREATE PROCEDURE [tc.edw.vw_ACDOCA_ReferenceSalesDocument].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_GLAccountLineItemRawData_202301]';
  
  INSERT INTO base_s4h_cax.I_GLAccountLineItemRawData_202301 (
     [SourceLedger]
    ,[CompanyCode]
    ,[FiscalYear]
    ,[AccountingDocument]
    ,[LedgerGLLineItem]
    ,[AccountingDocumentType]
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
