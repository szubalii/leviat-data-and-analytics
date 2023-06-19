CREATE VIEW [dq].[vw_BP_2_0_8]
  AS  

WITH TaxNumber AS(
SELECT
        CONCAT(BPTN.[BPTAXTYPE],'|',BPTN.[BPTAXNUMBER]) AS [TaxNumber]
    ,   COUNT(*) AS [COUNT]
FROM
    [base_s4h_cax].[I_Businesspartnertaxnumber] BPTN
GROUP BY
    CONCAT(BPTN.[BPTAXTYPE],'|',BPTN.[BPTAXNUMBER])
HAVING
    COUNT(*)>1)
SELECT    
      [BUSINESSPARTNER]
    , [BPTAXTYPE]
    , [BPTAXNUMBER]
    , [BPTAXLONGNUMBER]
    , [AUTHORIZATIONGROUP]
    ,   '2.0.8' AS [RuleID]
    ,   1 AS [Count]
FROM
    TaxNumber
JOIN
    [base_s4h_cax].[I_Businesspartnertaxnumber] BPTN
    ON
        TaxNumber.[TaxNumber] = CONCAT(BPTN.[BPTAXTYPE],'|',BPTN.[BPTAXNUMBER])
ORDER BY
    BPTN.[BPTAXTYPE],BPTN.[BPTAXNUMBER]
