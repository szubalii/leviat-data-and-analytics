CREATE PROC [base_s4h_cax].[sp_load_Z_C_VariantConfig]
AS
BEGIN

    -- Update or Delete(marks as Delete - 'D') records the base table based on the delta dataset
    UPDATE tgt
    SET
        tgt.[ProductID] = src.[ProductID]
        , tgt.[ProductExternalID] = src.[ProductExternalID]
        , tgt.[Configuration] = src.[Configuration]
        , tgt.[Instance] = src.[Instance]
        , tgt.[LastChangeDate] = src.[LastChangeDate]
        , tgt.[CharacteristicDescription] = src.[CharacteristicDescription]
        , tgt.[DecimalValueFrom] = src.[DecimalValueFrom]
        , tgt.[CharValue] = src.[CharValue]
        , tgt.[CharValueDescription] = src.[CharValueDescription]

        , tgt.[t_applicationId] = src.[t_applicationId]
        , tgt.[t_jobId] = src.[t_jobId]
        , tgt.[t_jobDtm] = src.[t_jobDtm]
        , tgt.[t_jobBy] = src.[t_jobBy]
        , tgt.[t_filePath] = src.[t_filePath]
        , tgt.[t_extractionDtm] = src.[t_extractionDtm]
        , tgt.[t_lastActionBy] = CURRENT_USER
        , tgt.[t_lastActionCd] = (case
                                     when src.[ODQ_CHANGEMODE] = 'U' and src.[ODQ_ENTITYCNTR] = 1
                                         then 'U'
                                     when src.[ODQ_CHANGEMODE] = 'D' and src.[ODQ_ENTITYCNTR] = -1
                                         then 'D'
                                 end)
        , tgt.[t_lastActionDtm] = GETUTCDATE()
    FROM
        [base_s4h_cax].[Z_C_VariantConfig_active] as tgt
    INNER JOIN
        [base_s4h_cax].[vw_Z_C_VariantConfig] as src
        ON
            tgt.[SalesDocument] = src.[SalesDocument]
            AND
            tgt.[SalesDocumentItem] = src.[SalesDocumentItem]
            AND
            tgt.[CharacteristicName] = src.[CharacteristicName]
            AND
            (
                (
                    src.[ODQ_CHANGEMODE]  = 'U'
                    AND 
                    src.[ODQ_ENTITYCNTR] = 1
                )
                OR
                (
                    src.[ODQ_CHANGEMODE] = 'D'
                    AND 
                    src.[ODQ_ENTITYCNTR] = -1
                )
            )

    -- Insert new records in the base table based on the delta dataset

    INSERT INTO
        [base_s4h_cax].[Z_C_VariantConfig_active] (
              [SalesDocument]
            , [SalesDocumentItem]
            , [ProductID]
            , [ProductExternalID]
            , [Configuration]
            , [Instance]
            , [LastChangeDate]
            , [CharacteristicName]
            , [CharacteristicDescription]
            , [DecimalValueFrom]
            , [CharValue]
            , [CharValueDescription]
            , [t_applicationId]
            , [t_jobId]
            , [t_jobDtm]
            , [t_jobBy]
            , [t_filePath]
            , [t_extractionDtm]
            , [t_lastActionBy]
            , [t_lastActionCd]
            , [t_lastActionDtm]
        )
        SELECT
            [SalesDocument]
            , [SalesDocumentItem]
            , [ProductID]
            , [ProductExternalID]
            , [Configuration]
            , [Instance]
            , [LastChangeDate]
            , [CharacteristicName]
            , [CharacteristicDescription]
            , [DecimalValueFrom]
            , [CharValue]
            , [CharValueDescription]
            , [t_applicationId]
            , [t_jobId]
            , [t_jobDtm]
            , [t_jobBy]
            , [t_filePath]
            , [t_extractionDtm]
            , CURRENT_USER as [t_lastActionBy]
            , (case
                    when src.[ODQ_CHANGEMODE] = '' and src.[ODQ_ENTITYCNTR] = 0
                        then 'I'
                    when src.[ODQ_CHANGEMODE] = 'U' and src.[ODQ_ENTITYCNTR] = 1
                        then 'I'
                    when src.[ODQ_CHANGEMODE] = 'D' and src.[ODQ_ENTITYCNTR] = -1
                        then 'D'
                    when src.[ODQ_CHANGEMODE] = 'С' and src.[ODQ_ENTITYCNTR] = 1
                        then 'I'
                end) as [t_lastActionCd]
            , GETUTCDATE() as [t_lastActionDtm]
        FROM [base_s4h_cax].[vw_Z_C_VariantConfig] as src
        WHERE NOT EXISTS (
            SELECT 
                [SalesDocument]
                ,[SalesDocumentItem]
            FROM 
                [base_s4h_cax].[Z_C_VariantConfig_active] tgt2
            WHERE
                tgt2.[SalesDocument] = src.[SalesDocument]
                AND
                tgt2.[SalesDocumentItem] = src.[SalesDocumentItem]
                AND
                tgt2.[CharacteristicName] = src.[CharacteristicName]
        )

END
