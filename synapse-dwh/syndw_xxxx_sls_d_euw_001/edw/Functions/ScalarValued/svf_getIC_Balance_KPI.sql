CREATE FUNCTION [edw].[svf_getIC_Balance_KPI](
    @GLAccountID                  nvarchar(20),
    @PartnerCompanyID             nvarchar(12),
    @AmountInCompanyCodeCurrency  decimal(23, 2)
)
RETURNS  DECIMAL(23, 2)
AS
BEGIN
    DECLARE @AmountInLocalCurrency AS DECIMAL(23, 2)
    SET @AmountInLocalCurrency =
            CASE  
                WHEN @GLAccountID IN ('0015112100',
                                      '0015112105',
                                      '0015112110',
                                      '0015112199',
                                      '0018300100',
                                      '0021102100',
                                      '0021102101',
                                      '0021102110',
                                      '0021102111',
                                      '0021102198',
                                      '0021102199',
                                      '0021390121',
                                      '0026200100',
                                      '0035200100',
                                      '0035500100',
                                      '0035500101',
                                      '0035600100',
                                      '0035700100',
                                      '0035800100')
                 AND @PartnerCompanyID <> ''
                THEN @AmountInCompanyCodeCurrency
            END 

    RETURN @AmountInLocalCurrency
END;