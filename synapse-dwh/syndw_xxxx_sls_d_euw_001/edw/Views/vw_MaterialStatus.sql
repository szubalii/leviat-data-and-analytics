CREATE VIEW [edw].[vw_MaterialStatus]
AS
SELECT
     T.[MMSTA] AS [MaterialStatusID]
    ,T.[DEINK] AS [Purchaising]
    ,T.[DSTLK] AS [BOMHeader]
    ,T.[DSTLP] AS [BOMItem]
    ,T.[DAPLA] AS [Routing]
    ,T.[DPBED] AS [Requirement]
    ,T.[DDISP] AS [MRP]
    ,T.[DFAPO] AS [ProductionOrder]
    ,T.[DFAKO] AS [ProductionOrderHeader]
    ,T.[DINST] AS [PlantMaintenance]
    ,T.[DBEST] AS [InventoryMaintenance]
    ,T.[DPROG] AS [Forecasting]
    ,T.[DFHMI] AS [PRT]
    ,T.[DQMPF] AS [QM]
    ,T.[DTBED] AS [PostingChange]
    ,T.[DTAUF] AS [WMTransferOrder]
    ,T.[DERZK] AS [ProcedureCreating]
    ,T.[DLFPL] AS [Planning]
    ,T.[DLOCK] AS [DistributionLock]
    ,T.[AUPRF] AS [ProfileName]
    ,TT.[MTSTB] AS [CrossPlantStatus]
    ,TT.[SPRAS] AS [Language]
    ,T.[t_applicationId]
FROM
    [base_s4h_cax].[T141] T
LEFT JOIN
    [base_s4h_cax].[T141T] TT
    ON
        TT.MMSTA = T.MMSTA
WHERE
    TT.[SPRAS] = 'E'