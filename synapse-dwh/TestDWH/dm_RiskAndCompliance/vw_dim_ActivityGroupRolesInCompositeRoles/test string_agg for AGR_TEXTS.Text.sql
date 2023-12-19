CREATE PROCEDURE [tc.dm_RiskAndCompliance.vw_dim_ActivityGroupRolesInCompositeRoles].[test string_agg for AGR_TEXTS.Text]
AS
BEGIN

    IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

    -- Assemble: Fake Table
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[AGR_AGRS]';
    EXEC tSQLt.FakeTable '[base_s4h_cax]', '[AGR_TEXTS]';

    INSERT INTO [base_s4h_cax].[AGR_AGRS] ([Agr_Name])
    VALUES ('1');

    INSERT INTO [base_s4h_cax].[AGR_TEXTS] ([Agr_Name],[Text])
    VALUES ('1','a'),  ('1','b'), ('1','c');

     -- Act:
    SELECT [Agr_Name],[Text]
    INTO actual
    FROM [dm_RiskAndCompliance].[vw_dim_ActivityGroupRolesInCompositeRoles]

    SELECT TOP(0) *
    INTO expected
    FROM actual;

    INSERT INTO expected([Agr_Name],[Text])
    VALUES ('1','a b c');

    -- Assert:
    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
