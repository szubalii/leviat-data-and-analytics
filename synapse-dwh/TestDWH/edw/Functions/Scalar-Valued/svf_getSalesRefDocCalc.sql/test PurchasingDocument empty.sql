CREATE PROCEDURE [tc.edw.svf_getSalesRefDocCalc].[test PurchasingDocument empty]
AS
BEGIN

  DECLARE @actual NVARCHAR(10) = ( 
    SELECT [edw].[svf_getSalesRefDocCalc]('', 'VBRK', '', '2222222222', '3333333333')
  );

  EXEC tSQLt.AssertEquals '3333333333', @actual;
END;