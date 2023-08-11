CREATE VIEW [dm_dq].[vw_dim_BusinessPartnerBank]
AS
SELECT
    BUSINESSPARTNER
    , BANKCOUNTRYKEY
    , CollectionAuthInd
    , BANKNUMBER
    , BankAccount
FROM
    [base_s4h_cax].[I_BusinessPartnerBank]