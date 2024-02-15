set head on
set array 1
set linesize 10000
set pagesize 50000
set long 10000
set colsep ";"
set echo on
set trimspool on
set serveroutput on
set verify off
set timing on
set numformat 9999999999999999.999

col spoolname new_value spoolname
col SMTBBAK new_value SMTBBAK
col STTBBAK new_value STTBBAK

select 'purging_SM_ST_tables_'||to_char(sysdate,'ddmmyyyy')||'.SPL' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;
select 'SMTB_SMS_ACTION_LOG_'||to_char(sysdate,'ddmmyyyy') SMTBBAK from dual;
select 'STTB_FIELD_LOG_HIST_'||to_char(sysdate,'ddmmyyyy') STTBBAK from dual;

create table "FCC114"."&SMTBBAK" as select * from fcc114.SMTB_SMS_ACTION_LOG;
create table "FCC114"."&STTBBAK" as select * from fcc114.STTB_FIELD_LOG_HIST;

truncate table fcc114.SMTB_SMS_ACTION_LOG;
truncate table fcc114.STTB_FIELD_LOG_HIST;

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') end from dual;

spool off;
exit;
