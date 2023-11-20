CREATE VIEW [edw].[vw_fact_SalesDocumentItem_ScheduleLineCount] AS
SELECT
     SDSL.[SalesDocument]
    ,SDSL.[SalesDocumentItem]
    ,COUNT(*) AS [NrSLInScope]
FROM 
    [base_s4h_cax].[I_SalesDocumentScheduleLine] AS SDSL
WHERE
    SDSL.[IsConfirmedDelivSchedLine] = 'X'
GROUP BY
     SDSL.[SalesDocument]
    ,SDSL.[SalesDocumentItem]