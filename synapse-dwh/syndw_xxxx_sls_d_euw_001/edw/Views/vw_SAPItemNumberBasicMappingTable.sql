CREATE VIEW [edw].[vw_SAPItemNumberBasicMappingTable]
AS
WITH
DataAreaId_calculation AS (
    SELECT     
        SIMBMT.[AXItemnumber]
    ,   CASE 
            WHEN    
                UPPER(SIMBMT.[AXDataAreaId]) = 'ASS'
            THEN
                'ASCH'
            ELSE
                UPPER(SIMBMT.[AXDataAreaId])
        END                                                 AS [AXDataAreaId]
    ,   SIMBMT.[AXDataAreaId]                               AS [AXDataAreaId_Original]
    ,   SIMBMT.[SAPItemnumber]        
    ,   SIMBMT.[SAPMaterialtype]      
    ,   SIMBMT.[Migrate]              
    ,   SIMBMT.[SAPshortdescription]  
    ,   SIMBMT.[VALUATIONCLASS]       
    ,   SIMBMT.[VALUATIONCLASSCH01]   
    ,   SIMBMT.[VALUATIONCLASSDE01]   
    ,   SIMBMT.[VALUATIONCLASSDE02]   
    ,   SIMBMT.[VALUATIONCLASSPL01]   
    ,   SIMBMT.[Wave]  
    ,   SIMBMT.[t_applicationId]  
    ,   SIMBMT.[t_extractionDtm]
    FROM 
        [base_dw_halfen_0_hlp].[SAPItemNumberBasicMappingTable] SIMBMT
    WHERE 
        SIMBMT.[Migrate] IN ('Y', 'D') 
)
SELECT     
    DAC.[AXItemnumber]
,   CASE
        WHEN
            DAC.[AXDataAreaId] = '0000'
        THEN
            'HALF-' + DAC.[AXItemnumber]
        ELSE
            DAC.[AXDataAreaId] + '-' + DAC.[AXItemnumber]
    END                                                 AS [axbi_ItemNoCalc]
,   DAC.[AXDataAreaId]
,   DAC.[AXDataAreaId_Original]
,   MAX(P.[Product])                                    AS [SAPProductID] -- max() as temp fix to avoid duplicate values
,   MAX(DAC.[SAPItemnumber])                            AS [SAPItemnumber] -- max() as temp fix to avoid duplicate values        
,   MAX(DAC.[SAPMaterialtype])                          AS [SAPMaterialtype] -- max() as temp fix to avoid duplicate values
,   MAX(DAC.[Migrate])                                  AS [Migrate] -- max() as temp fix to avoid duplicate values
,   DAC.[SAPshortdescription]  
,   DAC.[VALUATIONCLASS]       
,   DAC.[VALUATIONCLASSCH01]   
,   DAC.[VALUATIONCLASSDE01]   
,   DAC.[VALUATIONCLASSDE02]   
,   DAC.[VALUATIONCLASSPL01]   
,   DAC.[Wave]  
,   DAC.[t_applicationId]  
,   DAC.[t_extractionDtm]
FROM 
    DataAreaId_calculation DAC
LEFT JOIN 
    [base_s4h_cax].[I_Product] P
        ON 
            DAC.[SAPItemnumber] = P.[ProductExternalID]
GROUP BY 
    DAC.[AXItemnumber]         
,   DAC.[AXDataAreaId]
,   DAC.[AXDataAreaId_Original]                
,   DAC.[SAPshortdescription]  
,   DAC.[VALUATIONCLASS]       
,   DAC.[VALUATIONCLASSCH01]   
,   DAC.[VALUATIONCLASSDE01]   
,   DAC.[VALUATIONCLASSDE02]   
,   DAC.[VALUATIONCLASSPL01]   
,   DAC.[Wave]  
,   DAC.[t_applicationId]  
,   DAC.[t_extractionDtm]