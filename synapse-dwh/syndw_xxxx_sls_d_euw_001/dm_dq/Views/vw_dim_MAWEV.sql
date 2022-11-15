CREATE VIEW [dm_dq].[vw_dim_MAWEV] AS 

SELECT 
	    [MATNR] AS MaterialNumber,
        [WERKS] AS Plant,
        [ALAND] AS DepartureCountry,
        [VHART] AS PackagingMaterialType
FROM 
        [base_s4h_cax].[NSDM_V_MAWEV]