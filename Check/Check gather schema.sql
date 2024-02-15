SET lines 300
col OPERATION FOR a30
col TARGET FOR a35
col START_TIME FOR a40
col END_TIME FOR a40
SELECT * FROM dba_optstat_operations 
where OPERATION like 'gather_schema%' 
ORDER BY start_time ASC;