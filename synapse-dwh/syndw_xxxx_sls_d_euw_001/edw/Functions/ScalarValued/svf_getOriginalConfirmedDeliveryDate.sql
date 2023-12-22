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
    DECLARE @OrigDeliveryDate AS DATE;
    SET @OrigDeliveryDate =
        CASE
            WHEN @ActualDeliveryQuantity <> @SDI_ConfdDelivQtyInOrderQtyUnit
                THEN @MinOriginalConfirmedDeliveryDate
            ELSE COALESCE(@OriginalConfirmedDeliveryDate,@ConfirmedDeliveryDate)
        END
    RETURN @OrigDeliveryDate
END;