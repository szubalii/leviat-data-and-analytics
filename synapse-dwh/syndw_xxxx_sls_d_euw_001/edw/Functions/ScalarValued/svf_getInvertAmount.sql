CREATE FUNCTION [edw].[svf_getInvertAmount](
  @SalesDocumentType NVARCHAR(4),
  @Amount DECIMAL(15, 2)
)
RETURNS DECIMAL(15, 2)
AS
BEGIN
DECLARE @InvertAmount DECIMAL(15, 2) =
  case
    when @SalesDocumentType = 'ZCR'
    then @Amount *(-1)
    else @Amount
  end;

  RETURN @InvertAmount
END;
