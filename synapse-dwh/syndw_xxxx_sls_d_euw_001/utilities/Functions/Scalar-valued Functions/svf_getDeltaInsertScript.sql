CREATE FUNCTION [utilities].[svf_getDeltaInsertScript](
  @schema_name NVARCHAR(128),
  @active_table_name NVARCHAR(128),
  @delta_view_name NVARCHAR(128),
  @col_names NVARCHAR(MAX),
  @non_lastAction_col_names NVARCHAR(MAX),
  @primary_key_fields NVARCHAR(1000),
  @insert_scrpt_where_clause NVARCHAR(1000),
  @system_user NVARCHAR(100),
  @date_time_string NVARCHAR(23)
)

-- Used for generating dynamic SQL for loading delta records from delta table into active table. 
-- This function returns the Where Clause used in the Update statement

RETURNS NVARCHAR(MAX)
AS
BEGIN

  DECLARE @insert_scrpt NVARCHAR(MAX) = N'
INSERT INTO
  [' + @schema_name + '].[' + @active_table_name + '] ('
  + @col_names + '
)
SELECT
  ' + @non_lastAction_col_names + ',
  ''' + @system_user + ''' AS [t_lastActionBy],
  CASE
    WHEN src.[ODQ_CHANGEMODE] = ''''  AND src.[ODQ_ENTITYCNTR] = 0
      THEN ''I''
    WHEN src.[ODQ_CHANGEMODE] = ''U'' AND src.[ODQ_ENTITYCNTR] = 1
      THEN ''I''
    WHEN src.[ODQ_CHANGEMODE] = ''D'' AND src.[ODQ_ENTITYCNTR] = -1
      THEN ''D''
    WHEN src.[ODQ_CHANGEMODE] = ''C'' AND src.[ODQ_ENTITYCNTR] = 1
      THEN ''I''
  END AS [t_lastActionCd],
  ''' + @date_time_string + ''' AS [t_lastActionDtm] 
FROM
  [' + @schema_name + '].[' + @delta_view_name + '] AS src 
WHERE NOT EXISTS (
  SELECT
    ' + @primary_key_fields + '
  FROM
    [' + @schema_name + '].[' + @active_table_name + '] target 
  WHERE
    ' + @insert_scrpt_where_clause + '
)';

  RETURN(@insert_scrpt);
END;