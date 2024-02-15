set verify off

col spoolname new_value spoolname
select 'gw_archive_'||to_char(sysdate,'ddmmyyyy')||'.spl' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;

set serveroutput on;

set timing on

Declare


l_branch_date DATE;
l_purge_archive VARCHAR2(1):= 'A';
p_err_code VARCHAR2(300):= '';
p_err_params varchar2(10):= '';

BEGIN
select trunc(sysdate-365) into l_branch_date from dual;
For x in  (select branch_code from fcc114.sttm_branch  where auth_stat = 'A'  and record_stat='O') 
loop

Insert into fcc114.tab_before_purge
values('gwtb_incoming_log',x.branch_code ,(SELECT count(1) FROM fcc114.gwtb_incoming_log WHERE branch = x.branch_code AND trunc(branch_dt_stamp) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);
Insert into fcc114.tab_before_purge
values('gwtb_outgoing_log', x.branch_code ,(SELECT Count(1) FROM fcc114.gwtb_outgoing_log WHERE branch = x.branch_code AND trunc(branch_dt_stamp) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);

Insert into fcc114.tab_before_purge
values('gwth_incoming_log',x.branch_code ,(SELECT count(1) FROM fcc114.gwth_incoming_log WHERE branch = x.branch_code AND trunc(branch_dt_stamp) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);
Insert into fcc114.tab_before_purge
values('gwth_outgoing_log', x.branch_code ,(SELECT Count(1) FROM fcc114.gwth_outgoing_log WHERE branch = x.branch_code AND trunc(branch_dt_stamp) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);

BEGIN
  IF NOT  fcc114.elpks_archive.fn_archive_gwoutlog(x.branch_code,
                  l_branch_date,
                  l_purge_archive,
                  p_err_code,
                  p_err_params)
  then
    fcc114.debug.pr_debug('AC','Came back with failure from elpks_archive.fn_archive_gwoutlog'||p_err_code);
  END IF;
  
  IF NOT  fcc114.elpks_archive.fn_archive_gwinlog(x.branch_code,
                  l_branch_date,
                  l_purge_archive,
                  p_err_code,
                  p_err_params)
  then
    fcc114.debug.pr_debug('AC','Came back with failure from elpks_archive.fn_archive_gwinlog'||p_err_code);
  END IF;
  
  
END;  

Insert into fcc114.tab_after_purge
values('gwtb_incoming_log',x.branch_code ,(SELECT count(1) FROM fcc114.gwtb_incoming_log WHERE branch = x.branch_code AND trunc(branch_dt_stamp) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);
Insert into fcc114.tab_after_purge
values('gwtb_outgoing_log', x.branch_code ,(SELECT Count(1) FROM fcc114.gwtb_outgoing_log WHERE branch = x.branch_code AND trunc(branch_dt_stamp) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);

Insert into fcc114.tab_after_purge
values('gwth_incoming_log',x.branch_code ,(SELECT count(1) FROM fcc114.gwth_incoming_log WHERE branch = x.branch_code AND trunc(branch_dt_stamp) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);
Insert into fcc114.tab_after_purge
values('gwth_outgoing_log', x.branch_code ,(SELECT Count(1) FROM fcc114.gwth_outgoing_log WHERE branch = x.branch_code AND trunc(branch_dt_stamp) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);

fcc114.debug.pr_debug('CS','After package call elpks_archive.fn_archive_el');

commit;
End Loop;
END;
/

set timing off

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') end from dual;

spool off;
exit
