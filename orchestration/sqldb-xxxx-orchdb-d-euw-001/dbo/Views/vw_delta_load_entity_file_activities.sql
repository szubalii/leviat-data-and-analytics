CREATE VIEW [dbo].[vw_delta_load_entity_file_activities]
AS

-- For delta entities, the date should NOT impact the list of required batch activities

SELECT
  efalb.entity_id,
  efalb.layer_id,
  efalb.file_name,
  efalb.trigger_date,
  efalb.activity_nk,
  efalb.activity_order,
  efalb.batch_id,
  efalb.status_id,
  efalb.output,
  [dbo].[svf_get_isRequired_delta_batch_activity](
    efalb.file_name,
    efff.first_failed_file_name,
    efalb.activity_order,
    efffa.first_failed_activity_order
  ) AS isRequired
FROM
  dbo.[vw_entity_file_activity_latest_batch] efalb
LEFT JOIN
  dbo.[vw_entity_file_first_failed_activity] efffa
  ON
    efffa.entity_id = efalb.entity_id
    AND
    efffa.file_name = efalb.file_name
LEFT JOIN
  dbo.[vw_entity_first_failed_file] efff
  ON
    efff.entity_id = efalb.entity_id
INNER JOIN
  dbo.[vw_delta_load_entities] delta
  ON
    delta.entity_id = efalb.entity_id
-- filter on those rows that contains a file_name.
-- new delta entity activities are added in tvf_entity_file_activity_by_date
WHERE
  efalb.file_name IS NOT NULL
    
GO
