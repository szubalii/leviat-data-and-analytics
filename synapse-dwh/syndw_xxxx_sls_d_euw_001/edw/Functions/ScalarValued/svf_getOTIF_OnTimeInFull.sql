CREATE FUNCTION [edw].[svf_getOTIF_OnTimeInFull](
    @OT_Group NVARCHAR(6),
    @OT_IsOnTime BIT,
    @IF_IsInFull BIT
)
/*fucntion calculates the combination of Is Shipped in Full, and Is Shipped on time.
In full meaning that the quantity that was expected to be shipped is shipped,
and shipped on time means that the confirmed delivery date is the date on which is shipped.
Combining these two KPI's is a main indicator of Supply Chain Performance.
If not on time, and not in full = NOTNIF.
On time, and in full = OTIF.
Not on time, and not in full = NOTIF.
On time, and not in full = OTNIF.
*/ 
RETURNS NVARCHAR(6)
AS
BEGIN
    DECLARE @OTIF_OnTimeInFull AS NVARCHAR(6)
    SET @OTIF_OnTimeInFull =
        CASE
        WHEN @OT_Group IS NULL
        THEN NULL
        WHEN
            @OT_IsOnTime = 1
            AND
            @IF_IsInFull = 1
        THEN 'OTIF'
        WHEN
            @OT_IsOnTime = 1
            AND
            @IF_IsInFull = 0
        THEN 'OTNIF'
        WHEN
            @OT_IsOnTime = 0
            AND
            @IF_IsInFull = 1
        THEN 'NOTIF'
        WHEN
            @OT_IsOnTime = 0
            AND
            @IF_IsInFull = 0
        THEN 'NOTNIF'
    END

    RETURN @OTIF_OnTimeInFull
END;