CREATE VIEW [edw].[vw_Brand] AS
SELECT
    AMGT.[AdditionalMaterialGroup1] AS [BrandID],
    AMGT.[AdditionalMaterialGroup1Name] AS [Brand],
    AMGT.t_applicationId
FROM
    [base_s4h_cax].[I_AdditionalMaterialGroup1Text] AMGT
WHERE
    AMGT.[Language] = 'E'
