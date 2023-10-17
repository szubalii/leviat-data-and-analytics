CREATE FUNCTION [edw].[svf_excludeWeekends](
    @DeliveryDate DATE,
    @CalculatedDate DATE
)
RETURNS DATE
AS
BEGIN
    DECLARE @DeliveryDateWithoutWeekends AS DATE
    SET @DeliveryDateWithoutWeekends =

        CASE
            WHEN
                (@DeliveryDate IS NULL
                OR
                @DeliveryDate  = '0001-01-01')
            THEN NULL
            WHEN
                DATENAME(weekday, @DeliveryDate) = 'Saturday'
                AND
                (@DeliveryDate < @CalculatedDate
                OR
                @CalculatedDate IS NULL)
            THEN DATEADD(day, -1, @DeliveryDate)
            WHEN
                DATENAME(weekday, @DeliveryDate) = 'Saturday'
                AND
                @DeliveryDate > @CalculatedDate
            THEN DATEADD(day, 2, @DeliveryDate)
            WHEN
                DATENAME(weekday, @DeliveryDate) = 'Sunday'
                AND
                (@DeliveryDate < @CalculatedDate
                OR
                @CalculatedDate IS NULL)
            THEN DATEADD(day, -2, @DeliveryDate)
            WHEN
                DATENAME(weekday, @DeliveryDate) = 'Sunday'
                AND
                @DeliveryDate > @CalculatedDate
            THEN  DATEADD(day, 1, @DeliveryDate)
            ELSE @DeliveryDate
        END

    RETURN @DeliveryDateWithoutWeekends
END;