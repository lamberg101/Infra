set lines 300
col INITIAL_ALLOCATION for a17
col LIMIT_VALUE for a12
col resource_name for a30
select inst_id,resource_name,current_utilization,max_utilization,
INITIAL_ALLOCATION,LIMIT_VALUE,round(((current_utilization*100)/(INITIAL_ALLOCATION)),2) as "Process limit %"
from gv$resource_limit
where resource_name in ('sessions', 'processes');
