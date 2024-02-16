CREATE FUNCTION [dbo].[tvf_scheduled_entities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS @schedule_entities_table TABLE
(
  [entity_id] BIGINT NOT NULL
)
AS
BEGIN

  IF @date IS NULL
    SET @date = GETDATE();

  DECLARE @day_of_month INT = DAY(@date);
  DECLARE @day_of_week INT = DATEPART(dw, @date);

  INSERT INTO @schedule_entities_table
  SELECT
    entity_id
  FROM
    [dbo].[entity] e
  WHERE (
    -- Daily load is only executed on workdays.

    -- Account for situations where entities need to run at beginning or end of the month
    -- and these days are in the weekend.
    e.[schedule_recurrence] = 'D'
    OR
    (
      e.[schedule_recurrence] = 'A'
      AND
      @adhoc = 1
    )
    OR (
      e.[schedule_recurrence] = 'W'
      AND
      e.[schedule_day] = @day_of_week
    )
    OR (
      e.[schedule_recurrence] = 'M'
      AND (
        e.[schedule_day] = @day_of_month
        -- Beginning of month (schedule_day = 1) and
        -- first day of month falls in weekend
        OR (
          e.[schedule_day] = 1
          AND
          @day_of_month IN (2, 3)
          AND
          @day_of_week = 2 --Monday
        )
        -- End of month (schedule_day = 0) and
        -- last day of month falls in weekend
        OR (
          e.[schedule_day] = 0
          AND (
            @day_of_month = DAY(EOMONTH(@date))
            OR (
              @day_of_week = 2 --Monday
              AND
              @day_of_month IN (1, 2)
            )
            OR (
              @day_of_week = 6 --Friday
              AND
              -- last day of month falls in weekend
              DATEPART(dw, (EOMONTH(@date))) IN (1, 7)
            )
          )
        )
      )
    )
  )

  RETURN;
END