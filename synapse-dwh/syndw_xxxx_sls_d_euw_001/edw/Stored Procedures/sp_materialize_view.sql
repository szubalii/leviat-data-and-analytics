/*

  This stored procedure handles the materialization of data from a provided source view
  into a provided destination table. 

  To make sure the destination table keeps the same distribution and indexes the following
  approach is taken:
  
  1. Store the current data in the destination table into a temp table
  2. Truncate the destination table
  3. Insert the new data from the view into the destination table
  
  If anything goes wrong during the insert:
  4. Truncate the destination table once more
  5. Insert the data from the temp table back into the destination table

*/

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

	DECLARE
    @create_tmp_script NVARCHAR(MAX),
	  @Columns NVARCHAR(MAX),
	  @errmessage NVARCHAR(2048),
    @total_script NVARCHAR(MAX),
    @insert_script NVARCHAR(MAX);


  -- Test if the provided destination table name exists
	IF OBJECT_ID(@DestSchema + '.' + @DestTable, 'U') IS NULL
	BEGIN
		SET @errmessage = 'Object [' + @DestSchema + '].['+ @DestTable +'] does not exist.' + CHAR(13) + CHAR(10) +
      'Please check parameter values: @DestSchema = ''' + @DestSchema + ''',@DestTable = ''' + @DestTable + '''';
		THROW 50001, @errmessage, 1;
	END

-- Test if the provided view name exists
	IF OBJECT_ID(@SourceSchema + '.' + @SourceView, 'V') IS NULL
	BEGIN
		SET @errmessage = 'Object [' + @SourceSchema + '].['+ @SourceView +'] does not exist.'  + CHAR(13) + CHAR(10) +
      'Please check parameter values: @SourceSchema = ''' + @SourceSchema + ''',@SourceView = ''' + @SourceView + '''';
		THROW 50001, @errmessage, 1;
	END

	BEGIN
    
    -- Store the destination table contents to temp backup table
    -- Truncate the destination table
    -- SET @create_tmp_script = utilities.svf_getMaterializeTempScript(
    --   @DestSchema,
    --   @DestTable
    -- );

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

    -- Create the insert statement script and insert in the original table
    -- so that the original distribution and index is kept
    DECLARE @transaction_script NVARCHAR(MAX) = utilities.svf_getMaterializeTransactionScript(
      @DestSchema,
      @DestTable,
      @SourceSchema,
      @SourceView,
      @Columns,
      @t_jobId,
      @t_jobDtm,
      @t_lastActionCd,
      @t_jobBy
    );


    -- create single dynamic script so that compilation is done over all scripts
    -- and potential issues arise before truncate table is executed.
    -- SET @total_script = ( SELECT CONCAT_WS(CHAR(13) + CHAR(10), @create_tmp_script, @insert_script) );

    EXECUTE sp_executesql @transaction_script;

      -- DECLARE @rename_script NVARCHAR(MAX) = N'
      --     RENAME OBJECT [' + @DestSchema + '].[' + @DestTable + '] TO [' + @DestTable + '_old];
      --     RENAME OBJECT [' + @DestSchema + '].[' + @DestTable + '_tmp] TO [' + @DestTable + '];
      --     DROP TABLE [' + @DestSchema + '].[' + @DestTable + '_old]';

      -- EXECUTE sp_executesql @rename_script;
  END
END
