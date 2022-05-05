select * from get_scheduled_entity_batch_activities(0,'2022/05/02')
where entity_name in ('I_CostCenter_F', 'DATAAREA', 'ITEM_GROUPS')

select * from get_scheduled_edw_entity_batch_activities(0,'2022/05/02')