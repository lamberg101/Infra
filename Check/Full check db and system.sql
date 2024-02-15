set head on
set array 1
set linesize 10000
set pagesize 50000
set long 90000
set echo on
set trimspool on
set colsep ';'
set numformat 9999999999999999
set timing on

COLUMN REMARKS FORMAT A50;
COLUMN ACCESS_PREDICATES FORMAT A50;
COLUMN PROJECTION FORMAT A50;
COLUMN FILTER_PREDICATES FORMAT A50;
COLUMN OTHER_TAG FORMAT A50;
COLUMN PARTITION_START FORMAT A50;
COLUMN PARTITION_STOP FORMAT A50;
COLUMN OTHER_XML FORMAT A500;
COLUMN OPTIONS FORMAT A50;
COLUMN OBJECT_NODE FORMAT A50;
COLUMN OPTIMIZER FORMAT A30;
COLUMN NAME FORMAT A50;
COLUMN HOST_NAME FORMAT A20;
COLUMN INTERFACE_ID FORMAT A20;
column RAC_VAL new_value IS_RAC;
column RAC_VAL FORMAT A7;
column BANK_NAME FORMAT A30;

column SQLText FORMAT A80;
column NAME FORMAT A80;
column param_value FORMAT A80;

column  notif_code FORMAT A101;
column  PROCESS_STATUS FORMAT A2;


column  param_name FORMAT A26;
column  param_val FORMAT A150;

COLUMN object_name FORMAT A40;
COLUMN number_of_blocks FORMAT 999,999,999,999;
COLUMN RC_AUTH A3;

COLUMN  username FORMAT A10;

COLUMN METHOD_OPT	FORMAT A40;
COLUMN ESTIMATE_PERCENT FORMAT A40;

col c1 heading '#|CPUs'        format 999
col c2 heading '#|CPU|Cores'   format 999
col c3 heading '#|CPU|Sockets' format 999


spool D:\Details.spl

ALTER SESSION ENABLE PARALLEL DML;

select value RAC_VAL from v$parameter where name = 'cluster_database';


PROMPT --To check DB and date of system -------
PROMPT

SELECT SYSDATE,host_name,version FROM v$instance;

Show user;

PROMPT  --To check GL upate online/offline  ---
PROMPT  

select 
	 ONLINE_GL_UPDATE     
	,BANK_CODE                     
	,substr(BANK_NAME,1,30)  BANK_NAME        
	,HO_BRANCH                     
	,DISCOUNT_CCY                  
	,REPORTING_CURRENCY            
	,HO_CURRENCY                   
	,IB_ACCOUNT_SCHEME             
	,GL_MASK                       
	,EX_RATE_COPY                  
	,RECORD_STAT ||'~'|| AUTH_STAT "RC_AUTH"
	,YEAR_END_PNL_TRNCODE          
	,YEAR_END_PNL_GL               
	,GL_TAB_PRG_DAYS               
	,BANK_LCY                      
	,LEAD_DAYS                     
	,UNIQUE_LODGMENT_NO            
	,FATCA_APPLICABLE              
	,NEXT_BAL_CHK_DATE             
	,NEXT_BAL_CHK_FREQ              
from sttm_bank;


PROMPT --To check No of open branches ---------
PROMPT

--select count(1)  from sttm_branch  where record_stat = 'O' and auth_stat = 'A';
select 
	 BRANCH_CODE
	,PARENT_BRANCH
	,HOST_NAME
	,CURRENT_CYCLE
	,CURRENT_PERIOD
	,BRANCH_LCY
	,END_OF_INPUT
	,BRN_AVAIL_STAT
	,INTERDICT_CHECK_REQD
	,BACK_VALUED_CHK_REQ
	,BACK_VALUE_DAYS
	,ICEOD_STATUS
	,MSG_GEN_DAYS 
FROM sttm_branch  
WHERE record_stat = 'O' and auth_stat = 'A'; 


