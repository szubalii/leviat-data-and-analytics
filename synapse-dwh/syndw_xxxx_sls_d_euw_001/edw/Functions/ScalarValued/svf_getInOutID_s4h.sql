CREATE FUNCTION [edw].[svf_getInOutID_s4h](
    @CustomerID NVARCHAR(6)
)
RETURNS NVARCHAR(6)
AS
BEGIN
    DECLARE @InOutID AS NVARCHAR(6)
    SET @InOutID =
            case when @CustomerID like 'IP%'             then 'IC_Lev'
                 when @CustomerID like 'IC__35%'         then 'IC_Lev'
                 when @CustomerID like 'IC__[^3]%'   then 'IC_CRH'
                 when @CustomerID not like 'IP%' 
                 and  @CustomerID not like 'IC%'         then 'OC'
                 else @CustomerID
             end 

    RETURN @InOutID
END;