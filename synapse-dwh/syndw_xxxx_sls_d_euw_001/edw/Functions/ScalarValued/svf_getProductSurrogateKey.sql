CREATE FUNCTION [edw].[svf_getProductSurrogateKey](
    @ProductSurrogateKey NVARCHAR(117),
    @ProductID NVARCHAR(80),
    @SoldProduct NVARCHAR(40)
)
RETURNS NVARCHAR(117)
AS
BEGIN
DECLARE @Key AS NVARCHAR(117)
    SET @Key =
  COALESCE (@ProductSurrogateKey,
      CASE  
        WHEN @ProductID = '' AND @SoldProduct <>'' THEN @SoldProduct
        WHEN @ProductID <>'' THEN
          CASE 
            WHEN @SoldProduct <>'' THEN @SoldProduct
            ELSE @ProductID
          END
        ELSE @ProductID
      END
    ) 

    RETURN @Key
END;