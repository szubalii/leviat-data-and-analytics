CREATE PROC [utilities].[up_upsert_delta_active_table]
  @schema_name NVARCHAR(128),
  @delta_view_name NVARCHAR(128),
  @active_table_name NVARCHAR(128)
AS
BEGIN


-- TODO USE TRANSACTION?

  DECLARE
    @errmessage NVARCHAR(2048),
    @date_time_string NVARCHAR(23) = CONVERT(NVARCHAR(23), GETUTCDATE(), 127),
    @system_user NVARCHAR(100) = SYSTEM_USER;

  DECLARE
    @active_table_id INT = OBJECT_ID(@schema_name + '.' + @active_table_name, 'U'),
    @delta_view_id INT = OBJECT_ID(@schema_name + '.' + @delta_view_name, 'V');
    

	IF @active_table_id IS NULL
	BEGIN
		SET @errmessage = 'Object [' + @schema_name + '].['+ @active_table_name +'] does not exist. 
            Please check parameter values: @schema_name = ''' + @schema_name + 
            ''',@active_table_name = ''' + @active_table_name + '''';
		THROW 50001, @errmessage, 1;
	END

  IF @delta_view_id IS NULL
	BEGIN
		SET @errmessage = 'Object [' + @schema_name + '].['+ @delta_view_name +'] does not exist. 
            Please check parameter values: @schema_name = ''' + @schema_name + 
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
        schema_name = @schema_name
    ),
    @primary_key_fields NVARCHAR(MAX) = (
      SELECT
        primary_key_col_names
      FROM
        utilities.vw_PrimaryKeyColNamesString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @non_lastAction_col_names NVARCHAR(MAX) = (
      SELECT
        non_lastAction_col_names
      FROM
        utilities.vw_NonLastActionColNamesString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @non_lastAction_cols_update NVARCHAR(MAX) = (
      SELECT
        non_lastAction_cols_update
      FROM
        utilities.vw_NonLastActionColsUpdateString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @update_scrpt_where_clause NVARCHAR(MAX) = (
      SELECT
        update_scrpt_where_clause
      FROM
        utilities.vw_UpdateScriptWhereClause
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @insert_scrpt_where_clause NVARCHAR(MAX) = (
      SELECT
        insert_scrpt_where_clause
      FROM
        utilities.vw_InsertScriptWhereClause
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    );

  DECLARE
    @update_scrpt NVARCHAR(MAX) = utilities.svf_getDeltaUpdateScript(
      @schema_name,
      @active_table_name,
      @delta_view_name,
      @non_lastAction_cols_update,
      @update_scrpt_where_clause,
      @system_user,
      @date_time_string
    ),

    @insert_scrpt NVARCHAR(MAX) = utilities.svf_getDeltaInsertScript(
      @schema_name,
      @active_table_name,
      @delta_view_name,
      @col_names,
      @non_lastAction_col_names,
      @primary_key_fields,
      @insert_scrpt_where_clause,
      @system_user,
      @date_time_string
    );    
  
  EXEC sp_executesql @update_scrpt;

  EXEC sp_executesql @insert_scrpt;

END