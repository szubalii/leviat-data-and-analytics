CREATE VIEW [dm_dq].[vw_dim_BusinessPartner]
AS
SELECT
    BusinessPartner
    , BusinessPartnerCategory
    , OrganizationBPName1
    , IsMarkedForArchiving
    , SearchTerm1
FROM
    [base_s4h_cax].[I_BusinessPartner]