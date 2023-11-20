
CREATE VIEW [intm_s4h].[vw_SalesDocumentFirstScheduleLine] AS
--TODO investigate options for optimizing
--Get the first dates for each Sales Document-Item combination.
WITH SLS AS
(SELECT 
     [SalesDocument]
    ,[SalesDocumentItem]
    ,MIN([ConfirmedDeliveryDate]) AS ConfirmedDeliveryDate 
    ,MIN(GoodsIssueDate) AS GoodsIssueDate
FROM
    [base_s4h_cax].[I_SalesDocumentScheduleLine]
WHERE
    [IsConfirmedDelivSchedLine] = 'X'
GROUP BY 
     [SalesDocument]
    ,[SalesDocumentItem]
)
SELECT
     SLS.[SalesDocument]
    ,SLS.[SalesDocumentItem]
    ,SLS.[ConfirmedDeliveryDate]
    ,SLS.[GoodsIssueDate]
    ,SDSL.[ScheduleLine]
FROM
    SLS
LEFT JOIN 
    [base_s4h_cax].[I_SalesDocumentScheduleLine] SDSL
    ON 
    SDSL.[SalesDocument] = SLS.[SalesDocument]
    AND 
    SDSL.[SalesDocumentItem] = SLS.[SalesDocumentItem]
    AND 
    SDSL.[ConfirmedDeliveryDate] = SLS.[ConfirmedDeliveryDate]
WHERE
    SDSL.[IsConfirmedDelivSchedLine] = 'X'