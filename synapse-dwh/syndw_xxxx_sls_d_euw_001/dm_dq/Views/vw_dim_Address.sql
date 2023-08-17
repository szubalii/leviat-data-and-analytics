CREATE VIEW [dm_dq].[vw_dim_Address]
AS
SELECT
    AddressID
    , District
    , Country
    , CityName
    , Region
    , PhoneNumber
FROM
    [base_s4h_cax].[I_Address]