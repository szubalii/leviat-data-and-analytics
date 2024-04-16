/*

  This stored procedure handles the materialization of data from a provided source view
  into a provided destination table. 

  To make sure the destination table keeps the same distribution and indexes the following
  approach is taken:
  
  1. Begin transaction
  2. Delete all records from the destination table
  3. Insert the new data from the view into the destination table
  
  If anything goes wrong during the insert:
  4. Rollback transaction

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
    @total_script NVARCHAR(MAX);


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
    
	  -- Retrieve the column list by selecting those columns that exist both in the source view as in the destination table
    SET @Columns = (
      SELECT
        STRING_AGG( '[' + CAST(vc.COLUMN_NAME AS NVARCHAR(MAX)) + ']', ',' + CHAR(13) + CHAR(10))
          WITHIN GROUP ( ORDER BY vc.ORDINAL_POSITION ) AS column_names
      FROM
        INFORMATION_SCHEMA.COLUMNS vc
      INNER JOIN
        INFORMATION_SCHEMA.COLUMNS tc
        ON
          tc.TABLE_NAME = @DestTable
          AND
          tc.TABLE_SCHEMA = @DestSchema
          AND
          vc.TABLE_NAME = @SourceView
          AND
          vc.TABLE_SCHEMA = @SourceSchema
          AND
          tc.COLUMN_NAME = vc.COLUMN_NAME
      WHERE
        tc.COLUMN_NAME NOT IN ('t_jobId', 't_jobDtm', 't_lastActionCd', 't_jobBy')
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

    EXECUTE sp_executesql @transaction_script;
  END
END
