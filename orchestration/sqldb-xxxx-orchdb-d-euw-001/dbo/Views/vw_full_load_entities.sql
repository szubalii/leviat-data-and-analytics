CREATE VIEW [dbo].[vw_full_load_entities] AS

SELECT
  entity_id
FROM
  entity
WHERE
  update_mode = 'Full'
  OR
  update_mode IS NULL
