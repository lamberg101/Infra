set lines 190 pages 0
set feed off
set echo off
spool broken_kill_remove_IC_purging_job.sql

select 'exec dbms_job.broken(' || job || ',' || '''Y'');' script_4_broken from dba_jobs
where log_user = 'FCC114' and what like '%pr_ic_entries_purge%';

select 'alter system kill session (''' || sid || ''',''' || serial# || ''');' script_4_kill from v$session where sid in(
select sid from dba_jobs_running where job in (select job from dba_jobs
where log_user = 'FCC114' and what like '%pr_ic_entries_purge%')) and program like '%(J0%)' and status ='ACTIVE';

select 'exec dbms_job.remove(' || job || ');' script_4_remove from dba_jobs
where log_user = 'FCC114' and what like '%pr_ic_entries_purge%';

select 'exit;' from dual;
