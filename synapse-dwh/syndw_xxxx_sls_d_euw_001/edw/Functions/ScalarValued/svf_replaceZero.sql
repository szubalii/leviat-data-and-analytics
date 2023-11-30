CREATE FUNCTION [edw].[svf_replaceZero](
    @firstValue     decimal
    ,@secondValue   decimal
)
RETURNS decimal
AS
BEGIN
    IF @firstValue <> 0 THEN
        RETURN @firstValue
    ELSE
        RETURN @secondValue;
END;