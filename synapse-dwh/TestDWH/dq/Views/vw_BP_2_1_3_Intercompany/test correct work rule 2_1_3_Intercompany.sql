CREATE PROCEDURE [tc.dq.vw_BP_2_1_3_Intercompany].[test correct work rule 2_1_3_Intercompany]
AS
BEGIN
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
    FROM [dq].[vw_BP_2_1_3_Intercompany]

    SELECT TOP(0) *
    INTO expected
    FROM actual;

    INSERT INTO expected([Customer],[CustomerAccountGroup])
    VALUES ('2','Z099');

    -- Assert:
    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
