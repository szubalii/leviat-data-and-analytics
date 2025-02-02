CREATE FUNCTION fake.tvf_entity_file_activity_requirements (@date DATE, @rerunSuccessfulFullEntities BIT = 0)
RETURNS TABLE
AS
RETURN
  SELECT mock.*
  FROM ( VALUES
    (0, 1, 'FULL_2023_07_22_12_00_00_000.parquet', '2023-07-22', NULL, '{}'),
    (1, 1, 'FULL_2023_07_22_12_00_00_000.parquet', '2023-07-22', '[]', '{}'),
    (2, 1, 'DELTA_2023_07_24_12_00_00_000.parquet', '2023-07-22', '["TestDuplicates"]', '{}'),
    (3, 2, 'DELTA_2023_07_24_12_00_00_000.parquet', '2023-07-22', '["TestDuplicates"]', '{}')
  ) AS mock (
    entity_id,
    layer_id,
    file_name,
    trigger_date,
    required_activities,
    skipped_activities
  );
