CREATE PROC [utilities].[sp_process_ingestion]
    @client_field    VARCHAR  (100) 
,   @client_value       CHAR    (3)
,   @extraction_type VARCHAR  (100) 
,   @schema          VARCHAR  (100)   
,   @table           VARCHAR  (100)
,   @application_id  VARCHAR   (32)
,   @job_id          VARCHAR   (36)
,   @last_dtm        VARCHAR   (28)
,   @last_action_by  VARCHAR  (128)
,   @file_path      NVARCHAR (1024)
AS
BEGIN

    -- Check if the Client Field (MANDT) needs to be added
    DECLARE @client NVARCHAR(MAX);
    
    IF 
        NOT( @client_field IS NULL )
        AND
        @extraction_type = 'ODP'

        SET @client = CONCAT(
            ',',@client_field,' = ''',@client_value,''''
        );

    DECLARE @insert_to_base_script NVARCHAR(MAX) = CONCAT(

        'INSERT INTO [',@schema,'].[',@table,']
         SELECT
            *'
        ,   @client,'
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