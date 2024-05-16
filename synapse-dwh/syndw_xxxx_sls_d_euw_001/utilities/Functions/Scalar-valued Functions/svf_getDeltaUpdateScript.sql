CREATE FUNCTION [utilities].[svf_getDeltaUpdateScript](
  @schema_name NVARCHAR(128),
  @active_table_name NVARCHAR(128),
  @delta_view_name NVARCHAR(128),
  @non_lastAction_cols_update NVARCHAR(MAX),
  @update_scrpt_where_clause NVARCHAR(1000),
  @system_user NVARCHAR(100),
  @date_time_string NVARCHAR(23)  
)

-- Used for generating dynamic SQL for loading delta records from delta table into active table. 
-- This function returns the Where Clause used in the Update statement

RETURNS NVARCHAR(MAX)
AS
BEGIN

  DECLARE @update_scrpt NVARCHAR(MAX) = N'
UPDATE
  [' + @schema_name + '].[' + @active_table_name + '] 
SET
  ' + @non_lastAction_cols_update + ',
  [' + @schema_name + '].[' + @active_table_name + '].[t_lastActionBy] = ''' + @system_user + ''',
  [' + @schema_name + '].[' + @active_table_name + '].[t_lastActionCd] = (
    CASE
      WHEN src.[ODQ_CHANGEMODE] = ''U'' AND src.[ODQ_ENTITYCNTR] =  1 THEN ''U''
      WHEN src.[ODQ_CHANGEMODE] = ''D'' AND src.[ODQ_ENTITYCNTR] = -1 THEN ''D''
      WHEN src.[ODQ_CHANGEMODE] = '''' AND src.[ODQ_ENTITYCNTR] =  0 THEN ''U''
      WHEN src.[ODQ_CHANGEMODE] = ''C'' AND src.[ODQ_ENTITYCNTR] = 1 THEN ''U''
    END
  ),
  [' + @schema_name + '].[' + @active_table_name + '].[t_lastActionDtm] = ''' + @date_time_string + ''' 
FROM
  [' + @schema_name + '].[' + @delta_view_name + '] as src 
WHERE
  ' + @update_scrpt_where_clause + '
OPTION (
  LABEL=''Process Delta Update [' + @schema_name + '].[' + @delta_view_name + '] into [' + @schema_name + '].[' + @active_table_name + ']; Last Action DTM: ' + @date_time_string + '''
)';
  RETURN(@update_scrpt);
END;