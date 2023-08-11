CREATE VIEW [dm_dq].[vw_dim_CustomerSalesPartner]
AS
SELECT
    CUSTOMER            AS Customer
    , SalesOrganization
    , Division
    , PartnerCounter
    , PartnerFunction
    , BPCustomerNumber
FROM
    [base_s4h_cax].[I_CustSalesPartnerFunc]