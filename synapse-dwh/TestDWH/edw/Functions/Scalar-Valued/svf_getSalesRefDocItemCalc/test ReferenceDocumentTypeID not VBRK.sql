CREATE PROCEDURE [tc.edw.svf_getSalesRefDocItemCalc].[test ReferenceDocumentTypeID not VBRK]
AS
BEGIN

  DECLARE @actual NVARCHAR(10) = ( 
    SELECT [edw].[svf_getSalesRefDocItemCalc]('', 'JJFF', '1111111111', '5555555555', '7777777777')
  );

  EXEC tSQLt.AssertEquals '7777777777', @actual;
END;