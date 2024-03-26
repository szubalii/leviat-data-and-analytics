CREATE PROC [edw].[sp_materialize_view]
	@SourceSchema NVARCHAR(128),
	@SourceView NVARCHAR(128),
	@DestSchema NVARCHAR(128),
	@DestTable NVARCHAR(128),
	@t_jobId VARCHAR(36),
	@t_jobDtm DATETIME,
	@t_lastActionCd VARCHAR(1),
	@t_jobBy NVARCHAR(128)
AS
BEGIN

	DECLARE @create_tmp_script NVARCHAR(MAX);
	DECLARE @Columns NVARCHAR(MAX);
	DECLARE @errmessage NVARCHAR(2048);

  -- Test if the provided destination table name exists
	IF OBJECT_ID(@DestSchema + '.' + @DestTable, 'U') IS NULL
	BEGIN
		SET @errmessage = 'Object [' + @DestSchema + '].['+ @DestTable +'] does not exist.' + CHAR(13) + CHAR(10) +
      'Please check parameter values: @DestSchema = ''' + @DestSchema + ''',@DestTable = ''' + @DestTable + '''';
		THROW 50001, @errmessage, 1;
	END

-- Test if the provided view name exists
	IF NOT EXISTS(
		SELECT 1 
		FROM sys.views
		JOIN sys.[schemas]
			ON sys.views.schema_id = sys.[schemas].schema_id
		WHERE 
			sys.[schemas].name = @SourceSchema
			AND
			sys.views.name = @SourceView
			AND
			sys.views.type = 'v'
	)
	BEGIN
		SET @errmessage = 'Object [' + @SourceSchema + '].['+ @SourceView +'] does not exist.'  + CHAR(13) + CHAR(10) +
      'Please check parameter values: @SourceSchema = ''' + @SourceSchema + ''',@SourceView = ''' + @SourceView + '''';
		THROW 50001, @errmessage, 1;
	END

  -- Store the destination table contents to temp backup table
  -- Truncate the destination table
	BEGIN
		SET @create_tmp_script = utilities.svf_getMaterializeTempScript(
      @DestSchema,
      @DestTable
    );

    EXECUTE sp_executesql @create_tmp_script;

	  -- Retrieve the column list of the provided destination table
    SET @Columns = (
      SELECT
        non_t_job_col_names
      FROM
        utilities.vw_MaterializeColumnList
      WHERE
        table_name = @DestTable
        AND
        schema_name = @DestSchema
    );

    -- Create the insert statement script
    DECLARE @insert_script NVARCHAR(MAX) = utilities.svf_getMaterializeInsertScript(
      @DestSchema,
      @DestTable,
      @Columns,
      @t_jobId,
      @t_jobDtm,
      @t_lastActionCd,
      @t_jobBy
    );

    EXECUTE sp_executesql @insert_script;

      -- DECLARE @rename_script NVARCHAR(MAX) = N'
      --     RENAME OBJECT [' + @DestSchema + '].[' + @DestTable + '] TO [' + @DestTable + '_old];
      --     RENAME OBJECT [' + @DestSchema + '].[' + @DestTable + '_tmp] TO [' + @DestTable + '];
      --     DROP TABLE [' + @DestSchema + '].[' + @DestTable + '_old]';

      -- EXECUTE sp_executesql @rename_script;
  END
END
