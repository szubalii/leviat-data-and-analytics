CREATE PROCEDURE [tc.dq.vw_BP_2_1_3_Intercompany].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Customer]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CustomerCompany]';

  INSERT INTO [base_s4h_cax].[I_Customer] ([Customer],[CustomerAccountGroup])
  VALUES ('1','Z099'), ('2','Z099'), ('3','Z008');

  INSERT INTO [base_s4h_cax].[I_CustomerCompany] ([Customer],[CashPlanningGroup])
  VALUES ('1','E4'), ('2','E3'), ('2',NULL), ('2',''), ('3', 'E4');

  -- Act: 
  SELECT
    [Customer],
    [CustomerAccountGroup]
  INTO actual
  FROM [dq].[vw_BP_2_1_3_Intercompany]
  GROUP BY
    [Customer],
    [CustomerAccountGroup]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
