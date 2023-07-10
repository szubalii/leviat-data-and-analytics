CREATE VIEW [dbo].[vw_delta_load_entities] AS

SELECT
  entity_id
FROM
  entity
WHERE
  update_mode = 'Delta'
