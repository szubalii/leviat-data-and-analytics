CREATE PROCEDURE [tc.dq.vw_BP_2_2_2].[test correct work rule 2_2_2]
AS
BEGIN

    IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

    -- Assemble: Fake Table
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Supplier]';
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SupplierCompany]';
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CompanyCode]';
    
    INSERT INTO [base_s4h_cax].[I_Supplier]([Supplier],[SupplierAccountGroup],[Country])
    VALUES('1','Z008','IT'),('2','Z008','IT'),('3','Z099','IT'),
    ('4','Z001','FR'),('5','Z001','IT'),('6','Z099','IT');

    INSERT INTO [base_s4h_cax].[I_SupplierCompany]([Supplier],[CompanyCode],[CashPlanningGroup])
    VALUES ('1','A1','FR35'),('2','A2','IT35'),('3','A1','FR35'),
    ('4','A2','FR35'),('5','A2','FR35'),('6','A2','IT35');

    INSERT INTO [base_s4h_cax].[I_CompanyCode]([CompanyCode],[Country])
    VALUES('IT35','IT'),('FR35','FR');

    -- Act:
    SELECT
        [Supplier],
        [SupplierAccountGroup],
        [Country]
    INTO actual
    FROM [dq].[vw_BP_2_2_2]

    SELECT TOP(0) *
    INTO expected
    FROM actual;

    INSERT INTO expected([Supplier],[SupplierAccountGroup],[Country])
    VALUES ('3','Z099','IT'),('4','Z001','FR');

    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
