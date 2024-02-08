CREATE PROCEDURE [tc.utilities.up_upsert_delta_active_table].[test delta delete]
AS
BEGIN

  
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[_active]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[_delta]';

  -- truncate table [base_s4h_cax].[_active]

  INSERT INTO [base_s4h_cax].[_active] (
    [PrimaryKeyField_1],
    [PrimaryKeyField_2],
    [NonPrimaryKeyField_1],
    [t_lastActionCd],
    [t_extractionDtm]
  )
  VALUES
    (1, 1, 'A', 'I', '2024-01-01'),
    (1, 2, 'B', 'I', '2024-01-01'),
    (2, 1, 'C', 'I', '2024-01-01');

  INSERT INTO [base_s4h_cax].[_delta] (
    [TS_SEQUENCE_NUMBER],
    [ODQ_CHANGEMODE],
    [ODQ_ENTITYCNTR],
    [PrimaryKeyField_1],
    [PrimaryKeyField_2],
    [NonPrimaryKeyField_1],
    [t_extractionDtm]
  )
  VALUES
    (1, 'D', -1, 1, 1, 'A', '2024-01-02');

  EXEC utilities.up_upsert_delta_active_table 'base_s4h_cax', '';

  -- Act
  SELECT
    [PrimaryKeyField_1],
    [PrimaryKeyField_2],
    [NonPrimaryKeyField_1],
    [t_lastActionCd],
    [t_extractionDtm]
  INTO actual
  FROM [base_s4h_cax].[_active];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [PrimaryKeyField_1],
    [PrimaryKeyField_2],
    [NonPrimaryKeyField_1],
    [t_lastActionCd],
    [t_extractionDtm]
  )
  VALUES
    (1, 1, 'A', 'D', '2024-01-02'),
    (1, 2, 'B', 'I', '2024-01-01'),
    (2, 1, 'C', 'I', '2024-01-01');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

  -- select * from actual
  -- select * from expected

END