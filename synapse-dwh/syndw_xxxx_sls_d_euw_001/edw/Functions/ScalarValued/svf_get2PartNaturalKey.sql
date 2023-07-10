CREATE FUNCTION [edw].[svf_get2PartNaturalKey](
    @part1 NVARCHAR(40),
    @part2 NVARCHAR(20)
)
RETURNS NVARCHAR(61)
AS
BEGIN
    DECLARE @Key AS NVARCHAR(61)
    SET @Key =
    CONCAT_WS(
        '¦'
    ,   @part1
    ,   @part2
        ) 

    RETURN @Key
END;