CREATE FUNCTION [edw].[svf_removeSpecialCharacters](
    @inputString NVARCHAR(255),
    @listOfSpecialChars NVARCHAR(33)
)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @outputString NVARCHAR(255)
    SET @outputString =
        REPLACE(TRANSLATE(@inputString,@listOfSpecialChars,REPLICATE(' ',LEN(@listOfSpecialChars))),' ','')
    RETURN @outputString
END;