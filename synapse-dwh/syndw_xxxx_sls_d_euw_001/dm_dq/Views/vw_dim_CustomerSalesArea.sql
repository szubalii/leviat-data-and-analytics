CREATE VIEW [dm_dq].[vw_dim_CustomerSalesArea]
AS
SELECT
    Customer
    , SalesOrganization
    , DistributionChannel
    , Division
    , PaymentTerms
    , DeletionIndicator
    , DeliveryPriority
    , OrderCombinationIsAllowed
    , SlsDocIsRlvtForProofOfDeliv
    , CompleteDeliveryIsDefined
FROM
    [base_s4h_cax].[I_CustomerSalesArea]