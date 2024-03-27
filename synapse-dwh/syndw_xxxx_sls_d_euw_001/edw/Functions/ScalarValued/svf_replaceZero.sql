CREATE FUNCTION [edw].[svf_replaceZero](
  @firstValue   DECIMAL(15,2)
  ,@secondValue DECIMAL(15,2)
)
RETURNS DECIMAL
-- that function receives 2 args
-- if first arg not equal zero it returns first arg
-- otherwise it returns second arg
AS
BEGIN
  DECLARE @output DECIMAL(15,2);
  IF CONVERT(INT, @firstValue) <> 0
    SET @output = @firstValue
  ELSE
    SET @output = @secondValue;
  RETURN @output;
END;