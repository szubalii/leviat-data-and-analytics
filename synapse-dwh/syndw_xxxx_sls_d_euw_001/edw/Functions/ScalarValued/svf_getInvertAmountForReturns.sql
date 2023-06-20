CREATE FUNCTION [edw].[svf_getInvertAmountForReturns](
  @ReturnItemProcessingType NVARCHAR(1),
  @BillingDocumentType NVARCHAR(4),
  @SalesDocumentItemCategory NVARCHAR(4),
  @Amount DECIMAL(15, 2)
)
RETURNS DECIMAL(15, 2)
AS
BEGIN
DECLARE @InvertAmount DECIMAL(15, 2) =
  CASE
    WHEN
      @ReturnItemProcessingType = 'X'
      OR                
      (
          @BillingDocumentType = 'ZG2'
        AND
        @SalesDocumentItemCategory = 'ZL2N'
      )
    THEN @Amount *(-1)
    ELSE @Amount
  END;

  RETURN @InvertAmount
END;
