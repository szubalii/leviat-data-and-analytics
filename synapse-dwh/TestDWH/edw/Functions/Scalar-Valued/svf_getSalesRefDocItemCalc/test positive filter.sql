CREATE PROCEDURE [tc.edw.svf_getSalesRefDocItemCalc].[test positive filter]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getSalesRefDocItemCalc]('', 'VBRK', '1111111111', '5555555555', '7777777777')
  );

  EXEC tSQLt.AssertEquals 5555555555, @actual;
END;