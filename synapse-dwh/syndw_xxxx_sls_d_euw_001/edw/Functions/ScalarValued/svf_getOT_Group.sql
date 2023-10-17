CREATE FUNCTION [edw].[svf_getOT_Group](
    @OT_DaysDiff INT
)
RETURNS NVARCHAR(6)
AS
BEGIN
    DECLARE @OT_GroupValue AS NVARCHAR(6)
    SET @OT_GroupValue =
        CASE
            WHEN @OT_DaysDiff IS NULL
            THEN NULL
            WHEN @OT_DaysDiff = 0
            THEN 'OnTime'
            WHEN @OT_DaysDiff < 0
            THEN 'Early'
            WHEN @OT_DaysDiff > 0
            THEN 'Late'
        END

    RETURN @OT_GroupValue
END;