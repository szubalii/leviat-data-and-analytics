-- Write your own SQL object definition here, and it'll be included in your package.
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
      WHEN @activity_order = 100 THEN 0
      -- All activities of files that are earlier
      -- than the first failed file can be skipped
      WHEN @file_name < @firstFailedFile OR @firstFailedFile IS NULL THEN 0
      -- In case of available delta files more recent
      -- than the delta file that had failed activities,
      -- rerun activities other than extraction
      WHEN @file_name > @firstFailedFile THEN 1
      -- For activities of the first failed file
      -- check the first failed activity
      ELSE dbo.svf_get_isRequired_full_batch_activity(
        @activity_order,
        @firstFailedActivityOrder,
        0
      )
    END;

  RETURN @isRequired
END;
