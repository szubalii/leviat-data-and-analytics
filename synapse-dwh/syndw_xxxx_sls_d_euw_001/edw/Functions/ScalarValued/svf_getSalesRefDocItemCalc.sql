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
    SET @SalesReferenceDocumentCalculated =
        CASE 
            WHEN @SalesDocumentID = '' 
                  AND @ReferenceDocumentTypeID LIKE 'VBRK' 
                  AND @PurchasingDocument <> ''  COLLATE DATABASE_DEFAULT
            THEN @ICSalesDocumentItemID
            ELSE @SalesRefDocItemCalc
        END

    RETURN @SalesReferenceDocumentItemCalculated
END;