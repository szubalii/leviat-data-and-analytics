CREATE FUNCTION [edw].[svf_get5PartNaturalKey](
    @part1 NVARCHAR(40),
    @part2 NVARCHAR(4),
    @part3 NVARCHAR(10),
    @part4 CHAR(4),
    @part5 CHAR(2)
)
RETURNS NVARCHAR(64)
AS
BEGIN
    DECLARE @Key AS NVARCHAR(64)
    SET @Key =
    CONCAT_WS(
        '¦'
    ,   @part1
    ,   @part2
    ,   @part3
    ,   @part4
    ,   @part5
        ) 

    RETURN @Key
END;