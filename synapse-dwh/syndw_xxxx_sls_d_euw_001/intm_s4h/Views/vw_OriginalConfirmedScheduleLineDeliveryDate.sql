CREATE VIEW [intm_s4h].[vw_OriginalConfirmedScheduleLineDeliveryDate] AS
WITH ICDI AS(
SELECT 
    SUBSTRING(ChangeDocTableKey,4,10) AS [SalesDocumentID],
    SUBSTRING(ChangeDocTableKey,14,6) AS [SalesDocumentItemID],
    RIGHT(ChangeDocTableKey,4) AS [ScheduleLine],
    CAST(ChangeDocPreviousFieldValue AS DATE) AS [OriginalConfirmedDeliveryDate]
FROM
    [base_s4h_cax].[I_ChangeDocumentItem_VBEP_EDATU]
)
SELECT
   [SalesDocumentID],
   [SalesDocumentItemID],
   [ScheduleLine],
   MIN([OriginalConfirmedDeliveryDate]) AS [OriginalConfirmedDeliveryDate]
FROM
    ICDI
GROUP BY
   [SalesDocumentID],
   [SalesDocumentItemID],
   [ScheduleLine]