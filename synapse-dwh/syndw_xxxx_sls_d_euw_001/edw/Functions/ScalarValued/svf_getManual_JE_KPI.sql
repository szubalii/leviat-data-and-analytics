CREATE FUNCTION [edw].[svf_getManual_JE_KPI](
    @AccountingDocumentTypeID     nvarchar(4),
    @BusinessTransactionTypeID    nvarchar(8),
    @ReferenceDocumentTypeID      nvarchar(10),
    @AmountInCompanyCodeCurrency  decimal(23, 2)
)
RETURNS  DECIMAL(23, 2)
AS
BEGIN
    DECLARE @AmountInLocalCurrency AS DECIMAL(23, 2)
    SET @AmountInLocalCurrency =
            CASE  
                WHEN @AccountingDocumentTypeID  IN ('SA','JR','AB') 
                 AND @BusinessTransactionTypeID IN ('RFBU','RFPT,''RFCL','AZUM','RFCV')
                 AND @ReferenceDocumentTypeID IN ('BKPFF','BKPF')
                THEN @AmountInCompanyCodeCurrency
                ELSE 0 
            END 

    RETURN @AmountInLocalCurrency
END;