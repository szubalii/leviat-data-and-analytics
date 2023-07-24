/*
  Returns which activities need to rerun for each entity file
*/
CREATE VIEW [dbo].[vw_entity_file_required_activity]
AS

SELECT
  efalb.entity_id,
  efalb.file_name,
  efff.first_failed_file_name,
  efalb.expected_activity_id,
  efalb.activity_nk,
  efalb.activity_order,
  efffa.first_failed_activity_order,
  efalb.batch_id,
  efalb.run_activity_id,
  efalb.start_date_time,
  efalb.status_id,
  COALESCE(efalb.output, '{}') AS [output],
  [dbo].[svf_get_isRequired_batch_activity](
    efalb.update_mode,
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
