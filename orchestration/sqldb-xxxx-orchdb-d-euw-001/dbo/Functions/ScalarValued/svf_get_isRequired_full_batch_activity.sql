-- Write your own SQL object definition here, and it'll be included in your package.
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
