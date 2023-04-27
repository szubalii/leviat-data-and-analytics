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
           case 
               when @BillingDocumentItem is not null  and @SalesDocumentTypeID in ('ZDI','ZCR','ZDR','ZRK','ZCR2','ZCI') then 'Closed_Adjustment' 
               when @BillingDocumentItem is null and @SalesDocumentTypeID in ('ZDI','ZCR','ZDR','ZRK','ZCR2','ZCI') then 'Open_Adjustment' 
               else @ItemOrderStatus 
            end 
            
    RETURN @Status
END;