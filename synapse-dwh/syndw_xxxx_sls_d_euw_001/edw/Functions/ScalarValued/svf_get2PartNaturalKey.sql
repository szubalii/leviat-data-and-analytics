CREATE FUNCTION [edw].[svf_get2PartNaturalKey](
    @part1 NVARCHAR(100),
    @part2 NVARCHAR(20)
)
RETURNS NVARCHAR(121)
AS
BEGIN
    DECLARE @Key AS NVARCHAR(121)
    SET @Key =
    CONCAT_WS(
        '¦'
    ,   trim(@part1)
    ,   @part2
        ) 

    RETURN @Key
END;