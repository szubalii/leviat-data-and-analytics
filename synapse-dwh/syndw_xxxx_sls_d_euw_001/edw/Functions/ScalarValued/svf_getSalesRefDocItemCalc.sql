CREATE FUNCTION [edw].[svf_getSalesRefDocItemCalc](
    @SalesDocumentID NVARCHAR(10),
    @ReferenceDocumentTypeID NVARCHAR(10),
    @PurchasingDocument NVARCHAR(20),
    @ICSalesDocumentItemID NVARCHAR(10),
    @SalesRefDocItemCalc NVARCHAR(10)
)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @SalesReferenceDocumentItemCalculated AS NVARCHAR(10)
    SET @SalesReferenceDocumentItemCalculated =
        CASE 
            WHEN @SalesDocumentID = '' 
                  AND @ReferenceDocumentTypeID LIKE 'VBRK' 
                  AND @PurchasingDocument <> ''
            THEN @ICSalesDocumentItemID
            ELSE @SalesRefDocItemCalc
        END

    RETURN @SalesReferenceDocumentItemCalculated
END;