CREATE VIEW [dm_dq].[vw_dim_BusinessPartnerBank]
AS
SELECT
    BUSINESSPARTNER         AS BusinessPartner
    , BANKCOUNTRYKEY        AS BankCountryKey
    , BANKIDENTIFICATION    AS BankIdentification
    , CollectionAuthInd
    , BANKNUMBER            AS BankNumber
    , BankAccount
FROM
    [base_s4h_cax].[I_BusinessPartnerBank]