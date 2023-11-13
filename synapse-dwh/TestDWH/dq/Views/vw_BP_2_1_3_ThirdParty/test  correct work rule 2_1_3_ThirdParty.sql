CREATE PROCEDURE [tc.dq.vw_BP_2_1_3_ThirdParty].[test correct work rule 2_1_3_ThirdParty]
AS
BEGIN
--Select customers with CashPlanningGroup='E2' and I_Customer.Country<> I_CompanyCode.Country - this is not error.
--Select customers with CashPlanningGroup<>'E2'(equal E1, NULL, BLANK) and I_Customer.Country<> I_CompanyCode.Country - this is not error.
--Select customers with CashPlanningGroup='E3' and I_Customer.Country= I_CompanyCode.Country - this is not error.
--Select customers with CashPlanningGroup<>'E3'(E1, BLANK or NULL) and I_Customer.Country= I_CompanyCode.Country - this is error.
    
    IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

    -- Assemble: Fake Table
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Customer]';
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CustomerCompany]';

    INSERT INTO [base_s4h_cax].[I_Customer] ([Customer],[CustomerAccountGroup])
    VALUES ('1','Z099'), ('2','Z099'), ('3','Z008');

    INSERT INTO [base_s4h_cax].[I_CustomerCompany] ([Customer],[CashPlanningGroup])
    VALUES ('1','E4'), ('2','E3'), ('2',NULL), ('2',''), ('3', 'E4');

     -- Act:
    SELECT [Customer],[CustomerAccountGroup]
    INTO actual
    FROM [dq].[2_1_3_ThirdParty]

    SELECT TOP(0) *
    INTO expected
    FROM actual;

    INSERT INTO expected([Customer],[CustomerAccountGroup])
    VALUES ('2','E3'), ('2',NULL), ('2','');

    -- Assert:
    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
