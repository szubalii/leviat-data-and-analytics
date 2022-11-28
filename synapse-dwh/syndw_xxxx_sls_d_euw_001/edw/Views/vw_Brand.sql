CREATE VIEW [edw].[vw_Brand]
	AS SELECT
            AMGT.[AdditionalMaterialGroup1]         as [BrandID]
        ,   AMGT.[AdditionalMaterialGroup1Name]     as [Brand]
        ,   AMGT.t_applicationId
    FROM [base_s4h_cax].[I_AdditionalMaterialGroup1Text] AMGT
    WHERE AMGT.[Language] = 'E'
    