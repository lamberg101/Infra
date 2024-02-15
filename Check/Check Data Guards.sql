
-- check last apply
alter session set nls_date_format  = 'dd-mon-yy hh24:mi:ss';
set lines 999
SELECT T.SEQUENCE#,T.APPLIED,T.FIRST_TIME,T.NEXT_TIME,T.COMPLETION_TIME 
FROM V$ARCHIVED_LOG T 
WHERE T.APPLIED='YES' 
ORDER BY T.SEQUENCE# ASC;

-- check error
set linesize 200
set pagesize 200
select inst_id, dest_id,status, error 
from gv$archive_dest_status where dest_id in (1,2,3);


-- check last apply logical
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YY HH24:MI:SS';
set lines 999
col NAME for a30
col VALUE for a30
SELECT NAME, VALUE, UNIT FROM V$DATAGUARD_STATS;
SELECT APPLIED_TIME, LATEST_TIME, MINING_TIME, RESTART_TIME FROM V$LOGSTDBY_PROGRESS;




-- check gap
set linesize 200
select dest_id,thread#,max(primary) primary, max(transf) maxtransf,
max(standby) standby, MAX(primary)-MAX(transf) mintransf_gap, MAX(primary)-MAX(standby) apply_gap,
		   max(timegap) hoursgap
	from (
	SELECT dest_id,thread#,max(sequence#) primary, 0 transf, 0 standby, 0 timegap
		 FROM v$archived_log
		WHERE STANDBY_DEST='YES'
		  and archived = 'YES'
		  AND resetlogs_change# = ( select d.resetlogs_change# from v$database d )
	 GROUP BY dest_id,thread#
	union all
	SELECT dest_id,thread#,0 primary, max(sequence#) transf, 0 standby, 0 timegap
		 FROM v$archived_log
		WHERE STANDBY_DEST='YES'
		  and archived = 'YES'
		  AND resetlogs_change# = ( select d.resetlogs_change# from v$database d )
	 GROUP BY dest_id,thread#
	union all
	SELECT dest_id,thread#,0 primary, 0 transf, max(sequence#) standby, trunc((sysdate-max(FIRST_TIME))*24) timegap
		 FROM v$archived_log
		WHERE STANDBY_DEST='YES'
		  and applied = 'YES'
		  AND resetlogs_change# = ( select d.resetlogs_change# from v$database d )
	 GROUP BY dest_id,thread#
	) asd
	group by dest_id,thread#
	order by thread#,dest_id;