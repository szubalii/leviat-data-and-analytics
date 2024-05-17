CREATE VIEW [edw].[vw_CustomerCalculated]
AS 
WITH 
MigratedSAPCustomerBasicMapping AS (
    SELECT
        SAP.[SAPCustomeraccount] as [SAPCustomeraccount]
    ,   SAP.[AXCustomeraccount]
    ,   SAP.[AXCustomerCalculated]
    ,   row_number() over (PARTITION by SAP.[SAPCustomeraccount] order by SAP.[AXCustomeraccount]) as RN
    ,   count(SAP.[AXCustomeraccount]) over (PARTITION by SAP.[SAPCustomeraccount]) as CNT
    ,   SAP.[t_applicationId]
    ,   SAP.[t_jobId]
    ,   SAP.[t_jobDtm]
    ,   SAP.[t_jobBy]
    ,   SAP.[t_extractionDtm]
    ,   SAP.[t_filePath]
    FROM
        [edw].[dim_SAPCustomerBasicMappingTable] SAP
    LEFT JOIN
    [map_AXBI].[SalesOrganization] AS SO
    ON
        SAP.[AXDataAreaId] = source_DataAreaID 
        AND 
        [target_SalesOrganizationID] != 'TBD'
    WHERE
        SO.IsMigrated = 'Y'
)
,CALCULATED as
(
        SELECT
            IC.[CustomerID]                     as [CustomerIDCalculated]
        ,   IC.[CustomerName]                   as [CustomerCalculated]
        ,   CT.[CUSTOMERPILLAR]                 as [CustomerPillarCalculated]
        ,   null                                as [isReviewed]
        ,   case
            when MSCBMT.CNT=1 then 'one_TOM'
            when MSCBMT.CNT>1 then 'many_TOM'
            end                                 as [mappingType]
        ,   MSCBMT.[AXCustomeraccount]           as [axbiCustomeraccount]
        ,   CT.[NAME]                           as [axbiCustomerName]
        ,   CT.[CUSTOMERPILLAR]                 as [axbiCustomerPillarCalculated]
        ,   MSCBMT.[t_applicationId]
        ,   MSCBMT.[t_jobId]
        ,   MSCBMT.[t_jobDtm]
        ,   MSCBMT.[t_jobBy]
        ,   MSCBMT.[t_extractionDtm]
        ,   MSCBMT.[t_filePath]
        FROM
            MigratedSAPCustomerBasicMapping MSCBMT
        LEFT JOIN
        (
           select
                    row_num
                ,   [CustomerID]
                ,   [CustomerExternalID]
                ,   [CustomerName]
                ,   [CustomerFullName]
                ,   [Language]
                from (
                        select
                            row_number() over(PARTITION BY [CustomerID] ORDER BY [CustomerID], case when [Language] = 'E' then 0 else 1 end) row_num
                        ,   [CustomerID]
                        ,   [CustomerExternalID]
                        ,   [Customer] as [CustomerName]
                        ,   [CustomerFullName]
                        ,   [Language]
                        from
                           [edw].[dim_Customer]
            )  SUbQuery
            where row_num = 1
        )  IC
            ON
                MSCBMT.[SAPCustomeraccount] = IC.[CustomerExternalID]
        LEFT JOIN
             [intm_axbi].[dim_CUSTTABLE]  CT
            ON
                CT.[ACCOUNTNUM]=MSCBMT.[AXCustomerCalculated]
        WHERE
            MSCBMT.RN = 1
            AND
              IC.[CustomerID] IS NOT NULL

    UNION ALL

    SELECT
        IC.[CustomerID] as [CustomerIDCalculated]
    ,   IC.[Customer] as [CustomerCalculated]
    ,   null as [CustomerPillarCalculated]
    ,   null as [isReviewed]
    ,   'no_TOM' as [mappingType]
    ,   null as [axbiCustomeraccount]
    ,   null as [axbiItemName]
    ,   null as [axbiCustomerPillarCalculated]
    ,   IC.[t_applicationId]
    ,   IC.[t_jobId]
    ,   IC.[t_jobDtm]
    ,   IC.[t_jobBy]
    ,   IC.[t_extractionDtm]
    ,   NULL as [t_filePath]
    FROM
        [edw].[dim_Customer] IC
    WHERE
        NOT EXISTS(
        SELECT
            [SAPCustomeraccount]
        FROM
            [edw].[dim_SAPCustomerBasicMappingTable] SCBMT
        WHERE
            SCBMT.[SAPCustomeraccount] = IC.[CustomerExternalID]
        )

    UNION ALL

    SELECT
        C.[ACCOUNTNUM] as [CustomerIDCalculated]
    ,   C.[NAME] as [CustomerCalculated]
    ,   C.[CUSTOMERPILLAR] as [CustomerPillarCalculated]
    ,   null as [isReviewed]
    ,   'no_SAP' as [mappingType]
    ,   C.[ACCOUNTNUM] as [axbiCustomeraccount]
    ,   C.[NAME] as [axbiItemName]
    ,   C.[CUSTOMERPILLAR] as [axbiCustomerPillarCalculated]
    ,   C.[t_applicationId]
    ,   C.[t_jobId]
    ,   C.[t_jobDtm]
    ,   C.[t_jobBy]
    ,   C.[t_extractionDtm]
    ,   null as [t_filePath]
    FROM
         [intm_axbi].[dim_CUSTTABLE]  C
    WHERE
        C.[ACCOUNTNUM] NOT IN(
        SELECT
            [AXCustomerCalculated]
        FROM
            MigratedSAPCustomerBasicMapping 
        )
    )

SELECT 
    C.[CustomerIDCalculated] 
,   C.[CustomerCalculated] 
,   C.[CustomerPillarCalculated]
,   C.[isReviewed]
,   C.[mappingType]
,   C.[axbiCustomeraccount]
,   C.[axbiCustomerName]
,   C.[axbiCustomerPillarCalculated]
,   C.[t_applicationId]
,   C.[t_jobId]
,   C.[t_jobDtm]
,   C.[t_jobBy]
,   C.[t_extractionDtm]
,   C.[t_filePath]
FROM 
    CALCULATED C
WHERE 
    NOT EXISTS(
    SELECT 
        CC.[CustomerIDCalculated] 
    FROM 
        [base_ff].[CustomerCalculated] CC
    WHERE 
        CC.[CustomerIDCalculated]=C.[CustomerIDCalculated]
        --AND 
        --CC.[isReviewed] = 1
    )

UNION ALL

SELECT 
    CC.[CustomerIDCalculated] 
,   CC.[CustomerCalculated] 
,   CC.[CustomerPillarCalculated]
,   CC.[isReviewed]
,   CC.[mappingType]
,   CC.[axbiCustomeraccount]
,   CC.[axbiCustomerName]
,   CC.[axbiCustomerPillarCalculated]
,   CC.[t_applicationId]
,   CC.[t_jobId]
,   CC.[t_jobDtm]
,   CC.[t_jobBy]
,   CC.[t_extractionDtm]
,   CC.[t_filePath]
FROM 
    [base_ff].[CustomerCalculated] CC
--WHERE
--    CC.[isReviewed] = 1
