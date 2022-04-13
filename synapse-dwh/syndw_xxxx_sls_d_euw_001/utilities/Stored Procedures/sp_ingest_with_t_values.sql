CREATE PROC [utilities].[sp_ingest_with_t_values]
    @schema          VARCHAR  (100)   
,   @table           VARCHAR  (100)
,   @application_id  VARCHAR   (32)
,   @job_id          VARCHAR   (36)
,   @last_dtm       DATETIME
,   @last_action_by  VARCHAR  (128)
,   @file_path      NVARCHAR (1024)
AS
BEGIN

    DECLARE @insert_to_base_script NVARCHAR(MAX) = CONCAT(

        'INSERT INTO [',@schema,'].[',@table,']
         SELECT
            *
        ,   [t_applicationId] = ''',@application_id,'''
        ,   [t_jobId]         = ''',@job_id,'''
        ,   [t_lastDtm]       = ''',@last_dtm,'''
        ,   [t_lastActionBy]  = ''',@last_action_by,'''
        ,   [t_filePath]      = ''',@file_path,'''
         FROM [',@schema,'].[',@table,'_staging]'
    );
    
    EXECUTE sp_executesql @insert_to_base_script

    --TODO truncate if successful

END