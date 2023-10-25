CREATE PROCEDURE [tc.dq.vw_BP_2_2_2].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Supplier]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SupplierCompany]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CompanyCode]';

  INSERT INTO [base_s4h_cax].[I_Supplier] ([Supplier])
  VALUES ('1'),  ('2');

  INSERT INTO [base_s4h_cax].[I_SupplierCompany] ([Supplier],[CompanyCode])
  VALUES ('1','IT35'),  ('1','DE35'), ('2','DE35'),('2','IT35');

  INSERT INTO [base_s4h_cax].[I_CompanyCode] ([CompanyCode],[Country])
  VALUES ('IT35','IT'),  ('IT01','IT'), ('DE35','DE');

  
  SELECT
    [Supplier]
  INTO actual
  FROM [dq].[vw_BP_2_2_2]
  GROUP BY
    [Supplier]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
