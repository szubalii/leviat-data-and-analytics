/*
  Returns if an activity needs to rerun based on if the provided activity
  is later than the first failed activity or there is no failed activity
  1 means it is required
  0 means it is not required
*/
CREATE FUNCTION [dbo].[svf_get_isRequired_full_batch_activity](
  @file_name NVARCHAR(1024),
  @activity_order SMALLINT,
  @firstFailedActivityOrder SMALLINT,
  @rerunSuccessfulFullEntities BIT
)
RETURNS TINYINT
AS
BEGIN
  DECLARE @isRequired AS TINYINT =
    CASE
      WHEN @rerunSuccessfulFullEntities = 1
      THEN 1
      WHEN @file_name IS NULL -- In case file_name is NULL, run the activity for first time
      THEN 1
      WHEN @activity_order < @firstFailedActivityOrder OR @firstFailedActivityOrder IS NULL
      THEN 0
      ELSE 1
    END;

  RETURN @isRequired
END;
