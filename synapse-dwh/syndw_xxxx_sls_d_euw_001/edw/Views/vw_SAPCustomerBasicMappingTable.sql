CREATE VIEW [edw].[vw_SAPCustomerBasicMappingTable]
AS
SELECT
    SCBMT.[AXCustomeraccount]
,   DA.[DATAAREAID2] + '-' + SCBMT.[AXCustomeraccount] AS [AXCustomerCalculated]
,   SCBMT.[AXDataAreaId]
,   SCBMT.[SAPCustomeraccount]
,   SCBMT.[Migrate]
,   SCBMT.[t_applicationId]  
,   SCBMT.[t_extractionDtm]
FROM
    [base_dw_halfen_0_hlp].[SAPCustomerBasicMappingTable] SCBMT
JOIN
    [base_tx_ca_0_hlp].[DATAAREA] DA
    ON
        SCBMT.AXDataAreaId = DA.DATAAREAID
WHERE SCBMT.[SAPCustomeraccount] IS NOT NULL
GROUP BY
    SCBMT.[AXCustomeraccount]
,   DA.[DATAAREAID2]
,   SCBMT.[AXDataAreaId]
,   SCBMT.[SAPCustomeraccount]
,   SCBMT.[Migrate]
,   SCBMT.[t_applicationId]  
,   SCBMT.[t_extractionDtm]