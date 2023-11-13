CREATE PROCEDURE [tc.dq.vw_BP_2_2_9].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_BusinessPartner]';

  INSERT INTO [base_s4h_cax].[I_BusinessPartner]([BusinessPartner],[BusinessPartnerGrouping],[CreatedByUser])
  VALUES ('1','Z008','BP_USER'), ('1','Z008','BP_USER');

  
  SELECT
    [BusinessPartner],
    [BusinessPartnerGrouping],
    [CreatedByUser]
  INTO actual
  FROM [dq].[vw_BP_2_2_9]
  GROUP BY
    [Supplier]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
