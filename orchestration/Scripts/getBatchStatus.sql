-- select * from layer
-- select * from location


-- select 
--     location.location_id
-- from 
--     layer
-- left join location
--     on
--         location.location_id = layer.layer_id

select 
    top 100
    batch_id,
    run_id,
    start_date_time,
    end_date_time,
    b.entity_id,
    entity_name,
    status_nk,
    b.activity_id,
    activity_nk,
    sl.layer_nk as source_layer_nk,
    tl.layer_nk as target_layer_nk,
    directory_path,
    file_name,
    output 
from batch b
left JOIN
    entity e
    on e.entity_id = b.entity_id
left JOIN
    batch_activity ba
    on ba.activity_id = b.activity_id
left JOIN
    batch_execution_status bes
    on bes.status_id = b.status_id
left JOIN
    layer sl
    on sl.layer_id = b.source_layer_id
left JOIN
    layer tl
    on tl.layer_id = b.target_layer_id
where b.entity_id = 386
order by file_name, activity_order--start_date_time desc

-- select * from [dbo].[pipeline_log]

-- select CONCAT_WS(',', '', NULL)

-- select * from batch_activity