CREATE FUNCTION [edw].[svf_getOriginalConfirmedDeliveryDate](
  @ActualDeliveryQuantity decimal(13,3),
  @SDI_ConfdDelivQtyInOrderQtyUnit decimal(15,3),
  @OriginalConfirmedDeliveryDate DATE,
  @MinOriginalConfirmedDeliveryDate DATE,
  @ConfirmedDeliveryDate DATE
)
RETURNS DATE
AS
BEGIN
  DECLARE @helper AS DATE;

  -- If the actual delivery quantity is not equal to the confirmed delivery quantity from the sales order
  -- this means the sales order item is split into multiple schedule lines. In that case, don't get the original
  -- confirmed delivery date from its related schedule line, but the earliest confirmed date on the sales 
  -- order item level
  IF @ActualDeliveryQuantity <> @SDI_ConfdDelivQtyInOrderQtyUnit
    SET @helper = @MinOriginalConfirmedDeliveryDate;
  ELSE
    SET @helper = @OriginalConfirmedDeliveryDate;

  RETURN COALESCE(@helper, @ConfirmedDeliveryDate)
END;