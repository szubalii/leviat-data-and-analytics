-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[svf_get_triggerDate](
  @file_name NVARCHAR (1024)
)
RETURNS DATE
AS
BEGIN
  DECLARE @date_string AS CHAR(23) = LEFT(RIGHT(@file_name, 31), 23);
  DECLARE @trigger_date AS DATE = DATEFROMPARTS(
    LEFT(@date_string, 4),
    SUBSTRING(@date_string, 6, 2),
    SUBSTRING(@date_string, 9, 2)
  );

  RETURN @trigger_date
END;
