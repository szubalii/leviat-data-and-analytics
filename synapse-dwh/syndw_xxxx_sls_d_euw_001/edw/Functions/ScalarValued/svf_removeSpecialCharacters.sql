CREATE FUNCTION [edw].[svf_removeSpecialCharacters](
    @inputString NVARCHAR(255),
    @listOfSpecialChars NVARCHAR(33)
)
RETURNS NVARCHAR(255)
AS
BEGIN
DECLARE @outputString NVARCHAR(255)
    SET @outputString =
    CASE
        WHEN PATINDEX('%''%',@listOfSpecialChars)>0
        THEN
            REPLACE(TRANSLATE(@outputString,@listOfSpecialChars,REPLICATE(' ',LEN(@listOfSpecialChars)-1)),' ','')
        ELSE 
            REPLACE(TRANSLATE(@outputString,@listOfSpecialChars,REPLICATE(' ',LEN(@listOfSpecialChars))),' ','')
    END
    RETURN @outputString
END;