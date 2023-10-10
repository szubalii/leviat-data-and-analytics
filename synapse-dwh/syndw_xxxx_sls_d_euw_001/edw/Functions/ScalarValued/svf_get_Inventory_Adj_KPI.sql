CREATE FUNCTION [edw].[svf_getInventory_Adj_KPI](
    @BusinessTransactionTypeID         nvarchar(8),
    @TransactionTypeDeterminationID    nvarchar(6),
    @AmountInCompanyCodeCurrency       decimal(23, 2)
)
RETURNS  DECIMAL(23, 2)
AS
BEGIN
    DECLARE @AmountInLocalCurrency AS DECIMAL(23, 2)
    SET @AmountInLocalCurrency =
            CASE  
                WHEN @BusinessTransactionTypeID  LIKE 'RMBL' 
                 AND @TransactionTypeDeterminationID LIKE 'UMB'
                THEN @AmountInCompanyCodeCurrency
                ELSE 0 
            END 

    RETURN @AmountInLocalCurrency
END;