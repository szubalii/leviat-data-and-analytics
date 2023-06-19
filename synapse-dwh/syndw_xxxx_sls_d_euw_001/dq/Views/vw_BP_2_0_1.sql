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
        [BUSINESSPARTNER]
    ,   [BANKIDENTIFICATION]
    ,   [BANKCOUNTRYKEY]
    ,   [BANKNAME]
    ,   [BANKNUMBER]
    ,   [SWIFTCode]
    ,   [BankControlKey]
    ,   [BankAccountHolderName]
    ,   [BankAccountName]
    ,   [ValidityStartDate]
    ,   [ValidityEndDate]
    ,   [IBAN]
    ,   [IBANValidityStartDate]
    ,   [BankAccount]
    ,   [BankAccountReferenceText]
    ,   [CollectionAuthInd]
    ,   [BusinessPartnerExternalBankID]
    ,   [BPBankDetailsChangeDate]
    ,   [BPBankDetailsChangeTargetID]
    ,   [BPBankIsProtected]
    ,   [CityName]
    ,   [AuthorizationGroup]
    ,   '2.0.1' AS [RuleID]
    ,   1 AS [Count]
FROM
    BankAccountData
JOIN
    [base_s4h_cax].[I_BusinessPartnerBank] BPB
    ON  
        [BankInfo] = CONCAT(BPB.[BANKCOUNTRYKEY],'|',BPB.[BANKNUMBER],'|',BPB.[BankAccount])
ORDER BY 
    BPB.[BANKCOUNTRYKEY],BPB.[BANKNUMBER],BPB.[BankAccount]