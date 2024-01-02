CREATE VIEW [edw].[vw_Latest_HKUNNR]
AS
WITH
LatestCustomerNum AS (
    SELECT
          HKUNNR,
          KUNNR,
          VKORG,
          VTWEG,
          SPART,
          DATAB,
          ROW_NUMBER() OVER (PARTITION BY KUNNR ORDER BY DATAB DESC) AS rn
    FROM [base_s4h_cax].[KNVH] 
)
SELECT
       HKUNNR,
       KUNNR,
       VKORG,
       VTWEG,
       SPART,
       DATAB
FROM
    LatestCustomerNum
WHERE
    rn = 1