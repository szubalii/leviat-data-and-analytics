CREATE VIEW [dm_dq].[vw_dim_BusinessPartnerTaxNumber]
AS
SELECT
    BUSINESSPARTNER     AS BusinessPartner
    , BPTAXTYPE         AS BPTaxType
    , BPTAXNUMBER       AS BPTaxNumber
FROM
    [base_s4h_cax].[I_Businesspartnertaxnumber]