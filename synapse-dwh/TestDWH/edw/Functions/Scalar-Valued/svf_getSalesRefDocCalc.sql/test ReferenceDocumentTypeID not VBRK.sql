CREATE PROCEDURE [tc.edw.svf_getSalesRefDocCalc].[test ReferenceDocumentTypeID not VBRK]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getSalesRefDocCalc]('', 'JJFF', '1111111111', '2222222222', 3333333333)
  );

  EXEC tSQLt.AssertEquals 3333333333, @actual;
END;