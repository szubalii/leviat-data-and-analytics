-- Checks if a specific batch activity for a delta entity is required
-- 1 means it is required
-- 0 means it is not required
CREATE FUNCTION [dbo].[svf_get_isRequired_delta_batch_activity](
  @file_name VARCHAR (250),
  @firstFailedFile VARCHAR (250),
  @activity_order SMALLINT,
  @firstFailedActivityOrder SMALLINT
)
RETURNS TINYINT
AS
BEGIN
  DECLARE @isRequired AS TINYINT =
    CASE
      -- Don't rerun extraction for delta files
      WHEN @file_name IS NOT NULL AND @activity_order = 100 THEN 0
      -- All activities of files that are earlier
      -- than the first failed file can be skipped
      WHEN @file_name IS NOT NULL AND (@file_name < @firstFailedFile OR @firstFailedFile IS NULL) THEN 0
      -- In case of available delta files more recent
      -- than the delta file that had failed activities,
      -- rerun activities from ingestIntoBase onwards
      WHEN @file_name > @firstFailedFile AND @activity_order >= 500 THEN 1 -- TODO: extend logic to make sure that only the ingestIntoBase activity is redone if previous activities were successfull
      -- For activities of the first failed file
      -- check the first failed activity
      ELSE dbo.svf_get_isRequired_full_batch_activity(
        @file_name,
        @activity_order,
        @firstFailedActivityOrder,
        0
      )
    END;

  RETURN @isRequired
END;
