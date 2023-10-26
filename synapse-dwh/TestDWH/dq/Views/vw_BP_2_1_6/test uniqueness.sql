CREATE PROCEDURE [tc.dq.vw_BP_2_1_6].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CustomerCompany]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_BusinessPartnerBank]';

  INSERT INTO [base_s4h_cax].[I_CustomerCompany] ([Customer],[CompanyCode],[PaymentMethodsList])
  VALUES ('1','DE35','F'), ('1','CH35','F');

  INSERT INTO [base_s4h_cax].[I_BusinessPartnerBank] ([BUSINESSPARTNER],[BANKIDENTIFICATION],[CollectionAuthInd])
  VALUES ('1','0001',NULL), ('1','0001',''), ('1','0002','');

  -- Act: 
  SELECT
    [Customer],
    [CompanyCode]
  INTO actual
  FROM [dq].[vw_BP_2_1_6]
  GROUP BY
    [Customer],
    [CompanyCode]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
