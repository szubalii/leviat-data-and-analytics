CREATE PROCEDURE [tc.edw.svf_getSalesRefDocCalc].[test positive filter]
AS
BEGIN

  DECLARE @actual NVARCHAR(10) = ( 
    SELECT [edw].[svf_getSalesRefDocCalc]('', 'VBRK', '1111111111', '2222222222', '3333333333')
  );

  EXEC tSQLt.AssertEquals '2222222222', @actual;
END;