PROMPT --TO CHECK IC PARALLEL PROCESSING IS BEING USED BY BANK OR NOT -----
PROMPT

SELECT BRANCH_CODE,NUM_PROCESS FROM ICTM_BRANCH_PARAMETERS; 


PROMPT --To check Commit frequencies for the major modules ------
PROMPT

select * from cstb_commitfreq ;


PROMPT --To check no. of open customer and customer account ----
PROMPT

SELECT /*+ PARALLEL(cust, 8) */
 COUNT(1) "sttm_customer"
FROM   STTM_CUSTOMER CUST
WHERE  RECORD_STAT = 'O';


SELECT /*+ PARALLEL(acc, 8) */
 COUNT(1) "sttm_cust_Account"
FROM   STTM_CUST_ACCOUNT ACC
WHERE  RECORD_STAT = 'O';



PROMPT --To check ELCM/Message/VD bal parameter values ----
PROMPT

select param_name,param_val from cstb_param;


PROMPT --To check eltbs_util_txn_log table counts  -----
PROMPT

select /*+ PARALLEL(lg, 8) */  count(1) "eltbs_util_txn_log" from eltbs_util_txn_log lg;


PROMPT  --To check Notification table counts  -----------------
PROMPT

Select /*+ PARALLEL(a, 8) */ count(1) "gwtm_notifications_installed" from gwtm_notifications_installed a;
select /*+ PARALLEL(notif, 8) */ count(1) "sttb_notification" from sttb_notification notif;
select /*+ PARALLEL(notifh, 8) */ count(1) "sttb_notification_history" from sttb_notification_history notifh;
SELECT /*+ PARALLEL(notif, 8) */ notif_code, PROCESS_STATUS,COUNT(1) "STTB_NOTIFICATION" FROM STTB_NOTIFICATION notif GROUP BY notif_code, PROCESS_STATUS;




PROMPT  --To check external message counts table counts -----------------
PROMPT

select /*+ PARALLEL(extms, 8) */ count(1) "mstb_ext_msg_out" from mstb_ext_msg_out extms; 


PROMPT  --To check global temporary table creation required or not based on the below MS table counts ----
PROMPT

select /*+ PARALLEL(mvm, 8) */count(1) "MSTB_VIEW_MESSAGE" from MSTB_VIEW_MESSAGE mvm;

select  /*+ PARALLEL(adv, 8) */ count(1) "MSTB_ADV_INPUT" from MSTB_ADV_INPUT adv;


PROMPT  --TO CHECK THE PURGE_MSG IN MSTM_MSG_TYPE -----
PROMPT  

SELECT /*+ PARALLEL(msg, 8) */ PURGE_MSG, COUNT(1) "MSTM_MSG_TYPE" FROM MSTM_MSG_TYPE msg GROUP BY PURGE_MSG;


PROMPT  --To check existnace of histograms -------
PROMPT  

SELECT /*+ PARALLEL(a, 8) */ COUNT(1) "user_tab_columns" FROM dba_tab_columns a where histogram!='NONE';


PROMPT  --To check ILM usage ---
PROMPT  

select /*+ PARALLEL(a, 8) */ COUNT(1) "iltbs_sys_account" from iltbs_sys_account a; 


PROMPT  --To check IC counts -----------------
PROMPT  

select /*+ PARALLEL(icacc, 8) */ count(1) "ictb_acc_pr" , brn, prod_type from ictb_acc_pr icacc group by brn, prod_type; 


PROMPT  --To check ACBCSTAT batch usage -----------------
PROMPT  

select  /*+ PARALLEL(stat, 8) */  count(1) "Actb_Cust_Account_Stat" from Actb_Cust_Account_Stat stat;  


select count(1) "sttm_account_class" from sttm_account_class where  Acc_Statistics ='Y'; 


PROMPT  --To check CL accrual frequency -----------------
PROMPT  

