CREATE FUNCTION [edw].[svf_getYearPeriod](
    @ReportDate     DATE
)
-- convert date to YYYYMMM string (year and month with leading zeros)
RETURNS VARCHAR(7)
AS
BEGIN
    RETURN 
        CONCAT(
        CAST(YEAR(@ReportDate)  AS VARCHAR)
        ,RIGHT(CONCAT('00',MONTH(@ReportDate)),3)
        )
END