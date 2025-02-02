﻿CREATE FUNCTION [edw].[svf_getOT_DaysDiff](
--function calculates the number of working days between two dates
    @DeliveryDate DATE,
    @CalculatedDate DATE,
    @Current_date DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @OT_DaysDiff AS INT
    SET @OT_DaysDiff =

        CASE
            WHEN
                (@DeliveryDate IS NULL
                OR
                @DeliveryDate = '0001-01-01')
            THEN NULL
            WHEN
                (@CalculatedDate IS NULL 
                OR
                @CalculatedDate = '0001-01-01')
            THEN NULL
            ELSE
                (DATEDIFF(day, @DeliveryDate, @CalculatedDate)) -- count of all days diff
                 -(DATEDIFF(week, @DeliveryDate, @CalculatedDate) * 2) -- count of weekends
        END

    RETURN @OT_DaysDiff
END;