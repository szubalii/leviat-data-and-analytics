CREATE PROCEDURE [tc.dq.vw_BP_2_1_6].[test correct work rule 2_1_6]
AS
BEGIN
    IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

    -- Assemble: Fake Table
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CustomerCompany]';
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_BusinessPartnerBank]';

    INSERT INTO [base_s4h_cax].[I_CustomerCompany] ([Customer],[PaymentMethodsList])
    VALUES ('1','F'), ('2','F'), ('3','E'), ('4','E');

    INSERT INTO [base_s4h_cax].[I_BusinessPartnerBank] ([BUSINESSPARTNER],[CollectionAuthInd])
    VALUES ('1',NULL),  ('2',''), ('3',NULL),('4','');

     -- Act:
    SELECT *
    INTO actual
    FROM dq.vw_2_1_6

    SELECT TOP(0) *
    INTO expected
    FROM actual;

    INSERT INTO expected([Customer],[PaymentMethodsList])
    VALUES ('1','F'),('2','F');

    -- Assert:
    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
