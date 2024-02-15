select distinct 
	a.INST_ID id,''''||sid||','||serial#||',@'||a.inst_id||'''' "'SID,SRL#,@INS'", 
	c.status, 
	object_name, 
	decode(object_type,'TABLE PARTITION','TABLE','INDEX PARTITION','INDEX','LOB PARTITION','LOB',object_type) type, 
	oracle_username usrnme, 
	os_user_name osuser, 
	c.logon_time,
	sql_id,
	event,
	LAST_CALL_ET lastcall,
	decode(locked_mode, 0,'(0)None', 1,'(1)Null', 2,'(2)Row Share', 3,'(3)Row Exclu', 4,'(4)Share', 5,'(5)Share Row Ex',6,'(6)Exclusive') locked_mode 
from 
	gv$locked_object a, 
	dba_objects b, 
	gv$session c 
where a.object_id=b.object_id 
	and a.session_id=c.sid 
	and a.inst_id = c.inst_id 
	order by 1,2;
