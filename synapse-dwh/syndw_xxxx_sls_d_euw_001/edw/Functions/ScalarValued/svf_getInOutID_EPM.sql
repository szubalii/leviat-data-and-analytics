CREATE FUNCTION [edw].[svf_getInOutID_EPM](
    @CustomerID NVARCHAR(6),
    @ProfitCenterTypeID CHAR(1)
)
RETURNS NVARCHAR(6)
AS
BEGIN
    DECLARE @InOutID AS NVARCHAR(6)
    SET @InOutID =
            CASE WHEN @ProfitCenterTypeID = '3' AND @CustomerID LIKE '005%'  THEN 'IC_Lev'
                 WHEN @CustomerID LIKE 'IP%' OR @CustomerID LIKE 'IC__35%' THEN 'IC_Lev'
                 WHEN @CustomerID LIKE 'IC__[^3]%' THEN 'IC_CRH'
                 WHEN @CustomerID LIKE '005%' THEN 'OC'
                 WHEN @CustomerID IS NULL OR  @CustomerID = '' THEN
                    CASE WHEN @ProfitCenterTypeID = '2' THEN 'OC'
                         WHEN @ProfitCenterTypeID = '3' THEN 'IC_Lev'
                         ELSE 'MA'
                    END
                 ELSE 'MA'
             END 

    RETURN @InOutID
END;