select owner, object_name, object_type, last_ddl_time 
from dba_objects 
where owner='FCC114' 
and status ='INVALID'
and object_type not in ('SYNONYM');

select object_name, object_type, status from dba_objects 
where object_type ='PACKAGE BODY'
and status ='INVALID'
and owner='FCC114';

select owner, object_type, count(*) total 
from dba_objects 
where owner='FCC114' 
and status ='INVALID' 
group by owner, object_type 
order by 1,3;

select owner, object_type, count(*) total 
from dba_objects 
where owner='FCC114' 
and status ='INVALID' 
group by owner, object_type 
order by 1,3;

--Script Compile
select 'alter java class "' || owner || '"."' || object_name || '" compile;' 
from dba_objects 
where owner='FCC114' 
and object_type like 'JAVA%' 
and status = 'INVALID';