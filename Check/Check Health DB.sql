/*------------------------------
Database Daily HC Checklist
BMI Midas MS Team
Randy P. Joeandy
Jan 2019

Including:
-Asm Usage
-Tablespace Usage
-Invalid Objects
-RMAN Backup status
-Archive send & apply lag
-Dataguard status
------------------------------*/

--ASM Usage (Prod & BTB)
select name , trunc(free_mb/1024,2) free_gb, trunc(total_mb/1024,2) total_gb, round(trunc(((total_mb-free_mb)/total_mb)*100,2)) || '%' "USED%" from v$asm_diskgroup order by 4 desc;
--NOTE: 
--#Track DiskGroup Usage
--#Report if any significant increase in space usage
--#Report if USED% reach warning point(>96%)
--#Report if USED% reach critical point(>98%)

--Tablespace Usage > 80% (Prod)
SELECT  NAME TABLESPACE_NAME, used_percent
FROM (SELECT d.tablespace_name NAME, 
NVL (FLOOR (((a.BYTES - NVL (f.BYTES, 0)) / a.MAXBYTES * 100)), 0) used_percent
      FROM SYS.dba_tablespaces d,
       (SELECT tablespace_name, SUM (BYTES) BYTES , sum(decode(maxbytes,0,bytes,maxbytes)) maxbytes
FROM dba_data_files
 GROUP BY tablespace_name) a,
  (SELECT tablespace_name, SUM (BYTES) BYTES
   FROM dba_free_space
    GROUP BY tablespace_name) f
     WHERE d.tablespace_name = a.tablespace_name(+)
      AND d.tablespace_name = f.tablespace_name(+)
      AND NOT (d.extent_management LIKE 'LOCAL'
       AND (d.CONTENTS LIKE 'TEMPORARY' or d.CONTENTS = 'UNDO')
)
 UNION ALL
  SELECT d.tablespace_name NAME,
NVL (FLOOR ((t.BYTES / a.MAXBYTES * 100)), 0) used_percent
FROM SYS.dba_tablespaces d,
 (SELECT tablespace_name, SUM (BYTES) BYTES , sum(decode(maxbytes,0,bytes,maxbytes)) maxbytes
  FROM dba_temp_files
   GROUP BY tablespace_name) a,
    (SELECT tablespace tablespace_name, SUM (blocks*8192) BYTES
     FROM v$sort_usage
      GROUP BY tablespace) t
       WHERE d.tablespace_name = a.tablespace_name(+)
AND d.tablespace_name = t.tablespace_name(+)
 AND d.extent_management LIKE 'LOCAL'
  AND d.CONTENTS LIKE 'TEMPORARY'
   UNION ALL
    (select d.tablespace_name NAME,
NVL (FLOOR ((t.BYTES / a.MAXBYTES * 100)), 0) used_percent
 from SYS.dba_tablespaces d,
  (select tablespace_name, SUM (BYTES) BYTES,sum(decode(maxbytes,0,bytes,maxbytes)) maxbytes
   FROM dba_data_files
    GROUP BY tablespace_name) a,
     (
      select tablespace_name,sum(bytes) BYTES from dba_undo_extents where status in ('ACTIVE') group by tablespace_name
       ) t
where d.tablespace_name=a.tablespace_name(+)
 AND d.tablespace_name=t.tablespace_name(+)
  AND d.extent_management LIKE 'LOCAL'
   AND d.CONTENTS ='UNDO'
    )
     ) where used_percent > 80
order by used_percent desc, name
--NOTE: 
--#Track Tablespace Usage
--#Report if any tablespace reach more than warning threshold(80%)
--#Report if any tablespace reach more than critical threshold(90%)

--Invalid Objects (Prod)
--select owner, object_type type, object_name name from dba_objects where status ='INVALID' and owner ='FCC114';
--NOTE: 
--#Track Invalid object count in FCC114 schema
--#Report if invalid object increase (critical)

--RMAN Backup 1 week (Prod)
select start_time ,end_time ,
       round((end_time-start_time)*24*60) "DURATION(MIN)",status,output_device_type device_type,input_type,round(INPUT_BYTES/1024/1024) input_mb , round( OUTPUT_BYTES/1024/1024) output_mb
