CREATE VIEW [edw].[vw_ValuationClass]
AS
    SELECT
           IPVCT.[ValuationClass]            as [ValuationClassID],
           IPVCT.[ValuationClassDescription] as [ValuationClass],
           IPVCT.[t_applicationId]
    FROM
         [base_s4h_cax].[I_Prodvaluationclasstxt] IPVCT
    where IPVCT.[Language] = 'E'
