CREATE FUNCTION [edw].[svf_removeSpecialCharacters](
    @inputString NVARCHAR(255)
)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @outputString NVARCHAR(255)
    SET @outputString =
        REPLACE(TRANSLATE(@inputString,'!"#$&''()*+,-./:;<=>?@[\]^`{|}~%“',REPLICATE(' ',LEN('!"#$&''()*+,-./:;<=>?@[\]^`{|}~%“'))),' ','')
    RETURN @outputString
END;