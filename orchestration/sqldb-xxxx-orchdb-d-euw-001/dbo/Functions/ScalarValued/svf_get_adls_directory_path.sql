-- Write your own SQL object definition here, and it'll be included in your package.
/*
  When provided with the following parameter values:
    'FACT/C_BillingDocumentItemBasixDEX/Theobald/ODP/Full',
    'In',
    '2023-07-20 12:00:00'
  This results in the following output: 'FACT/C_BillingDocumentItemBasixDEX/Theobald/ODP/Full/In/2023/07/20'
*/
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
