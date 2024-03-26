CREATE PROCEDURE [tc.utilities.svf_getMaterializeTempScript].[test materialize temp script]
AS
BEGIN

  CREATE TABLE [edw].[dim_table](
    id INT
  );

  DECLARE
    @DestSchema NVARCHAR(128) = 'edw',
    @DestTable NVARCHAR(128) = 'dim_table';

  DECLARE
    @actual NVARCHAR(MAX) = [utilities].[svf_getMaterializeTempScript](
      @DestSchema,
      @DestTable
    ),
    @expected NVARCHAR(MAX) = N'
IF OBJECT_ID(''tempdb..#edw_dim_table'') IS NOT NULL
  DROP TABLE [tempdb..#edw_dim_table];

SELECT *
INTO [#edw_dim_table]
FROM [edw].[dim_table];

TRUNCATE TABLE [edw].[dim_table]';

  -- TODO include where clause where extraction DTm is higher in delta vw than active

  EXEC tSQLt.AssertEqualsString @actual, @expected;

  DROP TABLE [edw].[dim_table]

END
