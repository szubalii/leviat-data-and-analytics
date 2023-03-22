CREATE PROC [utilities].[sp_copy_to_archive]
    @schema_src      VARCHAR  (100)   
,   @schema_dst      VARCHAR  (100)   
,   @table_src       VARCHAR  (100)
,   @table_dst       VARCHAR  (100)
,   @date_field_name VARCHAR  (100)
,   @reload_period_in_months INT
,   @refresh_from_date DATE
AS
/*      Procedure for pumping of data from Span loaded table to archive table
    @schema_src     -   schema of source table
    @schema_dst     -   schema of destination table
    @table_src      -   name of source table
    @table_dst      -   name of destination table
    @date_field_name -  name of data field in tables
    @reload_period_in_months  -   reload (reload_period)-th month before current
    @refresh_from_date     -   load 1 month starting from that date, leave it blank if you want to use @reload_period
*/
BEGIN

    DECLARE @load_from  DATE
    DECLARE @load_to    DATE
    DECLARE @delete_script NVARCHAR(MAX)
    DECLARE @insert_script NVARCHAR(MAX)
    DECLARE @current_date DATE = GETDATE()
    
    IF (@refresh_from_date IS NULL)
        SET  @load_from = DATEADD(
            MONTH
            ,-1 * @reload_period_in_months
            ,DATEFROMPARTS(
                YEAR(@current_date)
                ,MONTH(@current_date)
                ,1
            )
        )
    ELSE
        SET @load_from = @refresh_from_date
    
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