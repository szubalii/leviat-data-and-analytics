ODIPerSDI AS (   
    SELECT
        SDI_ODI_list.SalesDocument
        ,SDI_ODI_list.SalesDocumentItem
        ,COUNT(*) AS [NrODIPerSDIAndQtyNot0]
        ,SUM(SDI_ODI_list.[ActualDeliveryQuantity]) AS [ActDelQtyTotalForSDI]
    FROM (
            SELECT 
                SDI.[SalesDocument]
                ,SDI.[SalesDocumentItem]
                ,ODI.[OutboundDelivery]
                ,ODI.[OutboundDeliveryItem]
                ,ODI.[ActualDeliveryQuantity]
            FROM
                [base_s4h_cax].[I_OutboundDeliveryItem] AS ODI
            INNER JOIN
                SalesDocumentItem_LC_EUR AS SDI
                ON
                    ODI.[ReferenceSDDocument] = SDI.[SalesDocument]
                    AND
                    ODI.[ReferenceSDDocumentItem] = SDI.[SalesDocumentItem]
            WHERE
                (ODI.[ReferenceSDDocument] IS NOT NULL
                OR
                ODI.[ReferenceSDDocument] != '')
            GROUP BY
                SDI.[SalesDocument]
                ,SDI.[SalesDocumentItem]
                ,ODI.[OutboundDelivery]
                ,ODI.[OutboundDeliveryItem]
                ,ODI.[ActualDeliveryQuantity]
        ) SDI_ODI_list
    GROUP BY 
     SDI_ODI_list.[SalesDocument]
    ,SDI_ODI_list.[SalesDocumentItem]