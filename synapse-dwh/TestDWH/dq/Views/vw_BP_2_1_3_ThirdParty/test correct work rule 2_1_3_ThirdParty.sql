CREATE PROCEDURE [tc.dq.vw_BP_2_1_3_ThirdParty].[test correct work rule 2_1_3_ThirdParty]
AS
BEGIN
    IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--Select customers with CashPlanningGroup='E2' and I_Customer.Country<> I_CompanyCode.Country - this is not error.
--Select customers with CashPlanningGroup<>'E2'(equal E1, NULL, BLANK) and I_Customer.Country<> I_CompanyCode.Country - this is error.
--Select customers with CashPlanningGroup='E3' and I_Customer.Country= I_CompanyCode.Country - this is not error.
--Select customers with CashPlanningGroup<>'E3'(E1, BLANK or NULL) and I_Customer.Country= I_CompanyCode.Country - this is error.
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Customer]';
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CustomerCompany]';
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CompanyCode]';

    INSERT INTO [base_s4h_cax].[I_Customer] ([Customer],[Country])
    VALUES ('1','IT'), ('2','IT'), ('3','CH'),('3','IT'),('4','CH');

    INSERT INTO [base_s4h_cax].[I_CustomerCompany] ([Customer],[CompanyCode],[CashPlanningGroup])
    VALUES ('1','CH35','E2'), ('2','CH35','E3'), ('2','CH35',NULL), ('2','CH35',''),
    ('4','CH35','E1'),('4','CH35',NULL),('4','CH35','');

    INSERT INTO [base_s4h_cax].[I_CompanyCode] ([CompanyCode],[Country])
    VALUES ('IT35','IT'), ('CH35','CH');

     -- Act:
    SELECT [Customer],[Country]
    INTO actual
    FROM [dq].[vw_BP_2_1_3_ThirdParty]

    SELECT TOP(0) *
    INTO expected
    FROM actual;

    INSERT INTO expected([Customer],[Country])
    VALUES ('2','IT'),('4','CH');

    -- Assert:
    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
