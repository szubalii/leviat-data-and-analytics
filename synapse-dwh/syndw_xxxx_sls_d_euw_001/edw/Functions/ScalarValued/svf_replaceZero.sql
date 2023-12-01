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
    IF @firstValue <> 0
        RETURN @firstValue
    ELSE
        RETURN @secondValue;
END;