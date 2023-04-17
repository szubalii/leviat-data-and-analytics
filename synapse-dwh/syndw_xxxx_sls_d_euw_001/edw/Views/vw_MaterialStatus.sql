CREATE VIEW [edw].[vw_MaterialStatus]
AS
SELECT
     T.[MMSTA]
    ,T.[DEINK]
    ,T.[DSTLK]
    ,T.[DSTLP]
    ,T.[DAPLA]
    ,T.[DPBED]
    ,T.[DDISP]
    ,T.[DFAPO]
    ,T.[DFAKO]
    ,T.[DINST]
    ,T.[DBEST]
    ,T.[DPROG]
    ,T.[DFHMI]
    ,T.[DQMPF]
    ,T.[DTBED]
    ,T.[DTAUF]
    ,T.[DERZK]
    ,T.[DLFPL]
    ,T.[DLOCK]
    ,T.[AUPRF]
    ,TT.[MTSTB] AS [CrossPlantStatus]
    ,TT.[SPRAS]
    ,T.[t_applicationId]
FROM
    [base_s4h_cax].[T141] T
LEFT JOIN
    [base_s4h_cax].[T141T] TT
    ON
        TT.MMSTA = T.MMSTA
WHERE
    TT.[SPRAS] = 'E'