select distinct accrual_frequency from CLTM_PRODUCT_COMPONENTS;


PROMPT  --To check  subprocess for CL/MO/CF -----------------
PROMPT  

select * from Cltb_Automatic_Process;


PROMPT  --To check no. of active loan accounts -----------------
PROMPT  

select /*+ PARALLEL(clacc, 8) */  count(1) "cltb_account_master" from cltb_account_master clacc where account_status ='A' ;   


PROMPT  --To check bulk payment process exists/not-----------------
PROMPT  

select /*+ PARALLEL(fac, 8) */ bulk_pmt_reqd, count(1) "getm_facility" from getm_facility fac group by bulk_pmt_reqd;


PROMPT  --To check Stats gather parameter value------
PROMPT  

SELECT DBMS_STATS.GET_PARAM ('METHOD_OPT') "METHOD_OPT" FROM DUAL ;

SELECT DBMS_STATS.GET_PARAM('ESTIMATE_PERCENT') "ESTIMATE_PERCENT" FROM DUAL;


PROMPT --To check v$parameter -------------------
PROMPT  

select a.* from ( select NAME,substr(VALUE,1,80) "param_value" from v$parameter )a, 
				 (SELECT value FROM v$parameter WHERE name = 'cluster_database')b
where b.value = 'FALSE';				 

SELECT INST_ID,NAME,substr(VALUE,1,80) "param_value" FROM gv$parameter order by inst_id,num; -- Added as it will be there for RAC instances


PROMPT --To check db fragmentatiions --------------
PROMPT  
  
select table_name,
       tablespace_name,
       round(((blocks * 8) / 1024), 2) "table_size_in_MB",
       round((num_rows * avg_row_len / 1024 / 1024), 2) "Used_size_in_MB",
       (round(((blocks * 8 / 1024)), 2) -
       round((num_rows * avg_row_len / 1024 / 1024), 2)) "fragmented_size_in_MB",
       round(((round(((blocks * 8 / 1024)), 2) -
              round((num_rows * avg_row_len / 1024 / 1024), 2)) /
              round(((blocks * 8) / 1024), 2)) * 100,
              2) "%_of_fragmentation" 
from dba_tables
where blocks > 0 and round(((blocks * 8) / 1024), 2) > 1;


PROMPT  --To check last analyzed ---------------
PROMPT
 
select tablespace_name, trunc(last_analyzed), count(1)
from dba_tables
group by tablespace_name, trunc(last_analyzed); 


PROMPT  --To check LAST_ANALYZED----------------
PROMPT

SELECT table_name,
       NUM_ROWS,
       BLOCKS,
       SAMPLE_SIZE,
	   stale_stats,
       TO_CHAR(LAST_ANALYZED, 'DD-MON-YYYY HH24:MI:SS')	   
  from dba_TAB_STATISTICS WHERE NUM_ROWS > 10;
  

PROMPT  --To check table partitions-------------
PROMPT

SELECT 
	table_name, 
	partitioning_type, 
	subpartitioning_type, 
	partition_count, 
	def_subpartition_count,
	partitioning_key_count, 
	subpartitioning_key_count, 
	status 	
FROM dba_part_tables;


PROMPT  --To index partitions-----------------
PROMPT

SELECT 
	index_name, 
	table_name, 
	partitioning_type,	
	subpartitioning_type, 
	locality,
	def_tablespace_name, 
	partition_count, 
	def_subpartition_count, 
	partitioning_key_count, 
	subpartitioning_key_count 				
FROM dba_part_indexes;


PROMPT ----TO check session_cached_cursor and open_cursor usage--
PROMPT

