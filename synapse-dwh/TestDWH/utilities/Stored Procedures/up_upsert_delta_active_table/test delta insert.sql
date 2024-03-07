CREATE PROCEDURE [tc.utilities.up_upsert_delta_active_table].[test delta insert]
AS
BEGIN

  
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  -- EXEC tSQLt.FakeTable '[base_s4h_cax]', '[_active]';
  -- EXEC tSQLt.FakeTable '[base_s4h_cax]', '[_delta]';

  
  TRUNCATE TABLE [base_s4h_cax].[_active];
  TRUNCATE TABLE [base_s4h_cax].[_delta];
  
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
    (1, '',   0, 1, 3, 'D', '2024-01-02'),
    (2, 'U',  1, 2, 2, 'E', '2024-01-02'),
    (2, 'D', -1, 2, 3, 'F', '2024-01-02'),
    (2, 'C',  1, 3, 1, 'G', '2024-01-02');

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
    (1, 1, 'A', 'I', '2024-01-01'),
    (1, 2, 'B', 'I', '2024-01-01'),
    (2, 1, 'C', 'I', '2024-01-01'),
    (1, 3, 'D', 'I', '2024-01-02'),
    (2, 2, 'E', 'I', '2024-01-02'),
    (2, 3, 'F', 'D', '2024-01-02'),
    (3, 1, 'G', 'I', '2024-01-02');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END