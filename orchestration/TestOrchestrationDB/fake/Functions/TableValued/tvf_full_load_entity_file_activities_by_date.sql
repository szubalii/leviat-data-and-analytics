-- CREATE FUNCTION fake.tvf_full_load_entity_file_activities_by_date (@date DATE, @rerunSuccessfulFullEntities BIT = 0)

-- RETURNS TABLE
-- AS
-- RETURN
--   SELECT mock.*
--   FROM ( VALUES
--     (1, 6, 'FULL_2024-01-01.parquet', '2024-01-01', '["TestDuplicates"]', NULL),
--     (1, 6, 'FULL_2024-01-01.parquet', '2024-01-01', '["TestDuplicates"]', NULL),
--     (1, 6, 'FULL_2024-01-01.parquet', '2024-01-01', '["TestDuplicates"]', NULL),
--     (1, 6, 'FULL_2024-01-01.parquet', '2024-01-01', '["TestDuplicates"]', NULL),
--     (1, 6, 'FULL_2024-01-01.parquet', '2024-01-01', '["TestDuplicates"]', NULL),
--     (1, 6, 'FULL_2024-01-01.parquet', '2024-01-01', '["TestDuplicates"]', NULL),
--     (3, NULL, NULL, NULL, '["TestDuplicates"]', NULL)
--   ) AS mock (
--     entity_id,
--     layer_id,
--     file_name,
--     trigger_date,
--     activity_nk,
--     activity_order,
--     bacth_id,
--     status_id,
--     output,
--     isRequired
--   );
