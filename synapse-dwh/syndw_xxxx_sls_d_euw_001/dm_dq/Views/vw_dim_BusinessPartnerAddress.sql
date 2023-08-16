CREATE VIEW [dm_dq].[vw_dim_BusinessPartnerAddress]
AS
SELECT
    BUSINESSPARTNER     AS BusinessPartner
    , ADDRESSNUMBER     AS AddressNumber
    , DATETIMEFROMPARTS(
        ValidityStartDate / 10000000000
        ,ValidityStartDate % 10000000000 / 100000000
        ,ValidityStartDate % 100000000 / 1000000
        ,ValidityStartDate % 1000000 / 10000
        ,ValidityStartDate % 10000 / 100
        ,ValidityStartDate % 100
        ,0
    )                   AS ValidityStartDate
    , DATETIMEFROMPARTS(
        ValidityEndDate / 10000000000
        ,ValidityEndDate % 10000000000 / 100000000
        ,ValidityEndDate % 100000000 / 1000000
        ,ValidityEndDate % 1000000 / 10000
        ,ValidityEndDate % 10000 / 100
        ,ValidityEndDate % 100
        ,0
    )                   AS ValidityEndDate
FROM
    [base_s4h_cax].[I_BusinessPartnerAddress]