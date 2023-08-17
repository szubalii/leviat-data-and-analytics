CREATE VIEW [dm_dq].[vw_dim_CustomerSalesPartnerFunction]
AS
SELECT
    CUSTOMER            AS Customer
    , SalesOrganization
    , Division
    , PartnerCounter
    , DistributionChannel 
    , PartnerFunction
    , BPCustomerNumber
FROM
    [base_s4h_cax].[I_CustSalesPartnerFunc]