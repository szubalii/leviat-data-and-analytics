/*
  Return the first file for each entity for which there is a non successful log activity

*/
CREATE VIEW [dbo].[vw_first_failed_file]
AS

SELECT
  entity_id,
  MIN(file_name) AS file_name
FROM
  vw_first_failed_activity_order
GROUP BY
  entity_id
