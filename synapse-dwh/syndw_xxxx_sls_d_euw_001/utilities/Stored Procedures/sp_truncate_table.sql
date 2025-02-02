CREATE PROCEDURE [utilities].[sp_truncate_table]
  @schema_name VARCHAR(128),
  @table_name VARCHAR(112)
AS
BEGIN
  DECLARE @truncate_script NVARCHAR(4000) = N'

    IF OBJECT_ID(''[' + @schema_name + '].[' + @table_name + ']'') IS NOT NULL
      TRUNCATE TABLE [' + @schema_name + '].[' + @table_name + ']';

  EXEC sp_executesql @truncate_script;
END;
