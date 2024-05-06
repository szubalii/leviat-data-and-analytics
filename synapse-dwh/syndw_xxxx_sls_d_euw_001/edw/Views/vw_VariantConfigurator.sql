CREATE VIEW [edw].[vw_VariantConfigurator]
AS
WITH ZCV_active AS (SELECT 
    [SalesDocument],
    [SalesDocumentItem],
    [ProductID],
    [ProductExternalID],
    --CharacteristicName without prefix 'ZCH_'
    RIGHT([CharacteristicName],LEN([CharacteristicName])-4) AS [CharacteristicName],
    CASE
      WHEN [DecimalValueFrom]<> 0 OR ([DecimalValueFrom]=0 AND [CharValue]='' AND ISNULL([CharValueDescription],'') = '') THEN CAST([DecimalValueFrom] AS NVARCHAR)
      WHEN [DecimalValueFrom]=0 AND [CharValue]<>[CharValueDescription] AND ISNULL([CharValueDescription],'') <> '' THEN CONCAT([CharValue],'_',[CharValueDescription])
      ELSE COALESCE([CharValue],[CharValueDescription])
    END AS [CharValueDescription],
    [t_applicationId]
FROM
    [base_s4h_cax].[Z_C_VariantConfig_OtherCharacteristics_F])
,VC AS
(
--The reason for using STRING_AGG is some Sales Order Items have multiple values in the CharValueDescription
--at least for CharatericticName "ZCH_MAT_DESCRIPTION_S" .
--For these cases, we concate the values using a space in between, and save the value as CharValueDescription.
SELECT
    [SalesDocument] /*collate SQL_Latin1_General_CP1_CS_AS*/ AS SalesDocument,
    [SalesDocumentItem] /*collate SQL_Latin1_General_CP1_CS_AS*/ AS SalesDocumentItem,
    [ProductID],
    [ProductExternalID],
    [CharacteristicName],
    STRING_AGG([CharValueDescription],' ') AS [CharValueDescription], 
    [t_applicationId]
FROM
    ZCV_active
WHERE [CharacteristicName]='MAT_DESCRIPTION_S'
GROUP BY
    [SalesDocument] /*collate SQL_Latin1_General_CP1_CS_AS*/,
    [SalesDocumentItem] /*collate SQL_Latin1_General_CP1_CS_AS*/,
    [ProductID],
    [ProductExternalID],
    [CharacteristicName], 
    [t_applicationId] 
UNION ALL
SELECT 
    [SalesDocument] /*collate SQL_Latin1_General_CP1_CS_AS*/ AS SalesDocument,
    [SalesDocumentItem] /*collate SQL_Latin1_General_CP1_CS_AS*/ AS SalesDocumentItem,
    [ProductID],
    [ProductExternalID],   
    [CharacteristicName],
    [CharValueDescription], 
    [t_applicationId]
FROM
    ZCV_active
WHERE [CharacteristicName]<>'MAT_DESCRIPTION_S'
)
SELECT 
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[ProductID]
    ,[ProductExternalID]
    ,[SO_ITEM_PROD_HIERARCHY] 
    ,[SO_ITEM_PROD_HIERARCHY1]
    ,[HM_LENGTH]
    ,[HM_MATERIAL]
    ,[HM_PROFILE]
    ,[HTA_ANCHOR]
    ,[HTA_FILLER]
    ,[HTA_LENGTH]
    ,[HTA_MATERIAL]
    ,[HTA_PROFILE]
    ,[HZA_ANCHOR]
    ,[HZA_PROFILE]
    ,[HZA_PS_ANCHOR]
    ,[HZA_PS_MATERIAL]
    ,[HZA_PS_PROFILE]
    ,[HDB_DIAM]
    ,[HDB_HEIGHT]
    ,[HDB_LENGTH]
    ,[HDB_STUD_TYPE]
    ,[HDB_STUDQTY]
    ,[HDB_TYPE]
    ,[HIT_CON_COV]
    ,[HIT_CSB_QTY]
    ,[HIT_HEIGHT]
    ,[HIT_MVX_ES]
    ,[HIT_TB_QTY]
    ,[HIT_TYPE]
    ,[HIT_WIDTH]
    ,[HDBZ_STUD_DIAM]
    ,[HDBZ_STUD_LENGTH]
    ,[HIT_QS_DIAM]
    ,[HIT_QS_QTY]
    ,[HIT_QS_TYPE]
    ,[HIT_VARRIANT]
    ,[HBS05_BAR_DESIGN]
    ,[HDBZ_CC_BOTTOM]
    ,[HDBZ_CC_TOP]
    ,[HDBZ_DIAM]
    ,[HDBZ_HEIGHT]
    ,[HIT_STUFFE]
    ,[MAT_DESCRIPTION_S]
    ,[t_applicationId]
FROM
    (SELECT
         [SalesDocument]
        ,[SalesDocumentItem]
        ,[ProductID]
        ,[ProductExternalID]
        ,[CharacteristicName]
        ,[CharValueDescription]
        ,[t_applicationId]
    FROM
        VC) VC2
PIVOT
(
MAX([CharValueDescription])
FOR [CharacteristicName] 
IN (
     [SO_ITEM_PROD_HIERARCHY] 
    ,[SO_ITEM_PROD_HIERARCHY1]
    ,[HM_LENGTH]
    ,[HM_MATERIAL]
    ,[HM_PROFILE]
    ,[HTA_ANCHOR]
    ,[HTA_FILLER]
    ,[HTA_LENGTH]
    ,[HTA_MATERIAL]
    ,[HTA_PROFILE]
    ,[HZA_ANCHOR]
    ,[HZA_PROFILE]
    ,[HZA_PS_ANCHOR]
    ,[HZA_PS_MATERIAL]
    ,[HZA_PS_PROFILE]
    ,[HDB_DIAM]
    ,[HDB_HEIGHT]
    ,[HDB_LENGTH]
    ,[HDB_STUD_TYPE]
    ,[HDB_STUDQTY]
    ,[HDB_TYPE]
    ,[HIT_CON_COV]
    ,[HIT_CSB_QTY]
    ,[HIT_HEIGHT]
    ,[HIT_MVX_ES]
    ,[HIT_TB_QTY]
    ,[HIT_TYPE]
    ,[HIT_WIDTH]
    ,[HDBZ_STUD_DIAM]
    ,[HDBZ_STUD_LENGTH]
    ,[HIT_QS_DIAM]
    ,[HIT_QS_QTY]
    ,[HIT_QS_TYPE]
    ,[HIT_VARRIANT]
    ,[HBS05_BAR_DESIGN]
    ,[HDBZ_CC_BOTTOM]
    ,[HDBZ_CC_TOP]
    ,[HDBZ_DIAM]
    ,[HDBZ_HEIGHT]
    ,[HIT_STUFFE]
    ,[MAT_DESCRIPTION_S]
    )
) AS PVC