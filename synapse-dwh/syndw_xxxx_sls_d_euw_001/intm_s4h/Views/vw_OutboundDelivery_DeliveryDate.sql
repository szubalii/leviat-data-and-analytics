CREATE VIEW [intm_s4h].[vw_OutboundDelivery_DeliveryDate]
AS
WITH
CalculatedDelDate_precalculation AS (
    SELECT
         OD.[OutboundDelivery]
        ,OD.[ActualGoodsMovementDate] AS [HDR_ActualGoodsMovementDate]
        ,CAST(DimActualRoute.[DurInDays] AS INT) AS [ActualDeliveryRouteDurationInDays]
        ,CAST(CAST(DimActualRoute.[DurInDays] AS INT)%5 AS INT) AS [leftoverdays]
        /* CAST((DimActualRoute.[DurInDays])/5 AS INT)  calculates the number of weeks,
        [DurInDays] defines the duration but only weekdays. Hence the divide by 5 and then multiply by 7 to get the number of weeks */
        ,DATEADD(day, CAST((DimActualRoute.[DurInDays])/5 AS INT)*7, OD.[ActualGoodsMovementDate]) AS [HDR_ActualGoodsMovementDate_upd]
        ,DATEPART(weekday, OD.[ActualGoodsMovementDate]) AS [weekday]
    FROM
        [base_s4h_cax].[I_OutboundDelivery] OD
    LEFT JOIN
        [edw].[dim_Route] DimActualRoute
        ON DimActualRoute.[ROUTEID] = OD.[ActualDeliveryRoute]
    WHERE
        OD.[ActualGoodsMovementDate] <> '0001-01-01'
    GROUP BY
         OD.[OutboundDelivery]
        ,OD.[ActualGoodsMovementDate]
        ,DimActualRoute.[DurInDays]
)
SELECT
    [OutboundDelivery]
    /* calculates Delivery Date excluding weekends.
    @@DATEFIRST value is set to Sunday, thus Monday has weekday value of 2, hence we do weekday-1
    Then check if after adding the left over days the new date is in a weekend or not.
    This is why we divide by 6 and then multiply by 2 so we potentially increase by another 2 days to fall over the weekend. */
    ,CAST(DATEADD(day, CAST(((weekday-1+[leftoverdays])/6) AS INT)*2 + [leftoverdays], [HDR_ActualGoodsMovementDate_upd]) AS DATE) AS [CalculatedDelDate]
FROM
    CalculatedDelDate_precalculation