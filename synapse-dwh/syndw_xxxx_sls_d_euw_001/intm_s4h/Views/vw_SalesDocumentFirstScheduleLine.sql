
CREATE VIEW [intm_s4h].[vw_SalesDocumentFirstScheduleLine] AS
--TODO investigate options for optimizing
--Get the first dates for each Sales Document-Item combination.
SELECT
     SDSL.[SalesDocument]
    ,SDSL.[SalesDocumentItem]
    ,MIN(SDSL.[ConfirmedDeliveryDate]) AS [ConfirmedDeliveryDate]
    ,MIN(SDSL.GoodsIssueDate) AS [GoodsIssueDate]
    ,MIN(SDSL.ScheduleLine) AS [ScheduleLine]
FROM
    [base_s4h_cax].[I_SalesDocumentScheduleLine] SDSL
WHERE
    [IsConfirmedDelivSchedLine] = 'X'
GROUP BY 
     SDSL.[SalesDocument]
    ,SDSL.[SalesDocumentItem]