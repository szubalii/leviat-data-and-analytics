CREATE FUNCTION [edw].[svf_getClassification](
    @Classif NVARCHAR(8),
    @ProductGroup NVARCHAR(9),
    @MaterialTypeID NVARCHAR(8)
)
RETURNS NVARCHAR(8)
AS
BEGIN
    DECLARE @Classification AS NVARCHAR(8)
    SET @Classification =
        CASE 
            WHEN (@Classif is null or @Classif= '') and (@ProductGroup is null or @ProductGroup = '') THEN 
                 CASE WHEN @MaterialTypeID in ('ZKMA', 'ZKMB', 'ZKMC') THEN 'Direct' ELSE 'Indirect' END
            ELSE @Classif
        END 

    RETURN @Classification
END;