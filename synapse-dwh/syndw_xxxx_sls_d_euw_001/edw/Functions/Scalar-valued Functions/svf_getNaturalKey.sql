CREATE FUNCTION [edw].[svf_getNaturalKey](
    @Doc NVARCHAR(40),
    @DocItem NVARCHAR(7),
    @CurrencyTypeID CHAR(2)
)
RETURNS NVARCHAR(51)
AS
BEGIN
    DECLARE @Key AS NVARCHAR(51)
    SET @Key =
    CONCAT_WS(
        '¦'
    ,   @Doc 
    ,   @DocItem 
    ,   @CurrencyTypeID
        ) 

    RETURN @Key
END;