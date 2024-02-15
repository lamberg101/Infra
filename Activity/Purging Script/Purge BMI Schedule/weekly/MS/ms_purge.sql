set head on
set array 1
set linesize 10000
set pagesize 50000
set long 10000
set echo on
set trimspool on
set colsep ';'
set numformat 9999999999999999.99

set verify off

col spoolname new_value spoolname
select 'ms_purge_archive_'||to_char(sysdate,'ddmmyyyy')||'.spl' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;

set timing on

DECLARE 
err ertbs_msgs.err_code%TYPE;
err_upd EXCEPTION;
l_param_val number:= 365;

begin
  
  IF NOT fcc114.mspks_purge_archive.fn_archive_ms(l_param_val) THEN
 	   RAISE err_upd;
   
   END IF;

exception
    when err_upd then
      dbms_output.put_line('error'||err);
	  when others then 
	   dbms_output.put_line('error occured');
END;     
/

COMMIT;

/

set timing off

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') end from dual;

Spool OFF;
exit;
