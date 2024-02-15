HK DB PROD

ACTB_HISTORY = 3,1 bio records (trn_dt column)
SWTB_TXN_LOG = 153 mio records (purge_date coloumn is the only column that signify date)
CSTB_ADDL_TEXT = 375 mio records (none)

look for some other bigger tables --> later 

Please advise how we can reduce number or rows for this tables.
We have copy actb_history to our datawarehouse. Daily incremental.
For old data, we will provide another database.
Or we can save it to object storage format.


------------------------------------------------------------------------------------------------------------------------


select /*+ PARALLEL 8 */ count(*) 
FROM ACTB_HISTORY
WHERE TRN_DT  
BETWEEN to_date(to_char('22-AUG-2017 10:00:00'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('22-AUG-2022 10:01:00'),'DD-MON-YYYY HH24:MI:SS');

SELECT /*+ PARALLEL 8 */ count(*) 
FROM SWTB_TXN_LOG 
WHERE PURGE_DATE  
BETWEEN to_date(to_char('01-MAY-2015 11:50:14'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('30-MAY-2015 17:56:52'),'DD-MON-YYYY HH24:MI:SS') 
ORDER BY PURGE_DATE;

-----------------------------------------------------------------
Belajar:
- Shrink space
- Share 

-----------------------------------------------------------------

1. Check indexes size of the actb_history table
2. 



set lines 1000 pages 100
select
sum(round(((1601641010*b.avg_row_len)+(1601641010*b.avg_row_len)*pct_free/100)/1024/1024,2)) ROW_SIZE_MB
FROM dba_segments a, dba_tables b
WHERE a.segment_name=b.table_name
AND a.segment_name='CSTB_ADDL_TEXT'
AND b.last_analyzed is not null
AND a.owner=b.owner
AND b.owner='FCC114';


set lines 1000 pages 100
select sum(round(a.bytes/1024/1024,2)) DISK_SIZE_MB,
round(((b.num_rows*b.avg_row_len)+(b.num_rows*b.avg_row_len)*pct_free/100)/1024/1024,2) ROW_SIZE_MB
FROM dba_segments a, dba_tables b
WHERE a.segment_name=b.table_name
AND a.segment_name='CSTB_ADDL_TEXT'
AND b.last_analyzed is not null
AND a.owner=b.owner
AND b.owner='FCC114'
AND bytes/1024/1024>100
order by 1 desc;


1. Delete rows manually
BACKUP FULL TABLE using expdp (if necessary)

#Delete data in 2011
DELETE FROM ACTB_HISTORY
WHERE TRN_DT 
BETWEEN to_date(to_char('01-JAN-2011 00:00:00'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('31-DEC-2011 23:59:59'),'DD-MON-YYYY HH24:MI:SS');
COMMIT;

#Delete data in 2012
DELETE FROM ACTB_HISTORY
WHERE TRN_DT  
BETWEEN to_date(to_char('01-JAN-2012 00:00:00'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('31-DEC-2012 23:59:59'),'DD-MON-YYYY HH24:MI:SS');
COMMIT;

set lines 300
col segment_name for a35
col owner for a35
select  owner, tablespace_name, segment_type, segment_name,sum(bytes) bytes 
FROM dba_segments 
where segment_name in ('ACTB_HISTORY')
group by owner, tablespace_name, segment_name, segment_type
order by segment_type;


set lines 1000 pages 100
select a.segment_name, a.tablespace_name, round(a.bytes/1024/1024,2) DISK_SIZE_MB,
round(((b.num_rows*b.avg_row_len)+(b.num_rows*b.avg_row_len)*pct_free/100)/1024/1024,2) ROW_SIZE_MB
FROM dba_segments a, dba_tables b, fcc114.ACTB_HISTORY c
where a.segment_name=b.table_name
AND a.segment_name='ACTB_HISTORY'
AND b.last_analyzed is not null
AND a.owner=b.owner
AND bytes/1024/1024>100
order by 5 desc;


2. HK TABLE USING CTAS
--SCRIPT
CREATE TABLE ACTB_HISTORY_NEW AS SELECT * FROM ACTB_HISTORY
WHERE TRN_DT  
BETWEEN to_date(to_char('01-JAN-2019 00:00:00'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('22-AUG-2022 23:59:59'),'DD-MON-YYYY HH24:MI:SS');

--CREATE INDEX
CREATE INDEX for ACTB_HISTORY_NEW table using existing ddl AND (consider using nologging as well)

--SWITCH TABLE using FCC114 user
RENAME ACTB_HISTORY TO ACTB_HISTORY_OLD;
RENAME ACTB_HISTORY_NEW TO ACTB_HISTORY;

--GATHER STATS (if necessary)
exec dbms_stats.gather_table_stats('FCC114','ACTB_HISTORY', DEGREE => 20, estimate_percent => dbms_stats.auto_sample_size,cascade => true);

--DROP OLD TABLE
wait for 2 weeks at least, if the trx is normal, then drop the table
if err occur, then rollback by switch back the table
DROP TABLE ACTB_HISTORY_OLD;



3. Using expdp/impdp 
--Export the table full
nohup expdp \'/ as sysdba\' 
DIRECTORY=DIR --will look for this one
dumpfile=ACTB_HISTORY_22082022_%U.dmp 
logfile=expdp_actb_history_22082022.log 
tables=fcc114.ACTB_HISTORY parallel=8 &

--Create ACTB_HISTORY_NEW table 
create the table using ACTB_HISTORY ddl

--Import using clause TRN_DT in 2019 - 2022 
nohup impdp \"/ as sysdba\" 
directory=DIR --will look for this one
dumpfile=ACTB_HISTORY_22082022_%U.dmp 
logfile=impdp_actb_history_22082022.log 
tables=fcc114.ACTB_HISTORY 
QUERY=fcc114.ACTB_HISTORY:"WHERE TRN_DT BETWEEN to_date(to_char('01-JAN-2019 00:00:00'),'DD-MON-YYYY HH24:MI:SS') AND to_date(to_char('22-AUG-2022 23:59:59'),'DD-MON-YYYY HH24:MI:SS')"
parallel=8 &

--Create index
Create index using index ddl FROM old table

--Gather Stats new_table
exec dbms_stats.gather_table_stats('FCC114','ACTB_HISTORY_NEW', DEGREE => 20, estimate_percent => dbms_stats.auto_sample_size,cascade => true);

--Rename table (swtich)
RENAME ACTB_HISTORY TO ACTB_HISTORY_OLD;
RENAME ACTB_HISTORY_NEW TO ACTB_HISTORY;

--Drop old table
wait for 2 weeks at least, if the trx is normal, then drop the table
if err occur, then rollback by switch back the table
DROP TABLE ACTB_HISTORY_OLD;



/* 
SELECT to_char(emp_login_date,'DD-MON-YYYY HH24:MI:SS'),A.* 
FROM emp_log A
WHERE emp_login_date 
BETWEEN to_date(to_char('21-MAY-2015 11:50:14'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('22-MAY-2015 17:56:52'),'DD-MON-YYYY HH24:MI:SS') 
ORDER BY emp_login_date
*/

