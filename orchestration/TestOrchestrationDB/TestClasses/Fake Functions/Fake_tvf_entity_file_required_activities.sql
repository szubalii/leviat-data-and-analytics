CREATE FUNCTION [tc.dbo.FakeFunctions].Fake_tvf_entity_file_required_activities (@rerunSuccessfulFullEntities BIT = 0)

  RETURNS TABLE
  AS
  RETURN
    SELECT mock.*
    FROM ( VALUES
      (0, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
      (0, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
      (1, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
      (1, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
      (2, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
      (2, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
      (3, NULL, NULL, NULL, '["TestDuplicates"]', NULL)
    ) AS mock (
      entity_id,
      layer_id,
      file_name,
      trigger_date,
      required_activities,
      skipped_activities
    );
GO
