CREATE FUNCTION [edw].[svf_getFullAddress](
    @StreetName NVARCHAR(60),
    @HouseNumber NVARCHAR(10),
    @PostalCode NVARCHAR(10),
    @CityName NVARCHAR(40),
    @Country NVARCHAR(50)
)
RETURNS NVARCHAR(170)
AS
BEGIN
  RETURN CONCAT_WS(
    ' ',
    @StreetName,
    @HouseNumber,
    @PostalCode,
    @CityName,
    @Country
  );
END