from v$rman_backup_job_details
where end_time > sysdate - 3
order by start_time;
--NOTE: 
--#Track RMAN Backup history
--#Report if any backup of Incremental Level 1 failed (warning) 
--#Report if any backup of Incremental Level 0 failed (critical) 
--#Full backup (Incremental Level 0) run every saturday
--#Differential backup (Incremental Level 1) run every day except saturday

--Archivelog Send & Apply Lag (Prod)
with drcsend as(
select thread#, max(sequence#) sequence,
(case
when name='bmidr' then 'BTB'
end) as name
from v$archived_log where name in ('bmidr') group by thread#,
(case
when name='bmidr' then 'BTB'
end) order by 1
),
prod as(
select thread#, max(sequence#) sequence, (case when substr(name,1,9) ='+RECOVERY' then 'BMIPRD' end) name
from v$archived_log where name like '+RECOVERY%' group by thread#, (case when substr(name,1,9) ='+RECOVERY' then 'BMIPRD' end) order by 1
),
drcapplied as(
select thread#, max(sequence#) sequence,
(case
when name='bmidr' then 'BTB'
end) as name
from v$archived_log where name in ('bmidr') and applied = 'YES' group by thread#,
(case
when name='bmidr' then 'BTB'
end) order by 1
),
archdeststat as(
select inst_id, (case
when destination='bmidr' then 'BTB'
end) as destination, status from gv$archive_dest_status
)
select distinct ds.thread#, ds.name, p.sequence prod_curr_seq, ds.sequence curr_send_seq,  p.sequence-ds.sequence send_gap , da.sequence curr_appl_seq, p.sequence-da.sequence appl_gap, a.status
from prod p , drcsend ds, drcapplied da , archdeststat a where ds.name is not null and p.thread#=ds.thread# and p.thread#=da.thread# and ds.thread#=da.thread# and da.name is not null and ds.name=da.name
and p.thread#=a.inst_id and ds.thread#=a.inst_id and da.thread#=a.inst_id and ds.name=a.destination and da.name = a.destination
order by 1;
--NOTE:
--#Track Archivelog Send & Apply Lag
--#Report if there is huge gap for SEND or APPLY (critical)
--#check with DCO if any DEFEERED status (warning)

--ADG SYNC Status (BTB)
select * from v$dataguard_stats;
--NOTE: 
--#Track ODG replication
--#Report if there is huge archive(transport) lag
--#Report if there is huge apply lag

--DB Instance Status (Prod & BTB)
select distinct instance_name, host_name, status, database_role, open_mode from gv$instance, gv$database;
--NOTE:
--#Track status for each database instance
--#Report if any of the instance not in open state (critical)
--#Report if open mode not read only with apply for BTB (warning)

--Database jobs (Prod)
/*select owner ,job_name, state, to_char(last_start_date,'dd-mon-yyyy hh24:mi:ss') last_start_date, to_char(next_run_date,'dd-mon-yyyy hh24:mi:ss') next_run_date 
from dba_scheduler_jobs where state = 'SCHEDULED' and owner = 'FCC114' or (owner ='SYS' and job_name = 'GATHER_STATS_JOB');

select * from (
select actual_start_date,log_date complete_date, job_name, status, error#, run_duration from dba_SCHEDULER_JOB_RUN_DETAILS where owner = 'FCC114' 
order by 1 desc) where rownum < 11 order by 1;

select * from (
select actual_start_date, log_date complete_date, job_name, status, error#, run_duration from dba_SCHEDULER_JOB_RUN_DETAILS where owner ='SYS' and job_name = 'GATHER_STATS_JOB'
 order by 1 desc) where rownum < 11 order by 1;*/

--NOTE:
--#Track Job status
--#Report if any failed job

--Application jobs (Prod)
/*select module, decode(status,'T','Running','H','Hold','N','Stopped') status, count(*) total from cstb_job_browser group by
module, decode(status,'T','Running','H','Hold','N','Stopped') order by 1, 3 desc;
--NOTE:
--#Track Application module job
--#Report if any difference from baseline

--Application Status
select module, process, decode(status,'T','Running','H','Hold','N','Stopped') status from cstb_job_browser where status = 'T' order by 1;

select * from dba_jobs

select * from pctb_process_status*/
