CREATE PROC [edw].[sp_load_fact_ProductHierarchyVariantConfigCharacteristic_active]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_jobBy [nvarchar](128)
, @t_lastActionCd [varchar](1) -- workaround with option to save single solution in DF
AS
BEGIN
    DECLARE @errmessage NVARCHAR(2048);
    
    BEGIN TRY
        UPDATE
            [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] 
        SET 
            [ProductID]                     = vwBD.[ProductID]
            , [ProductExternalID]           = vwBD.[ProductExternalID]
            , [ProductSurrogateKey]         = vwBD.[ProductSurrogateKey]
            , [Configuration]               = vwBD.[Configuration]
            , [Instance]                    = vwBD.[Instance]
            , [LastChangeDate]              = vwBD.[LastChangeDate]
            , [CharacteristicName]          = vwBD.[CharacteristicName]
            , [CharacteristicDescription]   = vwBD.[CharacteristicDescription]
            , [DecimalValueFrom]            = vwBD.[DecimalValueFrom]
            , [CharValue]                   = vwBD.[CharValue]
            , [CharValueDescription]        = vwBD.[CharValueDescription]
            , [t_applicationId]             = vwBD.[t_applicationId]
            , [t_jobId]                     = @t_jobId 
            , [t_jobDtm]                    = @t_jobDtm 
            , [t_jobBy]                     = @t_jobBy
            , [t_extractionDtm]             = vwBD.[t_extractionDtm]
        FROM
            [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] AS tBD
        JOIN
            [edw].[vw_ProductHierarchyVariantConfigCharacteristic_delta] AS vwBD  
            ON (
                tBD.[SalesDocument] = vwBD.[SalesDocument]
                AND
                tBD.[SalesDocumentItem] = vwBD.[SalesDocumentItem])

        INSERT [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] (
              [SalesDocument]
            , [SalesDocumentItem]
            , [ProductID]
            , [ProductExternalID]
            , [ProductSurrogateKey]
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
            , [t_extractionDtm])
        SELECT
              vwBD.[SalesDocument]
            , vwBD.[SalesDocumentItem]
            , vwBD.[ProductID]
            , vwBD.[ProductExternalID]
            , vwBD.[ProductSurrogateKey]
            , vwBD.[Configuration]
            , vwBD.[Instance]
            , vwBD.[LastChangeDate]
            , vwBD.[CharacteristicName]
            , vwBD.[CharacteristicDescription]
            , vwBD.[DecimalValueFrom]
            , vwBD.[CharValue]
            , vwBD.[CharValueDescription]
            , vwBD.[t_applicationId]
            , @t_jobId
            , @t_jobDtm
            , @t_jobBy
            , vwBD.[t_extractionDtm]
            FROM
                [edw].[vw_ProductHierarchyVariantConfigCharacteristic_delta] AS vwBD 
        WHERE
            NOT EXISTS (SELECT 1 FROM [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active]
                WHERE           
                    [SalesDocument] = vwBD.[SalesDocument]
                AND
                    [SalesDocumentItem] = vwBD.[SalesDocumentItem]);
    END TRY
    BEGIN CATCH
        SET @errmessage = 'Internal error in ' + ERROR_PROCEDURE() + '. ' +  ERROR_MESSAGE();
        THROW 50001, @errmessage, 1;
    END CATCH
END
