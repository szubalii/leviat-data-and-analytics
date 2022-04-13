CREATE VIEW [edw].[vw_SalesDistrict]
AS SELECT 
    SalesDistrict.SalesDistrict AS [SalesDistrictID]
,   SalesDistrictText.SalesDistrictName AS [SalesDistrict]
,   SalesDistrict.[t_applicationId]
FROM 
    [base_s4h_cax].[I_SalesDistrict] SalesDistrict
LEFT JOIN 
    [base_s4h_cax].[I_SalesDistrictText] SalesDistrictText
    ON 
        SalesDistrict.[SalesDistrict] = SalesDistrictText.[SalesDistrict]
        AND 
        SalesDistrictText.[Language] = 'E'
-- WHERE 
--     SalesDistrict.MANDT = 200 
--     AND 
--     SalesDistrictText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
