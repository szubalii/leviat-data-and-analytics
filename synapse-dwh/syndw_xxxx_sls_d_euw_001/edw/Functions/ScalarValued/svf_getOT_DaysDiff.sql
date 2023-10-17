CREATE FUNCTION [edw].[svf_getOT_DaysDiff](
    @DeliveryDate DATE,
    @CalculatedDate DATE,
    @Current_date DATETIME
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
                AND
                @DeliveryDate < CONVERT (DATE, @Current_date)
            THEN
                (DATEDIFF(day, @DeliveryDate, CONVERT (DATE, @Current_date))) -- count of all days diff
                 -(DATEDIFF(week, @DeliveryDate, CONVERT (DATE, @Current_date)) * 2) -- count of weekends
            WHEN @CalculatedDate = '0001-01-01'
			THEN NULL
            ELSE
                (DATEDIFF(day, @DeliveryDate, @CalculatedDate)) -- count of all days diff
                 -(DATEDIFF(week, @DeliveryDate, @CalculatedDate) * 2) -- count of weekends
        END

    RETURN @OT_DaysDiff
END;