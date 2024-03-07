CREATE PROCEDURE [tc.dbo.svf_get_adls_directory_path].[test returns correct output]
AS
BEGIN  
  -- Act: 
  DECLARE @actual VARCHAR(170) = ( SELECT dbo.svf_get_adls_directory_path(
    'FACT/C_BillingDocumentItemBasixDEX/Theobald/ODP/Full', 'In', '2023-07-20 12:00:00'
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'FACT/C_BillingDocumentItemBasixDEX/Theobald/ODP/Full/In/2023/07/20', @actual;
END;
GO

