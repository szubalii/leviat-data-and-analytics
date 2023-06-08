CREATE VIEW [dq].[vw_BP_2_0_1]
  AS

SELECT
        CONCAT(BPB.[BANKCOUNTRYKEY],BPB.[BANKNUMBER],BPB.[BankAccount]) AS [BankInfo]
    ,   '2.0.1' AS [RuleID]
    ,   COUNT(*) AS [COUNT]
FROM
    [base_s4h_cax].[I_BusinessPartnerBank] BPB
GROUP BY
    CONCAT(BPB.[BANKCOUNTRYKEY],BPB.[BANKNUMBER],BPB.[BankAccount]),
    '2.0.1'
HAVING
    COUNT(*)>1