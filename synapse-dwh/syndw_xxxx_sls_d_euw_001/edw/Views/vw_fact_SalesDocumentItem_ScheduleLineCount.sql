CREATE VIEW [edw].[vw_fact_SalesDocumentItem_ScheduleLineCount] AS
SELECT
     SDI_SDSL_list.[SalesDocument]
    ,SDI_SDSL_list.[SalesDocumentItem]
    ,COUNT(*) AS [NrSLInScope]
FROM (
        SELECT
             SDI.[SalesDocument]
            ,SDI.[SalesDocumentItem]
            ,SDSL.[ScheduleLine]
        FROM
            [base_s4h_cax].[I_SalesDocumentScheduleLine] AS SDSL
        INNER JOIN
            [edw].[vw_fact_SalesDocumentItem_LC_EUR] AS SDI
            ON
                SDSL.[SalesDocument] = SDI.[SalesDocument]
                AND
                SDSL.[SalesDocumentItem] = SDI.[SalesDocumentItem]
        WHERE
            [IsConfirmedDelivSchedLine] = 'X'
        GROUP BY 
            SDI.[SalesDocument]
            ,SDI.[SalesDocumentItem]
            ,SDSL.[ScheduleLine]
    ) SDI_SDSL_list
GROUP BY
     SDI_SDSL_list.[SalesDocument]
    ,SDI_SDSL_list.[SalesDocumentItem]