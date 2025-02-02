/*
  Returns the triggered date for a file name with a format of:
  CRHCURRENCY_2023_01_09_09_24_00_481 results in 20230109
*/
CREATE FUNCTION [dbo].[svf_get_triggerDate](
  @file_name NVARCHAR (1024)
)
RETURNS DATE
AS
BEGIN
  DECLARE @i AS INT = PATINDEX('%[0-9][0-9][0-9][0-9]_[0-9][0-9]_[0-9][0-9]%', @file_name)
  -- added pattern match to support filenames with star
  DECLARE @date_string AS CHAR(23) = SUBSTRING(@file_name, @i, 23);
  DECLARE @trigger_date AS DATE = DATEFROMPARTS(
    LEFT(@date_string, 4),
    SUBSTRING(@date_string, 6, 2),
    SUBSTRING(@date_string, 9, 2)
  );

  RETURN @trigger_date
END;
