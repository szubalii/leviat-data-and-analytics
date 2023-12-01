CREATE FUNCTION [edw].[svf_replaceZero](
    @firstValue     decimal
    ,@secondValue   decimal
)
RETURNS decimal
-- that function receives 2 args
-- if first arg not equal zero it returns first arg
-- otherwise it returns second arg
AS
BEGIN
    DECLARE @output decimal;
    IF @firstValue <> 0
        SET @output = @firstValue
    ELSE
        SET @output = @secondValue;
    RETURN @output;
END;