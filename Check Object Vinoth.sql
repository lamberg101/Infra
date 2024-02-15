
sql_id:
1ppvba50qjapa
sql_text:
DELETE FROM ICTBS_UDEVALS U WHERE U.PROD = :B5 AND U.COND_TYPE = :B4 AND U.COND_KEY = :B3 AND U.UDE_ID = :B2 AND U.UDE_EFF_DT = :B1


select * from v$sql
where sql_id='1ppvba50qjapa';

check the program ID

533414	876

then check 

select * from dba_objects where object_id='533414';

SELECT DBMS_METADATA.GET_DDL('PACKAGE_BODY','ICPKS_CALC','FCC114') FROM DUAL;


SELECT DISTINCT aec.branch_code
,aec.session_id
,aec.serial_no
,ses.sid
,ses.serial#
,ses.inst_id
,sq.sql_text
,ses.status
FROM aetb_eoc_runchart aec
,gv$session ses
,gv$sql sq
WHERE eoc_stage_status = 'W'
AND aec.session_id = ses.sid
AND aec.serial_no = ses.serial#
AND sq.sql_id = ses.sql_id
ORDER BY branch_code;


