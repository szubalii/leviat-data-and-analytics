CREATE FUNCTION [edw].[svf_removeSpecialCharacters](
    @inputString NVARCHAR(255)
)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @specialChars CHAR(32) = '!"#$&''()*+,-./:;<=>?@[\]^`{|}~%“';
    DECLARE @outputString NVARCHAR(255)
    SET @outputString =
        REPLACE(TRANSLATE(@inputString,@specialChars,REPLICATE(' ',LEN(@specialChars))),' ','')
    RETURN @outputString
END;