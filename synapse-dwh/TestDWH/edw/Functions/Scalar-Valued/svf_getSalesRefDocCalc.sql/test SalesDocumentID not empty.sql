CREATE PROCEDURE [tc.edw.svf_getSalesRefDocItemCalc].[test SalesDocumentID not empty]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getSalesRefDocCalc]('111111', 'VBRK', '1111111111', '2222222222', '3333333333')
  );

  EXEC tSQLt.AssertEquals '3333333333', @actual;
END;