CREATE FUNCTION [edw].[svf_getConditionAmount](
    @CurrencyType NVARCHAR(20),
    @ConditionAmount DECIMAL(15,2),
    @ConditionAmountEUR DECIMAL(15,2),
    @ConditionAmountUSD DECIMAL(15,2)
)
RETURNS DECIMAL(15,2)  
AS
BEGIN
DECLARE @Amount AS DECIMAL(15,2)  
    SET @Amount =
        CASE 
            WHEN @CurrencyType = 'Group Currency EUR' THEN @ConditionAmountEUR
            WHEN @CurrencyType = 'Group Currency USD' THEN @ConditionAmountUSD
            ELSE @ConditionAmount 
        END

    RETURN @Amount
END;