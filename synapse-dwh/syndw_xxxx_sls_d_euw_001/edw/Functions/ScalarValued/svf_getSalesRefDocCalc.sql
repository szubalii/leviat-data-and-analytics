CREATE FUNCTION [edw].[svf_getSalesRefDocCalc](
    @SalesDocumentID NVARCHAR(10),
    @ReferenceDocumentTypeID NVARCHAR(10),
    @PurchasingDocument NVARCHAR(20),
    @ICSalesDocumentID NVARCHAR(10),
    @SalesRefDocCalc NVARCHAR(10)
)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @SalesReferenceDocumentCalculated AS NVARCHAR(10)
    SET @SalesReferenceDocumentCalculated =
        CASE 
            WHEN @SalesDocumentID = '' 
                  AND @ReferenceDocumentTypeID LIKE 'VBRK' 
                  AND @PurchasingDocument <> ''  COLLATE DATABASE_DEFAULT
            THEN @ICSalesDocumentID
            ELSE @SalesRefDocCalc
        END

    RETURN @SalesReferenceDocumentCalculated
END;