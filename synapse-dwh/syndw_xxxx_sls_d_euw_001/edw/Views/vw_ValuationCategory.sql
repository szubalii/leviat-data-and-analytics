CREATE VIEW [edw].[vw_ValuationCategory]
	AS SELECT
        TC.[BWTTY] as ValuationCategoryID,
        TC.[BTBEZ] as  ValuationCategory,
        TC.[t_applicationId]
    FROM
         [base_s4h_cax].[T149T] TC
    WHERE
          TC.[SPRAS] = 'E'
