CREATE FUNCTION [edw].[svf_getSalesDoc](
    @SalesDocumentID NVARCHAR(10),
    @SubsequentDocument NVARCHAR(10),
    @PrecedingDocument NVARCHAR(10)
)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @SalesDoc AS NVARCHAR(10)
    SET @SalesDoc =
        CASE 
            WHEN @SalesDocumentID LIKE '001%' THEN COALESCE(@SubsequentDocument,@SalesDocumentID)
            WHEN @SalesDocumentID LIKE '008%' THEN COALESCE(@PrecedingDocument ,@SalesDocumentID)
            ELSE @SalesDocumentID
        END

    RETURN @SalesDoc
END;