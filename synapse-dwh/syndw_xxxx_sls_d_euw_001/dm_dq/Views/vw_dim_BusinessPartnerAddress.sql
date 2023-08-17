CREATE VIEW [dm_dq].[vw_dim_BusinessPartnerAddress]
AS
SELECT
    BUSINESSPARTNER     AS BusinessPartner
    , ADDRESSNUMBER     AS AddressNumber
    , ValidityStartDate
    , ValidityEndDate
FROM
    [base_s4h_cax].[I_BusinessPartnerAddress]