set lines 1000
set pages 200
select inst_id,sid,serial#,username,machine,status
from gv$session 
where username is not null 
and status='ACTIVE';