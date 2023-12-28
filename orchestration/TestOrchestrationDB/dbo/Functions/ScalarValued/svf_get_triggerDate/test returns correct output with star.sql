CREATE PROCEDURE [tc.dbo.svf_get_triggerDate].[test returns correct output]
AS
BEGIN  
  -- Act: 
  DECLARE @actual CHAR(8) = ( SELECT CONVERT(
    CHAR(8),
    dbo.svf_get_triggerDate('ITEM_GROUPS_2022_07_08_04_03_19_356*.parquet'),
    112
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals '20220708', @actual;
END;
GO

