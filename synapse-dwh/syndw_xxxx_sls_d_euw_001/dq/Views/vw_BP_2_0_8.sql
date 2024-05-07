CREATE VIEW [dq].[vw_BP_2_0_8]
  AS  

WITH TaxNumber AS(
SELECT
        BPTN.[BPTAXTYPE]
    ,   BPTN.[BPTAXNUMBER]
FROM
    [base_s4h_cax].[I_Businesspartnertaxnumber] BPTN
INNER JOIN
    [base_s4h_cax].[I_BusinessPartner] BP
    ON
        BPTN.[BUSINESSPARTNER] = BP.[BusinessPartner]
WHERE
    BP.[IsMarkedForArchiving] <> 'X'
GROUP BY
        BPTN.[BPTAXTYPE]
    ,   BPTN.[BPTAXNUMBER]
HAVING
    COUNT(*)>1)
SELECT    
      BPTN.[BUSINESSPARTNER]
    , BPTN.[BPTAXTYPE]
    , BPTN.[BPTAXNUMBER]
    , BPTN.[BPTAXLONGNUMBER]
    , BPTN.[AUTHORIZATIONGROUP]
    ,   '2.0.8' AS [RuleID]
    ,   1 AS [Count]
FROM
    TaxNumber
INNER JOIN
    [base_s4h_cax].[I_Businesspartnertaxnumber] BPTN
    ON
        TaxNumber.[BPTAXTYPE] = BPTN.[BPTAXTYPE]
        AND
        TaxNumber.[BPTAXNUMBER] = BPTN.[BPTAXNUMBER]
