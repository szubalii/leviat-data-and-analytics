-- Write your own SQL object definition here, and it'll be included in your package.

CREATE FUNCTION [utilities].[svf_get_file_path](
    @adls_container_name NVARCHAR(63),
    @adls_directory_name NVARCHAR(1024),
    @adls_file_name NVARCHAR(255)
)
RETURNS NVARCHAR(1024)
AS
BEGIN
    DECLARE @file_path NVARCHAR(1024);

    IF (@adls_directory_name <> '' AND @adls_directory_name IS NOT NULL)
        SET @adls_directory_name = '/' + @adls_directory_name;
    
    SET @file_path = @adls_container_name + @adls_directory_name + '/' + @adls_file_name;

    RETURN(@file_path);
END;
