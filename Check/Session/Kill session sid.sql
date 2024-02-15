select 'ALTER SYSTEM KILL SESSION '''||sid||','||serial#||',@'||inst_id||''' IMMEDIATE;' 
FROM gv$session 
where sid='&sid'
ORDER BY inst_id;