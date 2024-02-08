-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[svf_get_isRequired_batch_activity](
  @update_mode VARCHAR(5),
  @file_name VARCHAR (250),
  @first_failed_file_name VARCHAR (250),
  @activity_order SMALLINT,
  @first_failed_activity_order SMALLINT,
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TINYINT
AS
BEGIN
  DECLARE @isRequired AS TINYINT =
    CASE
      WHEN @update_mode = 'Full' OR @update_mode IS NULL
      THEN
        CASE
          WHEN @rerunSuccessfulFullEntities = 1
          THEN 1
          ELSE dbo.svf_get_isRequired_full_batch_activity(
            @file_name,
            @activity_order,
            @first_failed_activity_order,
            @rerunSuccessfulFullEntities
          )
        END
      WHEN @update_mode = 'Delta'
      THEN dbo.svf_get_isRequired_delta_batch_activity(
        @file_name,
        @first_failed_file_name,
        @activity_order,
        @first_failed_activity_order
      )
    END;

  RETURN @isRequired
END;
