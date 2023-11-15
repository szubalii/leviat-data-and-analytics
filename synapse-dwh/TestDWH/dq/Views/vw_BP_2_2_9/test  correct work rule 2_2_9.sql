CREATE PROCEDURE [tc.dq.vw_BP_2_2_9].[test correct work rule 2_2_9]
AS
BEGIN
    IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

    -- Assemble: Fake Table
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_BusinessPartner]';

    INSERT INTO [base_s4h_cax].[I_BusinessPartner]([BusinessPartner],[BusinessPartnerGrouping],[CreatedByUser])
    VALUES ('1','Z008','BP_USER'), ('2','Z008','BP_SYNC'),('3','Z099','BP_SYNC'),('4','Z099','BP_USER');

     -- Act:
    SELECT
        [BusinessPartner],
        [BusinessPartnerGrouping],
        [CreatedByUser]
    INTO actual
    FROM [dq].[vw_BP_2_2_9]

    SELECT TOP(0) *
    INTO expected
    FROM actual;

    INSERT INTO expected([BusinessPartner],[BusinessPartnerGrouping],[CreatedByUser])
    VALUES ('1','Z008','BP_USER');

    -- Assert:
    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
