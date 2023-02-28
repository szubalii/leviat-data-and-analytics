CREATE PROC [utilities].[sp_load2archive]
    @base_schema_name       VARCHAR  (100)   
,   @base_table_name        VARCHAR  (100)   
,   @entity_id              VARCHAR  (100)
,   @run_id                 VARCHAR  (100)
,   @refresh_from_date      DATE
,   @source_field_name      VARCHAR  (100)
AS
BEGIN
    DECLARE @table_dst VARCHAR(100) = CONCAT (@base_table_name, '_Archive')
    DECLARE @day_of_month INT = DAY(GETDATE())
    DECLARE @day_of_week INT = DATEPART(dw, GETDATE());
    IF 
        @day_of_month = 1
        -- Beginning of month (schedule_day = 1) and
        -- first day of month falls in weekend
        OR (
            @day_of_month IN (2, 3)
            AND
            @day_of_week = 2 --Monday
        )
    BEGIN
        EXECUTE utilities.sp_cp_to_archive @base_schema_name
            , @base_schema_name
            , @base_table_name
            , @table_dst
            , @source_field_name
            , ''
            , @refresh_from_date
    END
END