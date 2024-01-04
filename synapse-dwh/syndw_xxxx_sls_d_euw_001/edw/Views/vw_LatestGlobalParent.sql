CREATE VIEW [edw].[vw_LatestGlobalParent]
AS -- find  the latest available GlobalParentID for the CustomerID, SalesOrganizationID, DistributionChannel and Division
WITH
LatestCustomerNum AS (
    SELECT
          KUNNR AS CustomerID,
          VKORG AS SalesOrganizationID,
          VTWEG AS DistributionChannel,
          SPART AS Division,
          DATAB AS ValidityStartDate,
          HKUNNR AS GlobalParentID,
          ROW_NUMBER() OVER (PARTITION BY KUNNR ORDER BY DATAB DESC) AS rn
    FROM [base_s4h_cax].[KNVH] 
)
SELECT
       CustomerID,
       SalesOrganizationID,
       DistributionChannel,
       Division,
       ValidityStartDate,
       GlobalParentID
FROM
    LatestCustomerNum
WHERE
    rn = 1