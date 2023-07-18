CREATE FUNCTION [edw].[svf_getBooleanIndicator](
    @Input NVARCHAR(3)
)
RETURNS NVARCHAR(3)
AS
BEGIN
    DECLARE @Indicator AS NVARCHAR(3)
    SET @Indicator =
        CASE 
            WHEN  @Input = 'X' THEN 'Yes' ELSE 'No'
        END 

    RETURN @Indicator
END;