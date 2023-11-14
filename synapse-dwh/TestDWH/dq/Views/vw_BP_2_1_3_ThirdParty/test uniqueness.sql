CREATE PROCEDURE [tc.dq.vw_BP_2_1_3_ThirdParty].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Customer]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CustomerCompany]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CompanyCode]';

  INSERT INTO [base_s4h_cax].[I_Customer] ([Customer],[Country])
  VALUES ('1','IT'), ('2','IT'), ('3','CH'),('3','IT');

  INSERT INTO [base_s4h_cax].[I_CustomerCompany] ([Customer],[CompanyCode],[CashPlanningGroup])
  VALUES ('1','IT35','E4'), ('2','IT35','E3'), ('2','CH35',NULL), ('2','CH35',''), ('3','IT35','E4');

  INSERT INTO [base_s4h_cax].[I_CompanyCode] ([CompanyCode],[Country])
  VALUES ('IT35','IT'), ('CH35','CH');

  -- Act: 
  SELECT
    [Customer],
    [Country]
  INTO actual
  FROM [dq].[vw_BP_2_1_3_ThirdParty]
  GROUP BY
    [Customer],
    [Country]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
