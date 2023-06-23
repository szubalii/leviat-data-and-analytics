CREATE VIEW [dq].[vw_BP_2_0_1]
  AS

WITH BankAccountData AS(
SELECT
        BPB.[BANKCOUNTRYKEY]
    ,   BPB.[BANKNUMBER]
    ,   BPB.[BankAccount]
    ,   COUNT(*) AS [COUNT]
FROM
    [base_s4h_cax].[I_BusinessPartnerBank] BPB
GROUP BY    
        BPB.[BANKCOUNTRYKEY]
    ,   BPB.[BANKNUMBER]
    ,   BPB.[BankAccount]
HAVING
    COUNT(*)>1)
SELECT
        BPB.[BUSINESSPARTNER]
    ,   BPB.[BANKIDENTIFICATION]
    ,   BPB.[BANKCOUNTRYKEY]
    ,   BPB.[BANKNAME]
    ,   BPB.[BANKNUMBER]
    ,   BPB.[SWIFTCode]
    ,   BPB.[BankControlKey]
    ,   BPB.[BankAccountHolderName]
    ,   BPB.[BankAccountName]
    ,   BPB.[ValidityStartDate]
    ,   BPB.[ValidityEndDate]
    ,   BPB.[IBAN]
    ,   BPB.[IBANValidityStartDate]
    ,   BPB.[BankAccount]
    ,   BPB.[BankAccountReferenceText]
    ,   BPB.[CollectionAuthInd]
    ,   BPB.[BusinessPartnerExternalBankID]
    ,   BPB.[BPBankDetailsChangeDate]
    ,   BPB.[BPBankDetailsChangeTargetID]
    ,   BPB.[BPBankIsProtected]
    ,   BPB.[CityName]
    ,   BPB.[AuthorizationGroup]
    ,   '2.0.1' AS [RuleID]
    ,   1 AS [Count]
FROM
    BankAccountData
JOIN
    [base_s4h_cax].[I_BusinessPartnerBank] BPB
    ON  
        BankAccountData.[BANKCOUNTRYKEY] = BPB.[BANKCOUNTRYKEY]
        AND
        BankAccountData.[BANKNUMBER] = BPB.[BANKNUMBER]
        AND
        BankAccountData.[BankAccount] = BPB.[BankAccount]