-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[svf_get_adls_directory_path](
  @base_dir_path VARCHAR (150),
  @in_out VARCHAR (3),
  @date DATETIME
)
RETURNS VARCHAR(170)
AS
BEGIN
  DECLARE @adls_directory_path AS VARCHAR(170) =
    @base_dir_path +
    '/' + @in_out + '/' +
    FORMAT(@date, 'yyyy/MM/dd', 'en-US');

  RETURN @adls_directory_path
END;
