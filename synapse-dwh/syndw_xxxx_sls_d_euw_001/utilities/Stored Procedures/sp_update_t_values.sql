/*
    Update technical field values depending if its corresponding parameter value is provided
*/
CREATE PROC [utilities].[sp_update_t_values]
    @schema          		VARCHAR  (100)   
,   @table           		VARCHAR  (100)
,	@application_id  		VARCHAR   (32)
,   @job_id          		VARCHAR   (36)
,   @job_dtm         		VARCHAR   (28)
,   @job_by         	   NVARCHAR  (128)
,	@extraction_dtm_string	VARCHAR   (23)
,	@file_path			   NVARCHAR (1024)
AS
BEGIN
    -- @extraction_dtm_string is provided with format: yyyy_MM_dd_hh_mm_ss_fff
    DECLARE @extraction_dtm_parts NVARCHAR (23) = REPLACE(@extraction_dtm_string,'_',',');
    DECLARE @update_t_values_script NVARCHAR(MAX) = '';
    DECLARE @isAtLeast1Update BIT = 0;
    
    /*
        Check for each tech field if a parameter value is provided.
        If so, extend the script to update the value.
    */
    IF @application_id IS NOT NULL
        BEGIN
            SET @update_t_values_script += ',t_applicationId = '''+@application_id+'''';
            SET @isAtLeast1Update = 1;
        END;
    IF @job_id IS NOT NULL
        BEGIN
            SET @update_t_values_script += ',t_jobId = '''+@job_id+'''';
            SET @isAtLeast1Update = 1;
        END;
    IF @job_dtm IS NOT NULL
        BEGIN
            SET @update_t_values_script += ',t_jobDtm = '''+@job_dtm+'''';
            SET @isAtLeast1Update = 1;
        END;
    IF @job_by IS NOT NULL
        BEGIN
            SET @update_t_values_script += ',t_jobBy = '''+@job_by+'''';
            SET @isAtLeast1Update = 1;
        END;
    IF @extraction_dtm_string IS NOT NULL
        BEGIN
            SET @update_t_values_script += ',t_extractionDtm = DATETIMEFROMPARTS('+@extraction_dtm_parts+')';
            SET @isAtLeast1Update = 1;
        END;
    IF @file_path IS NOT NULL
        BEGIN
            SET @update_t_values_script += ',t_filePath = '''+@file_path+'''';
            SET @isAtLeast1Update = 1;
        END;
        
    IF @isAtLeast1Update = 1    
        BEGIN
            SET @update_t_values_script = 
                'UPDATE ['+@schema+'].['+@table+'] SET '
            +   SUBSTRING(@update_t_values_script, 2, LEN(@update_t_values_script));
            EXEC sp_executesql @update_t_values_script;
        END;
END;