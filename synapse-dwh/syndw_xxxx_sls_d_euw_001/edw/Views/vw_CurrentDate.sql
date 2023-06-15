CREATE VIEW [edw].[vw_CurrentDate]
AS
SELECT
    CAST(GETDATE() as DATE) AS today