---Check list index on tables GETB_UTILS_LOG
set linesize 200 set pagesize 200
col index_name for a30
col table_name for a30
select owner,table_name,index_name, status,TABLESPACE_NAME
from dba_indexes 
where table_name in ('GETB_UTILS_LOG')
order by 2 desc;


---Healtcheck db
Check process, session, locking


4. Create index
set time on;
set timing on;
create index FCC114.IDX_GETB_UTILS_LOG 
on FCC114.GETB_UTILS_LOG(LIAB_BRANCH,VD_UPDATE,AUTH_STAT,PROCESS_NO) 
TABLESPACE FCCINDXSML
PARALLEL 16;
alter index FCC114.IDX_GETB_UTILS_LOG noparallel;


===========================================================================================

--the script
SELECT * FROM (SELECT f.*, ROWNUM RNUM from (SELECT
UTIL_ID,LIMIT_ID,VALUE_DATE,UTIL_AMT,LIMIT_UPDATE,ACTION,SERIAL_NO
FROM fcc114.GEVW_VALUE_DATE_UTILS WHERE LIAB_BRANCH =  :1
AND (PROCESS_NO =  :2   OR PROCESS_NO IS NULL)) f
WHERE ROWNUM <=  :3  ) WHERE RNUM >  :4;


--Explain plan:
explain plan for
SELECT * FROM (SELECT f.*, ROWNUM RNUM from (SELECT
UTIL_ID,LIMIT_ID,VALUE_DATE,UTIL_AMT,LIMIT_UPDATE,ACTION,SERIAL_NO
FROM fcc114.GEVW_VALUE_DATE_UTILS WHERE LIAB_BRANCH =  :1
AND (PROCESS_NO =  :2   OR PROCESS_NO IS NULL)) f
WHERE ROWNUM <=  :3  ) WHERE RNUM >  :4;

--
set lines 150 set pages 1000
select * from table(dbms_xplan.display);


