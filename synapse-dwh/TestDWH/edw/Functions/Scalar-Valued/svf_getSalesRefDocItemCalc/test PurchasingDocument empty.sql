CREATE PROCEDURE [tc.edw.svf_getSalesRefDocItemCalc].[test PurchasingDocument empty]
AS
BEGIN

  DECLARE @actual NVARCHAR(10) = ( 
    SELECT [edw].[svf_getSalesRefDocItemCalc]('', 'VBRK', '', '5555555555', '7777777777')
  );

  EXEC tSQLt.AssertEquals '7777777777', @actual;
END;