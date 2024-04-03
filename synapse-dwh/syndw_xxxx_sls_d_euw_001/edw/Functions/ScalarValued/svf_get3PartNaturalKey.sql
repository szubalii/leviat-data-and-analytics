CREATE FUNCTION [edw].[svf_get3PartNaturalKey](
    @part1 NVARCHAR(100),
    @part2 NVARCHAR(100),
    @part3 NVARCHAR(100)
)
RETURNS NVARCHAR(302)
AS
BEGIN
    DECLARE @Key AS NVARCHAR(302)
    SET @Key =
    CONCAT_WS(
        '¦'
    ,   @part1
    ,   @part2
    ,   @part3
        ) 

    RETURN @Key
END;