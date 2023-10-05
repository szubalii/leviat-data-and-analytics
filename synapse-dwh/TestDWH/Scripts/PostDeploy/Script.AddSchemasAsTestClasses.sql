-- Iterate over the test case schemas (tc.***) and define them as tSQLt test classes
SELECT
  name,
  ROW_NUMBER() OVER (ORDER BY (name)) as seq_no
INTO #testClassSchemas
FROM sys.schemas
WHERE name LIKE 'tc.%';

DECLARE
  @c INT = (SELECT COUNT(*) FROM #testClassSchemas)
, @i INT = 1        -- iterator for while loop
, @q NVARCHAR(4000) -- query
, @s NVARCHAR(128); -- schema name

WHILE @i <= @c
BEGIN
  SET @s = (SELECT name FROM #testClassSchemas WHERE seq_no = @i);
  SET @q = (
    SELECT N'
      EXECUTE sp_addextendedproperty
        @name = N''tSQLt.TestClass'',
        @value = 1,
        @level0type = N''SCHEMA'',
        @level0name = N'''+@s+N''';'
  );

  -- PRINT @q;
  EXECUTE sp_executesql @q;
  SET @i+=1;
END

DROP TABLE #testClassSchemas;