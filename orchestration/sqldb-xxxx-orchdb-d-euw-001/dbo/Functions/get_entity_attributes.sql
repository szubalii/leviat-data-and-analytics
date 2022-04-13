CREATE FUNCTION [dbo].[get_entity_attributes](
    @date DATE
) RETURNS TABLE
AS RETURN
WITH baseDirPath AS (
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
        END AS baseDirPath
    FROM [dbo].[entity] e
    LEFT JOIN [dbo].[layer] l
        ON l.layer_id = e.layer_id
)

SELECT
    ent.[entity_id],
    ent.[entity_name],
    baseDirPath.[layer_nk],
    ent.[adls_container_name],
    baseDirPath.baseDirPath + '/In/' + FORMAT(@date, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_In,
    baseDirPath.baseDirPath + '/Out/' + FORMAT(@date, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_Out,
    ent.[data_category],
    ent.[client_field],
    ent.[tool_name],
    ent.[extraction_type],
    ent.[update_mode],
    ent.[base_schema_name],
    ent.[base_table_name],
    ent.[base_sproc_name],
    ent.[axbi_database_name],
    ent.[axbi_schema_name],
    ent.[axbi_date_field_name],
    ent.[edw_sproc_schema_name],
    ent.[edw_sproc_name],
    ent.[edw_source_schema_name],
    ent.[edw_source_view_name],
    ent.[edw_dest_schema_name],
    ent.[edw_dest_table_name],
    ent.[edw_execution_order],
    ent.[pk_field_names]
FROM
    [dbo].[entity] ent
LEFT JOIN
    baseDirPath
    ON
        baseDirPath.entity_id = ent.entity_id
