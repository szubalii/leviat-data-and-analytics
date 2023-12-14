CREATE FUNCTION [edw].[svf_getSalesDocItem](
    @SalesDocumentID NVARCHAR(10),
    @SalesDocumentItemID CHAR(6),
    @SubsequentDocumentItem CHAR(6),
    @PrecedingDocumentItem CHAR(6)
)
RETURNS CHAR(6)
AS
BEGIN
    DECLARE @SalesDocItem AS CHAR(6)
    SET @SalesDocItem =
        CASE 
            WHEN @SalesDocumentID LIKE '001%' THEN COALESCE(@SubsequentDocumentItem COLLATE DATABASE_DEFAULT,@SalesDocumentItemID)  -- 001 = Quotation
            WHEN @SalesDocumentID LIKE '008%' THEN COALESCE(@PrecedingDocumentItem COLLATE DATABASE_DEFAULT,@SalesDocumentItemID)   -- 008 = Delivery
            ELSE @SalesDocumentItemID
        END

    RETURN @SalesDocItem
END;    