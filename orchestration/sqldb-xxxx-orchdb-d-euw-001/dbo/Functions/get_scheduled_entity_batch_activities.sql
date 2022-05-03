CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS TABLE AS RETURN
    select * from get_scheduled_full_entity_batch_activities(@adhoc, @date)

    union all

    select * from get_scheduled_delta_entity_batch_activities(@adhoc, @date)
GO
