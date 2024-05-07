CREATE VIEW [edw].[vw_SalesOrganization]
AS
WITH 
s4h_SO AS (
SELECT
    SalesOrganization.[SalesOrganization]           AS [SalesOrganizationID],
    SalesOrganizationText.[SalesOrganizationName]   AS [SalesOrganization],
    SalesOrganization.[SalesOrganizationCurrency],
    SalesOrganization.[CompanyCode],
    SalesOrganization.[IntercompanyBillingCustomer],
    SalesOrganization.[ArgentinaDeliveryDateEvent],
    SO.[CountryID],
    SO.[CountryName],
    SO.[RegionID],
    SO.[RegionName],
    SO.[Access_Control_Unit],
    SalesOrganization.[t_applicationId],
    SalesOrganization.[t_extractionDtm]
FROM
    [base_s4h_cax].[I_SalesOrganization] SalesOrganization
    LEFT JOIN [base_s4h_cax].[I_SalesOrganizationText] SalesOrganizationText
        ON SalesOrganization.[SalesOrganization] = SalesOrganizationText.[SalesOrganization]
        AND SalesOrganizationText.[Language] = 'E'
    LEFT JOIN [map_AXBI].[SalesOrganization] SO  -- we leave the JOIN through target_SalesOrganizationID, since this data has already been migrated
        ON
            SalesOrganization.[SalesOrganization] = SO.[target_SalesOrganizationID]
--     WHERE SalesOrganization.[MANDT] = 200
--     AND SalesOrganizationText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
)

SELECT
    [SalesOrganizationID],
    [SalesOrganization],
    [SalesOrganizationCurrency],
    [CompanyCode],
    [IntercompanyBillingCustomer],
    [ArgentinaDeliveryDateEvent],
    [CountryID],
    [CountryName],
    [RegionID],
    [RegionName],
    [Access_Control_Unit],
    [t_applicationId],
    [t_extractionDtm]
FROM s4h_SO
GROUP BY     
    [SalesOrganizationID],
    [SalesOrganization],
    [SalesOrganizationCurrency],
    [CompanyCode],
    [IntercompanyBillingCustomer],
    [ArgentinaDeliveryDateEvent],
    [CountryID],
    [CountryName],
    [RegionID],
    [RegionName],
    [Access_Control_Unit],
    [t_applicationId],
    [t_extractionDtm]

UNION ALL

SELECT
    CASE
        WHEN
            SO.[target_SalesOrganizationID] = SO.[source_DataAreaID]
        THEN
            SO.[target_SalesOrganizationID]
        ELSE
            SalesOrganizationAXBI.[DATAAREAID2]
    END AS [SalesOrganizationID],
    CASE
        WHEN
            SO.[target_SalesOrganizationID] = SO.[source_DataAreaID]
        THEN
            SO.[target_SalesOrganizationName]
        ELSE
            SalesOrganizationAXBI.[NAME]
    END AS [SalesOrganization],
    [LOCALCURRENCY]  AS [SalesOrganizationCurrency],
    [CRHCOMPANYID]  AS [CompanyCode],
    NULL AS [IntercompanyBillingCustomer],
    NULL AS [ArgentinaDeliveryDateEvent],
    SO.[CountryID],
    SO.[CountryName],
    SO.[RegionID],
    SO.[RegionName],
    SO.[Access_Control_Unit],
    SalesOrganizationAXBI.[t_applicationId] AS [t_applicationId],
    SalesOrganizationAXBI.[t_extractionDtm] AS [t_extractionDtm]
FROM
    [base_tx_ca_0_hlp].[DATAAREA] SalesOrganizationAXBI
    LEFT JOIN [map_AXBI].[SalesOrganization] SO
        ON SalesOrganizationAXBI.[DATAAREAID2] = SO.[source_DataAreaID]
WHERE ( -- here we need non-migrated data
        SO.[target_SalesOrganizationID] = SO.[source_DataAreaID]
        OR
        SO.[target_SalesOrganizationID] is NULL
    )

UNION ALL

SELECT
    CASE
        WHEN
            SO.[target_SalesOrganizationID] = SO.[source_DataAreaID]
        THEN
            SO.[target_SalesOrganizationID]
        ELSE
            SalesOrganizationAXBI2.[ID]
    END AS [SalesOrganizationID],
    CASE
        WHEN
            SO.[target_SalesOrganizationID] = SO.[source_DataAreaID]
        THEN
            SO.[target_SalesOrganizationName]
        ELSE
            SalesOrganizationAXBI2.[NAME]
    END AS [SalesOrganization],
    NULL AS [SalesOrganizationCurrency],
    NULL AS [CompanyCode],
    NULL AS [IntercompanyBillingCustomer],
    NULL AS [ArgentinaDeliveryDateEvent],
    SO.[CountryID],
    SO.[CountryName],
    SO.[RegionID],
    SO.[RegionName],
    SO.[Access_Control_Unit],
    SalesOrganizationAXBI2.[t_applicationId] AS [t_applicationId],
    SalesOrganizationAXBI2.[t_extractionDtm] AS [t_extractionDtm]
FROM
    [base_tx_halfen_2_dwh].[DIM_DATAAREA] SalesOrganizationAXBI2
    LEFT JOIN [map_AXBI].[SalesOrganization] SO
        ON SalesOrganizationAXBI2.[ID] = SO.[source_DataAreaID]
WHERE
    NOT EXISTS(
        SELECT
            [DATAAREAID2]
        FROM
            [base_tx_ca_0_hlp].[DATAAREA]
        WHERE
            [DATAAREAID2] = SalesOrganizationAXBI2.[ID]
    )
    AND
    ( -- here we need non-migrated data
        SO.[target_SalesOrganizationID] = SO.[source_DataAreaID]
        OR
        SO.[target_SalesOrganizationID] is NULL
    )