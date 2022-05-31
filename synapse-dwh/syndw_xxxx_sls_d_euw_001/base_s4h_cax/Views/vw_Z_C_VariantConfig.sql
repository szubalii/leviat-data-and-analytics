CREATE VIEW [base_s4h_cax].[vw_Z_C_VariantConfig]
AS
WITH last_rows AS (
    SELECT
        MAX([TS_SEQUENCE_NUMBER]) AS [TS_SEQUENCE_NUMBER],
        MAX([t_extractionDtm])    AS [t_extractionDtm],
        [SalesDocument],
        [SalesDocumentItem],
        [CharacteristicName]
    FROM
        [base_s4h_cax].[Z_C_VariantConfig_delta]
    GROUP BY
        [SalesDocument],
        [SalesDocumentItem],
        [CharacteristicName]
)
SELECT
    current_rows.[ODQ_CHANGEMODE]
    , current_rows.[ODQ_ENTITYCNTR]
    , current_rows.[SalesDocument]
    , current_rows.[SalesDocumentItem]
    , current_rows.[ProductID]
    , current_rows.[ProductExternalID]
    , current_rows.[Configuration]
    , current_rows.[Instance]
    , current_rows.[LastChangeDate]
    , current_rows.[CharacteristicName]
    , current_rows.[CharacteristicDescription]
    , current_rows.[DecimalValueFrom]
    , current_rows.[CharValue]
    , current_rows.[CharValueDescription]
    , current_rows.[t_applicationId]
    , current_rows.[t_jobId]
    , current_rows.[t_jobDtm]
    , current_rows.[t_jobBy]
    , current_rows.[t_extractionDtm]
    , current_rows.[t_filePath]
FROM
    last_rows
INNER JOIN
    [base_s4h_cax].[Z_C_VariantConfig_delta] AS current_rows
    ON
        current_rows.[TS_SEQUENCE_NUMBER] = last_rows.[TS_SEQUENCE_NUMBER]
        AND
        current_rows.[t_extractionDtm] = last_rows.[t_extractionDtm]
        AND
        current_rows.[SalesDocument] = last_rows.[SalesDocument]
        AND
        current_rows.[SalesDocumentItem] = last_rows.[SalesDocumentItem]
        AND
        current_rows.[CharacteristicName] = last_rows.[CharacteristicName]
        
