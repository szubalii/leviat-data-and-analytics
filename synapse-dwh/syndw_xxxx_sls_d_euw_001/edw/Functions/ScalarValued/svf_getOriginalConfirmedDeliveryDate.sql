CREATE FUNCTION [edw].[svf_getOriginalConfirmedDeliveryDate](
    @ActualDeliveryQuantity decimal(13,3),
    @SDI_ConfdDelivQtyInOrderQtyUnit decimal(15,3),
    @OriginalConfirmedDeliveryDate1 DATE,
    @OriginalConfirmedDeliveryDate2 DATE,
    @ConfirmedDeliveryDate DATE,
    @SalesDocumentID nvarchar(10),
    @SalesDocumentItemID nvarchar(6)
)
RETURNS DATE
AS
BEGIN
    DECLARE @OrigDeliveryDate AS DATE
    SET @OrigDeliveryDate =
        CASE
            WHEN @ActualDeliveryQuantity <> @SDI_ConfdDelivQtyInOrderQtyUnit
            THEN COALESCE(MIN(@OriginalConfirmedDeliveryDate1) OVER (Partition By @SalesDocumentID, @SalesDocumentItemID), @ConfirmedDeliveryDate)
            ELSE COALESCE(@OriginalConfirmedDeliveryDate2,@ConfirmedDeliveryDate)
        END
    RETURN @OrigDeliveryDate
END;