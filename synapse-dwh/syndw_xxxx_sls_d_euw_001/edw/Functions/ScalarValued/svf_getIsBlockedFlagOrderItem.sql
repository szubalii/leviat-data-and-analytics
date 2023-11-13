CREATE FUNCTION [edw].[svf_getIsBlockedFlagOrderItem](
    @DeliveryBlockReasonID NVARCHAR(2),
    @BillingBlockStatusID NVARCHAR(1),
    @HeaderBillingBlockReasonID NVARCHAR(2),
    @ItemBillingBlockReasonID NVARCHAR(2),
    @HDR_DeliveryBlockReason NVARCHAR(2)
)
RETURNS INT
AS
BEGIN
DECLARE @Flag INT
    SET @Flag =
  CASE 
        WHEN
            (@DeliveryBlockReasonID IS NOT NULL AND @DeliveryBlockReasonID <> '') 
            OR
            (@BillingBlockStatusID IS NOT NULL AND @BillingBlockStatusID <> '') 
            OR
            (@HeaderBillingBlockReasonID IS NOT NULL AND @HeaderBillingBlockReasonID <> '') 
            OR
            (@ItemBillingBlockReasonID IS NOT NULL AND @ItemBillingBlockReasonID <> '') 
            OR
            (@HDR_DeliveryBlockReason IS NOT NULL AND @HDR_DeliveryBlockReason <> '')
        THEN 1
        ELSE 0
  END
            
    RETURN @Flag
END;