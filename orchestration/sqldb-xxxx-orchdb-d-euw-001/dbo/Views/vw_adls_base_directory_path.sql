CREATE VIEW [dbo].[vw_adls_base_directory_path]
AS 
SELECT
  entity_id,
  layer_nk,
  CASE
    WHEN l.[layer_nk] = 'S4H'
    THEN CONCAT_WS('/',
      e.[data_category],
      e.[entity_name],
      e.[tool_name],
      e.[extraction_type],
      e.[update_mode]
    )
    ELSE [entity_name]
  END AS base_dir_path
FROM [dbo].[entity] e
LEFT JOIN [dbo].[layer] l
  ON l.layer_id = e.layer_id
