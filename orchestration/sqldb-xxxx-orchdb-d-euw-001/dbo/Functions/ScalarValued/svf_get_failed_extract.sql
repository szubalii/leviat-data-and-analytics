/*
  Function checks for failed or uncompleted extractions
*/
CREATE FUNCTION [dbo].[svf_get_failed_extract](
  @entity_id INTEGER
)
RETURNS TINYINT
AS
BEGIN
  DECLARE @failed_extract AS TINYINT = 0;

  SELECT 
    @failed_extract = COALESCE(MIN(
      CASE 
        WHEN status_id = 2
          THEN 0
        ELSE
          1
      END
     ),0)
    FROM
      dbo.batch
  WHERE
    activity_id = 21
    AND entity_id= @entity_id;

  RETURN @failed_extract
END;
