CREATE VIEW [edw].[vw_ValuationType]
AS 
     SELECT
          IVT.[InventoryValuationType] as [ValuationTypeID],
          TL.[KRFTX] as [ValuationType],
          TL.[t_applicationId]
     FROM
          [base_s4h_cax].[I_InventoryValuationType] AS IVT 
     LEFT JOIN 
          [base_s4h_cax].[T025L] AS TL on IVT.[AcctCategoryRef] = TL.[KKREF]         
     WHERE
          TL.[SPRAS] = 'E'