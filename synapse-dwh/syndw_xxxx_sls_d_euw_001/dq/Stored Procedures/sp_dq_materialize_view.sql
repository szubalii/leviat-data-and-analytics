CREATE PROC [dq].[sp_dq_materialize_view]
	@SourceSchema NVARCHAR(128),
	@SourceView  NVARCHAR(128),
	@DestSchema NVARCHAR(128),
	@DestTable NVARCHAR(128),
	@t_jobId VARCHAR(36),
	@t_jobDtm DATETIME,
	@t_lastActionCd VARCHAR(1),
	@t_jobBy NVARCHAR(128)
AS
BEGIN

	DECLARE @Columns NVARCHAR(MAX);
	DECLARE @errmessage NVARCHAR(2048);

	IF OBJECT_ID(@DestSchema + '.' + @DestTable, 'U') IS NULL
	BEGIN
		SET @errmessage = 'Object [' + @DestSchema + '].['+ @DestTable +'] does not exist. 
            Please check parameter values: @DestSchema = ''' + @DestSchema + 
            ''',@DestTable = ''' + @DestTable + '''';
		THROW 50001, @errmessage, 1;
	END

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
		SET @errmessage = 'Object [' + @SourceSchema + '].['+ @SourceView +'] does not exist. 
            Please check parameter values: @SourceSchema = ''' + @SourceSchema + 
            ''',@SourceView = ''' + @SourceView + '''';
		THROW 50001, @errmessage, 1;
	END

	BEGIN
	--Insert data
        SET @Columns = (
            SELECT 
                STRING_AGG(
                    CAST('[' + src.COLUMN_NAME + ']' AS NVARCHAR(MAX)), 
                    ','
                ) 
            FROM 
                INFORMATION_SCHEMA.COLUMNS src
            JOIN 
                INFORMATION_SCHEMA.COLUMNS dest
                ON 
                    src.COLUMN_NAME = dest.COLUMN_NAME
            WHERE 
                src.COLUMN_NAME NOT IN ('t_jobId','t_jobDtm','t_lastActionCd','t_jobBy')
                AND src.TABLE_SCHEMA = @SourceSchema
                AND src.TABLE_NAME = @SourceView
                AND dest.TABLE_SCHEMA = @DestSchema
                AND dest.TABLE_NAME = @DestTable
        );

        DECLARE @insert_script NVARCHAR(MAX) = N'
            INSERT INTO 
                [' + @DestSchema + '].[' + @DestTable + '] (' + @Columns + ',t_jobId,t_jobDtm,t_lastActionCd,t_jobBy' + ') 
            SELECT 
                ' + @Columns + '
            ,	''' + @t_jobId + ''' AS t_jobId
            ,	''' + CONVERT(NVARCHAR(23), @t_jobDtm, 121) + ''' AS t_jobDtm
            ,	''' + @t_lastActionCd + ''' AS t_lastActionCd
            ,	''' + @t_jobBy + ''' AS t_jobBy
            FROM 
                [' + @SourceSchema + '].[' + @SourceView + ']';
        EXECUTE sp_executesql @insert_script;
    END
END