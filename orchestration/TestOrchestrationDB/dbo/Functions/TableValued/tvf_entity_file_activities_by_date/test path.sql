CREATE PROCEDURE [tc.dbo.tvf_entity_file_activities_by_date].[test In Out ADLS Path]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_adls_base_directory_path') IS NOT NULL DROP TABLE #vw_adls_base_directory_path;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable 'dbo.entity';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_adls_base_directory_path]';
  EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_required_activities', 'fake.tvf_entity_file_required_activities';

  /*
    Workaround to ingest mock data into a view
    https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
  */
  SELECT TOP(0) *
  INTO #vw_adls_base_directory_path
  FROM dbo.vw_adls_base_directory_path
   
  INSERT INTO #vw_adls_base_directory_path (
    entity_id,
    base_dir_path
  )
  VALUES
    (0, 'FULL');

  EXEC ('INSERT INTO dbo.vw_adls_base_directory_path SELECT * FROM #vw_adls_base_directory_path');

  INSERT INTO entity (entity_id, update_mode)
  VALUES
    (0, 'Full');

  -- Act: 
  SELECT
    entity_id, adls_directory_path_In, adls_directory_path_Out
  INTO actual
  FROM dbo.tvf_entity_file_activities_by_date('2023-07-23', 0);

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    adls_directory_path_In VARCHAR(100),
    adls_directory_path_Out VARCHAR(100)
  );

  INSERT INTO expected(
    entity_id,
    adls_directory_path_In,
    adls_directory_path_Out
  )
  VALUES
    (0, 'FULL/In/2023/07/23', 'FULL/Out/2023/07/23');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

