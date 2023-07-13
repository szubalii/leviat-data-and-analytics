CREATE FUNCTION [edw].[svf_get4PartNaturalKey](
    @Doc NVARCHAR(40),
    @DocItem NVARCHAR(7),
    @CurrencyTypeID CHAR(2),
    @RN NVARCHAR(20)
)
RETURNS NVARCHAR(72)
AS
BEGIN
    DECLARE @Key AS NVARCHAR(72)
    SET @Key =
    CONCAT_WS(
        '¦'
    ,   @Doc 
    ,   trim(@DocItem) 
    ,   @CurrencyTypeID
    ,   @RN
        ) 
        
    RETURN @Key
END;