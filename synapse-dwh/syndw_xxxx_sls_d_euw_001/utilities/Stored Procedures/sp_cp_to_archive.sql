CREATE PROCEDURE [utilities].[sp_cp_to_archive]
    @schema_src      VARCHAR  (100)   
,   @schema_dst      VARCHAR  (100)   
,   @table_src       VARCHAR  (100)
,   @table_dst       VARCHAR  (100)
,   @date_field_name VARCHAR  (100)
,   @reload_period   INT
AS
BEGIN

    DECLARE @load_from  date
    DECLARE @load_to    date
    DECLARE @delete_script NVARCHAR(MAX)
    DECLARE @insert_script NVARCHAR(MAX)
    
    SET  @load_from = DATEADD(
        DAY
        ,-1 * DATEPART(DAY, GETDATE()) + 1
        ,DATEADD(
            MONTH
            , -1 * @reload_period
            , GETDATE()
        )
    )
    
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