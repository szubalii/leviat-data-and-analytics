

--TODO investigate options for optimizing
SDSLScheduleLine AS (
--Get the first dates for each Sales Document-Item combination.
SELECT
     SDSL.[SalesDocument]
    ,SDSL.[SalesDocumentItem]
    ,MIN(SDSL.[ConfirmedDeliveryDate]) AS [ConfirmedDeliveryDate]
    ,MIN(SDSL.GoodsIssueDate) AS [GoodsIssueDate]
    ,MIN(SLS.ScheduleLine) AS [ScheduleLine]

FROM [edw].[vw_dim_SalesDocumentScheduleLine] SDSL

--Join back for the schedule line.
LEFT OUTER JOIN 
    (
         SELECT 
             [SalesDocument]
            ,[SalesDocumentItem]
            ,[ConfirmedDeliveryDate]
            ,[GoodsIssueDate]
            ,[ScheduleLine]

        FROM [edw].[vw_dim_SalesDocumentScheduleLine]

        WHERE [IsConfirmedDelivSchedLine] = 'X'
    ) SLS
    ON 
    SDSL.SalesDocument = SLS.SalesDocument
    AND 
    SDSL.SalesDocumentItem = SLS.SalesDocumentItem
    AND 
    SDSL.ConfirmedDeliveryDate = SLS.ConfirmedDeliveryDate
    AND 
    SDSL.GoodsIssueDate = SLS.GoodsIssueDate

WHERE [IsConfirmedDelivSchedLine] = 'X'

GROUP BY 
     SDSL.[SalesDocument]
    ,SDSL.[SalesDocumentItem]
)