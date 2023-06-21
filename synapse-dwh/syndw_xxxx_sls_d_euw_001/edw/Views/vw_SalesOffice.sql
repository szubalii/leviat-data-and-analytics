CREATE VIEW [edw].[vw_SalesOffice]
AS
WITH SalesOffice AS (
     SELECT 
	     [SalesOffice]     AS [SalesOfficeID]
     FROM
          [base_s4h_cax].[I_SalesOfficeText] SalesOfficeText
          -- AND
          -- SalesOfficeText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
UNION 
     SELECT 
	     [SalesOfficeID]
     FROM
          [map_AXBI].[SalesOffice]
)

SELECT 
      [SalesOfficeID], 
      COALESCE([SalesOfficeName], [SalesOfficeID]) AS [SalesOffice]
FROM  SalesOffice
LEFT JOIN 
       [base_s4h_cax].[I_SalesOfficeText] SalesOfficeText
    ON 
      SalesOffice.SalesOfficeID = SalesOfficeText.SalesOffice 
    AND 
       SalesOfficeText.[Language] = 'E' 