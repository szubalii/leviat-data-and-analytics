CREATE FUNCTION [edw].[svf_getOrderStatus](
    @BillingDocumentItem CHAR(7),
    @SalesDocumentTypeID NVARCHAR(4),
    @ItemOrderStatus NVARCHAR(32)
)
RETURNS NVARCHAR(32)
AS
BEGIN
DECLARE @Status NVARCHAR(32)
    SET @Status =
  CASE 
    WHEN @SalesDocumentTypeID IN ('ZDI','ZCR','ZDR','ZRK','ZCR2','ZCI') THEN
      CASE
        WHEN @BillingDocumentItem IS NOT NULL THEN 'Closed_Adjustment'
        WHEN @BillingDocumentItem IS NULL THEN 'Open_Adjustment'
      END
    ELSE @ItemOrderStatus
  END
            
    RETURN @Status
END;