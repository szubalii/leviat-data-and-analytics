CREATE FUNCTION [edw].[svf_get2PartNaturalKey](
    @part1 NVARCHAR(20),
    @part2 NVARCHAR(20)
)
RETURNS NVARCHAR(41)
AS
BEGIN
    DECLARE @Key AS NVARCHAR(41)
    SET @Key =
    CONCAT_WS(
        '¦'
    ,   @part1
    ,   @part2
        ) 

    RETURN @Key
END;