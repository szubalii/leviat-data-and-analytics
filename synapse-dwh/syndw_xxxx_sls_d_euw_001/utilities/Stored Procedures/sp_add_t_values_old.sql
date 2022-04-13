CREATE PROC [utilities].[sp_add_t_values_old]
    @schema          VARCHAR  (100)   
,   @table           VARCHAR  (100)
,   @application_id  VARCHAR   (32)
,   @job_id          VARCHAR   (36)
,   @last_dtm       DATETIME
,   @last_action_by  VARCHAR  (128)
,   @file_path      NVARCHAR (1024)
AS
BEGIN

    DECLARE @update_script NVARCHAR(MAX) = CONCAT(
        'UPDATE [',@schema,'].[',@table,']
         SET [t_applicationId] = ''',@application_id,'''
    ,        [t_jobId]         = ''',@job_id,'''
    ,        [t_lastDtm]       =   ',@last_dtm,'
    ,        [t_lastActionBy]  = ''',@last_action_by,'''
    ,        [t_filePath]      = ''',@file_path,''
    );
    
    EXECUTE sp_executesql @update_script
END