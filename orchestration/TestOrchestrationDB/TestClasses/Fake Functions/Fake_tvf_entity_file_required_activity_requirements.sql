CREATE FUNCTION [tc.dbo.FakeFunctions].Fake_tvf_entity_file_required_activity_requirements (@rerunSuccessfulFullEntities BIT = 0)

  RETURNS TABLE
  AS
  RETURN
    SELECT mock.*
    FROM ( VALUES
      (0, 1, NULL, NULL, NULL, NULL),
      (1, 1, NULL, NULL, NULL, '[]'),
      (2, 1, NULL, NULL, NULL, '["TestDuplicates"]')
    ) AS mock (
      entity_id,
      layer_id,
      file_name,
      trigger_date,
      skipped_activities,
      required_activities
    );
GO
