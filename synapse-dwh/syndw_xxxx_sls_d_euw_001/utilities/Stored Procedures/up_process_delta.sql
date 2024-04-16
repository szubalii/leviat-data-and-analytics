CREATE PROC [utilities].[up_process_delta]
  @delta_schema_name NVARCHAR(128),
  @delta_table_name NVARCHAR(128),
  @delta_view_name NVARCHAR(128),
  @active_schema_name NVARCHAR(128),
  @active_table_name NVARCHAR(128),
  @is_BASE_delta BIT,
	@t_jobId VARCHAR(36),
	@t_jobDtm DATETIME,
	@t_lastActionCd VARCHAR(1),
	@t_jobBy NVARCHAR(128)
AS
BEGIN


-- TODO USE TRANSACTION?


  -- DECLARE
  --   @schema_name NVARCHAR(128) = 'base_s4h_cax',
  --   @table_name NVARCHAR(128) = '';

  DECLARE
    @errmessage NVARCHAR(2048),
    -- @delta_table_name NVARCHAR(128) = @table_name + '_delta',
    -- @active_table_name NVARCHAR(128) = @table_name + '_active',
    -- @delta_view_name NVARCHAR(128) = 'vw_' + @table_name + '_delta',
    @date_time_string NVARCHAR(23) = CONVERT(NVARCHAR(23), GETUTCDATE(), 127),
    @system_user NVARCHAR(100) = SYSTEM_USER;

  DECLARE
    @active_table_id INT = OBJECT_ID(@active_schema_name + '.' + @active_table_name, 'U'),
    @delta_view_id INT = OBJECT_ID(@delta_schema_name + '.' + @delta_view_name, 'V');
    

	IF @active_table_id IS NULL
	BEGIN
		SET @errmessage = 'Object [' + @active_schema_name + '].['+ @active_table_name +'] does not exist. 
            Please check parameter values: @schema_name = ''' + @active_schema_name + 
            ''',@active_table_name = ''' + @active_table_name + '''';
		THROW 50001, @errmessage, 1;
	END

  IF @delta_view_id IS NULL
	BEGIN
		SET @errmessage = 'Object [' + @delta_schema_name + '].['+ @delta_view_name +'] does not exist. 
            Please check parameter values: @schema_name = ''' + @delta_schema_name + 
            ''',@delta_view_name = ''' + @delta_view_name + '''';
		THROW 50001, @errmessage, 1;
	END

  DECLARE
    @col_names NVARCHAR(MAX) = (
      SELECT
        col_names
      FROM
        utilities.vw_ColNamesString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @active_schema_name
    ),
    @primary_key_fields NVARCHAR(MAX) = (
      SELECT
        primary_key_col_names
      FROM
        utilities.vw_PrimaryKeyColNamesString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @active_schema_name
    ),
    @non_lastAction_col_names NVARCHAR(MAX) = (
      SELECT
        non_lastAction_col_names
      FROM
        utilities.vw_NonLastActionColNamesString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @active_schema_name
    ),
    @non_lastAction_cols_update NVARCHAR(MAX) = (
      SELECT
        non_lastAction_cols_update
      FROM
        utilities.vw_NonLastActionColsUpdateString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @active_schema_name
    ),
    @update_scrpt_where_clause NVARCHAR(MAX) = (
      SELECT
        update_scrpt_where_clause
      FROM
        utilities.vw_UpdateScriptWhereClause
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @active_schema_name
    ),
    @insert_scrpt_where_clause NVARCHAR(MAX) = (
      SELECT
        insert_scrpt_where_clause
      FROM
        utilities.vw_InsertScriptWhereClause
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @active_schema_name
    );

  DECLARE
    @update_scrpt NVARCHAR(MAX) = utilities.svf_getDeltaUpdateScript(
      @active_schema_name,
      @active_table_name,
      @delta_view_name,
      @non_lastAction_cols_update,
      @update_scrpt_where_clause,
      @system_user,
      @date_time_string
    ),

    @insert_scrpt NVARCHAR(MAX) = utilities.svf_getDeltaInsertScript(
      @active_schema_name,
      @active_table_name,
      @delta_view_name,
      @col_names,
      @non_lastAction_col_names,
      @primary_key_fields,
      @insert_scrpt_where_clause,
      @system_user,
      @date_time_string
    );

    -- SELECT @update_scrpt
    -- SELECT @insert_scrpt

  BEGIN TRANSACTION;
    BEGIN TRY
    
      -- Update the _active table with the records from the _delta table
      EXEC sp_executesql @update_scrpt;

      -- Insert the new _delta records not existing in the _active table yet
      EXEC sp_executesql @insert_scrpt;

      -- In case of BASE layer delta, insert the records from the BASE._delta table
      -- into the INTM._delta table for follow-up delta for edw
      IF CAST(@is_BASE_delta) = 1
      BEGIN
        DECLARE @materialize_scrpt NVARCHAR(MAX) = utilities.svf_getMaterializeTransactionScript(
          @delta_schema_name,
          @delta_table_name,
          'intm_s4h',
          @delta_table_name,
          0,
          @t_jobId,
          @t_jobDtm,
          @t_lastActionCd,
          @t_jobBy
        );
        EXEC sp_executesql @materialize_scrpt;
      END

      -- Truncate the _delta table
      EXEC [utilities].[sp_truncate_table]
        @delta_schema_name,
        @delta_table_name

    END TRY
    BEGIN CATCH
      IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

      DECLARE @error_msg NVARCHAR(MAX) = (SELECT COALESCE(ERROR_MESSAGE(), ''''));
      DECLARE @error_msg2 NVARCHAR(MAX) = 'Failed to process delta for [' + @delta_schema_name + '].[' + @delta_view_name + '] into [' + @active_schema_name + '].[' + @active_table_name + ']:'' + CHAR(13) + CHAR(10) + @error_msg';

      THROW 50001, @error_msg2, 1;
    END CATCH;

  IF @@TRANCOUNT > 0
    COMMIT TRANSACTION;

END