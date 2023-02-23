CREATE PROC [utilities].[sp_cp_to_archive]
    @schema_src      VARCHAR  (100)   
,   @schema_dst      VARCHAR  (100)   
,   @table_src       VARCHAR  (100)
,   @table_dst       VARCHAR  (100)
,   @date_field_name VARCHAR  (100)
,   @reload_period   INT
,   @refresh_from_date VARCHAR(100)
AS
/*      Procedure for pumping of data from Span loaded table to archive table
    @schema_src     -   schema of source table
    @schema_dst     -   schema of destination table
    @table_src      -   name of source table
    @table_dst      -   name of destination table
    @date_field_name -  name of data field in tables
    @reload_period  -   reload (reload_period)-th month before current
    @refresh_from_date     -   load 1 month starting from that date, leave it blank if you want to use @reload_period
*/
BEGIN

    DECLARE @load_from  date
    DECLARE @load_to    date
    DECLARE @delete_script NVARCHAR(MAX)
    DECLARE @insert_script NVARCHAR(MAX)
    
    IF (COALESCE(@refresh_from_date,'') = '')
        SET  @load_from = DATEADD(
            DAY
            ,-1 * DATEPART(DAY, GETDATE()) + 1
            ,DATEADD(
                MONTH
                , -1 * @reload_period
                , GETDATE()
            )
        )
    ELSE
        SET @load_from = CAST( @refresh_from_date AS DATE)
    
    SET @load_to = DATEADD(
        MONTH
        , 1
        , @load_from
    )

    SET @delete_script = CONCAT (
        'DELETE [', @schema_dst, '].[', @table_dst, ']
        WHERE [', @date_field_name, '] >= ''', @load_from, '''
            AND [', @date_field_name, '] < ''', @load_to, ''''
    )
    EXECUTE sp_executesql @delete_script

    SET @insert_script = CONCAT(
        'INSERT INTO [', @schema_dst, '].[', @table_dst, ']
         SELECT * FROM [', @schema_src, '].[', @table_src, ']'
    );
    
    EXECUTE sp_executesql @insert_script
END