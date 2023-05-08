CREATE FUNCTION [edw].[svf_getInOutID_axbi](
    @INOUT NVARCHAR(6)
)
RETURNS NVARCHAR(6)
AS
BEGIN
    DECLARE @InOutID AS NVARCHAR(6)
    SET @InOutID =
               case 
                    when @INOUT = 'I' then 'IC_Lev'
                    when @INOUT = 'O' then 'OC' 
                    else @INOUT 
                end 

    RETURN @InOutID
END;