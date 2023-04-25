CREATE FUNCTION [edw].[svf_getOrderStatus](
    @BillingDocumentItem CHAR(7),
    @Status_Open NVARCHAR(17),
    @Status_Closed NVARCHAR(17),
    @ItemOrderStatus NVARCHAR(32)
)
RETURNS NVARCHAR(17)
AS
BEGIN
DECLARE @Status NVARCHAR(17)
    SET @Status =
           case 
               when @BillingDocumentItem is not null then @Status_Closed 
               when @BillingDocumentItem is null then @Status_Open 
               else @ItemOrderStatus 
            end 
            
    RETURN @Status
END;