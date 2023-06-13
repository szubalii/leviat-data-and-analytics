CREATE VIEW [dq].[vw_BP_2_0_1]
  AS

WITH BankAccountData AS(
SELECT
        CONCAT(BPB.[BANKCOUNTRYKEY],'|',BPB.[BANKNUMBER],'|',BPB.[BankAccount]) AS [BankInfo]
    ,   COUNT(*) AS [COUNT]
FROM
    [base_s4h_cax].[I_BusinessPartnerBank] BPB
GROUP BY
    CONCAT(BPB.[BANKCOUNTRYKEY],'|',BPB.[BANKNUMBER],'|',BPB.[BankAccount])
HAVING
    COUNT(*)>1)
SELECT
    [BankInfo]
    ,   '2.0.1' AS [RuleID]
    ,   1 AS [Count]
FROM BankAccountData