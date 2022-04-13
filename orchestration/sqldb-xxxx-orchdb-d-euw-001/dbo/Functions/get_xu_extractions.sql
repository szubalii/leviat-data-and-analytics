CREATE FUNCTION [dbo].[get_xu_extractions] (@adhoc bit = 0, @manual_run bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT
    ent.[entity_id],
    ent.[extraction_name],
    ent.[base_directory_path] + '/In/' + FORMAT( @date, 'yyyy/MM/dd', 'en-US' ) AS base_directory_path
FROM
   [dbo].[get_s4h_entities] (@adhoc, @date) ent
WHERE
    (
        @manual_run = 1
        OR 
        (
            @manual_run = 0
            AND 
            (
                (
                    -- get extractions that were not executed today			
                    CAST(ent.[last_run_date] AS date) < @date
					OR
					ent.[last_run_date] IS NULL
                )
                    -- get extractions that were executed today, but were not Succeeded
                OR 
                (
                    CAST(ent.[last_run_date] AS date) = @date
                    AND 
                    ent.[last_run_status] = 'Failed'
                    AND 
                    ent.[last_run_activity] IN (
                        'StartXUExtraction',
                        'CheckXUExtractionStatus',
                        'LogsXUExtraction',
                        'XUExtractionLogsToBlobStorage',
                        'S4HToBlobIn'
                    )
                ) 
                    -- filter out extractions that were Succeeded in XUExctraction today
                OR 
                (
                    CAST(ent.[last_run_date] AS date) = @date
                    AND 
                    ent.[last_run_activity] NOT IN (
                        'S4HCheckFileName',
                        'S4HBlobInToBlobOut',
                        'InBaseLayer'
                    )
                    AND 
                    ent.[last_run_status] <> 'Succeeded'
                )
            )
        )
    )