CREATE FUNCTION [edw].[svf_getConditionAmount](
    @CurrencyTypeID     CHAR(2) ,
    @ConditionAmount    DECIMAL(15,2),
    @ConditionAmountEUR DECIMAL(15,2),
    @ConditionAmountUSD DECIMAL(15,2)
)
RETURNS DECIMAL(15,2)  
AS
BEGIN
DECLARE @Amount AS DECIMAL(15,2)  
    SET @Amount =
        CASE 
            WHEN @CurrencyTypeID = '30' THEN @ConditionAmountEUR
            WHEN @CurrencyTypeID = '40' THEN @ConditionAmountUSD
            ELSE @ConditionAmount 
        END

    RETURN @Amount
END;