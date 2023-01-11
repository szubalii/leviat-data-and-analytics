-- Write your own SQL object definition here, and it'll be included in your package.

CREATE FUNCTION [utilities].[svf_getDateFromFileName](
    @file_name NVARCHAR(128)
)
RETURNS DATETIME
AS
BEGIN
    -- DECLARE 
    --     @file_name NVARCHAR(128) = 'T149T_2023_01_09_09_37_56_050.parquet';
    DECLARE
        @extraction_dtm DATETIME,
        @extraction_dtm_parts VARCHAR(23) = LEFT(RIGHT(@file_name, 31), 23);

    SET @extraction_dtm = DATETIMEFROMPARTS(
        CONVERT(INT, LEFT(@extraction_dtm_parts, 4)),
        CONVERT(INT, SUBSTRING(@extraction_dtm_parts, 6, 2)),
        CONVERT(INT, SUBSTRING(@extraction_dtm_parts, 9, 2)),
        CONVERT(INT, SUBSTRING(@extraction_dtm_parts, 12, 2)),
        CONVERT(INT, SUBSTRING(@extraction_dtm_parts, 15, 2)),
        CONVERT(INT, SUBSTRING(@extraction_dtm_parts, 18, 2)),
        CONVERT(INT, RIGHT(@extraction_dtm_parts, 3))
    );

    -- SELECT @extraction_dtm;

    RETURN(@extraction_dtm);
END;