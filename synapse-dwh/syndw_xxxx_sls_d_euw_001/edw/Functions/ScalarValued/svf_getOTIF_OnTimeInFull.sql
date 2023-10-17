CREATE FUNCTION [edw].[svf_getOTIF_OnTimeInFull](
    @OT_Group NVARCHAR(6),
    @OT_IsOnTime BIT,
    @IF_IsInFull BIT
)
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