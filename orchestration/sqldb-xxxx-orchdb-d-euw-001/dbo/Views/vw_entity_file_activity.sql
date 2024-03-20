/*
  Returns the expected activities to run for each 
  entity file combination
*/
CREATE VIEW [dbo].[vw_entity_file_activity]
AS
SELECT
  ef.entity_id,
  ef.layer_id,
  ef.file_name,
  ea.expected_activity_id
FROM
  [dbo].[vw_entity_file] ef
LEFT JOIN
  [vw_entity_activity] ea
  ON
    ea.entity_id = ef.entity_id