select 'session_cached_cursors' parameter, lpad(value, 5) value,
     decode(value, 0, ' n/a', to_char(100 * used / value, '9990') || '%') usage
     from ( select max(s.value) used from V$STATNAME n, V$SESSTAT s
     where n.name = 'session cursor cache count' and s.statistic# = n.statistic# ),
     ( select value from V$PARAMETER where name = 'session_cached_cursors' )
     union all
     select 'open_cursors', lpad(value, 5), to_char(100 * used / value, '9990') || '%'
     from ( select max(sum(s.value)) used from V$STATNAME n, V$SESSTAT s
     where n.name in ('opened cursors current', 'session cursor cache count') and s.statistic# = n.statistic# group by s.sid ),
     ( select value from V$PARAMETER where name = 'open_cursors' );


PROMPT --To check invalid objects----
PROMPT

Select object_type,count(1) invalid_objects_count
from dba_objects
where status ='INVALID'
group by object_type;

select
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPUS')        c1,
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPU_CORES')   c2,
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPU_SOCKETS') c3
from dual;


PROMPT --To check BUFFER_POOL_STATISTICS----
PROMPT

SELECT name, physical_reads, db_block_gets, consistent_gets,
       1 - (physical_reads / (db_block_gets + consistent_gets)) "Hit Ratio"
FROM V$BUFFER_POOL_STATISTICS;

PROMPT --To Query the Number of Blocks for All Segments
PROMPT


SELECT o.object_name, COUNT(*) number_of_blocks
  FROM DBA_OBJECTS o, V$BH bh
 WHERE o.data_object_id = bh.OBJD
   AND o.owner != 'SYS'
 GROUP BY o.object_Name
 ORDER BY COUNT(*);

PROMPT --TO Redo Log Buffer Statistics
PROMPT
 
SELECT name, value
  FROM V$SYSSTAT
WHERE name = 'redo buffer allocation retries'; 


PROMPT --To find top sql during EOM-------
PROMPT

SELECT Disk_Reads DiskReads, Executions, SQL_ID , substr(SQL_Text,1,80) SQLText --,SQL_FullText SQLFullText 
FROM
(
   SELECT Disk_Reads, Executions, SQL_ID, LTRIM(SQL_Text) SQL_Text, 
      SQL_FullText, Operation, Options, 
      Row_Number() OVER 
         (Partition By sql_text ORDER BY Disk_Reads * Executions DESC) 
         KeepHighSQL
   FROM
   (
       SELECT Avg(Disk_Reads) OVER (Partition By sql_text) Disk_Reads, 
          Max(Executions) OVER (Partition By sql_text) Executions, 
          t.SQL_ID, sql_text, sql_fulltext, p.operation,p.options
       FROM v$sql t, v$sql_plan p
       WHERE t.hash_value=p.hash_value AND p.operation='TABLE ACCESS' 
       AND p.options='FULL' AND p.object_owner NOT IN ('SYS','SYSTEM')
       AND t.Executions > 1
   ) 
   ORDER BY DISK_READS * EXECUTIONS DESC
)
WHERE KeepHighSQL = 1
AND rownum <=10;

PROMPT --To get the long operation-------
PROMPT

select distinct a.* from (
SELECT username, l.SQL_ID, substr(SQL_Text,1,80) SQLText --username, sql_text, sofar, totalwork, units
FROM   v$sql v, v$session_longops l
WHERE  sql_address = address
AND    sql_hash_value = hash_value
ORDER  BY address, hash_value, child_number
						)a;


PROMPT --To SQL statements that perform large numbers of disk reads-------
PROMPT
SELECT 	  t2.username
		, t1.disk_reads
		, t1.executions
		, t1.disk_reads / DECODE(t1.executions, 0, 1, t1.executions) as exec_ratio
	  --, t1.command_type
		, t1.sql_id
		, substr(t1.sql_text,1,80)
  FROM 	v$sqlarea t1, dba_users t2
  WHERE t1.parsing_user_id = t2.user_id
    AND t1.disk_reads > 100000
  ORDER BY t1.disk_reads DESC;



ALTER SESSION DISABLE PARALLEL DML;

SPOOL OFF