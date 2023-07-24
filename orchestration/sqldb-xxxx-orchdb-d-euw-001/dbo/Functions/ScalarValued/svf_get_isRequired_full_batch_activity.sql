/*
  Returns if an activity needs to rerun based on if the provided activity
  is later than the first failed activity or there is no failed activity
*/
CREATE FUNCTION [dbo].[svf_get_isRequired_full_batch_activity](
  @activity_order SMALLINT,
  @firstFailedActivityOrder SMALLINT
)
RETURNS TINYINT
AS
BEGIN
  DECLARE @isRequired AS TINYINT =
    CASE
      WHEN @activity_order < @firstFailedActivityOrder OR @firstFailedActivityOrder IS NULL
      THEN 0
      ELSE 1
    END;

  RETURN @isRequired
END;
