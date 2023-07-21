CREATE VIEW [dbo].[vw_entity_file_activity]
AS
SELECT
  ef.entity_id,
  ef.update_mode,
  ef.file_name,
  la.activity_id AS expected_activity_id
FROM
  [dbo].[vw_entity_file] ef
LEFT JOIN
  [layer_activity] la
  ON
    la.layer_id = ef.layer_id
