HK DB PROD

ACTB_HISTORY = 3,1 bio records
SWTB_TXN_LOG = 153 mio records
CSTB_ADDL_TEXT = 375 mio records

Please advise how we can reduce number or rows for this tables.

We have copy actb_history to our datawarehouse. Daily incremental.
For old data, we will provide another database.
Or we can save it to object storage format.

------------------------------------------------------------------------------------------------------------------------

select * from ACTB_HISTORY 
where TRN_DT  
BETWEEN HH24:MI:SS')
AND -MON-YYYY HH24:MI:SS') 
and rownum < 10
ORDER BY TRN_DT;

select count(TRN_DT) from ACTB_HISTORY
where TRN_DT  
BETWEEN to_date(to_char('01-MAY-2015 11:50:14'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('30-MAY-2015 17:56:52'),'DD-MON-YYYY HH24:MI:SS') 
ORDER BY TRN_DT;

select count(PURGE_DATE) from SWTB_TXN_LOG 
where PURGE_DATE  
BETWEEN to_date(to_char('01-MAY-2015 11:50:14'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('30-MAY-2015 17:56:52'),'DD-MON-YYYY HH24:MI:SS') 
ORDER BY PURGE_DATE;

select * from SWTB_TXN_LOG 
where PURGE_DATE  
BETWEEN to_date(to_char('01-MAY-2015 11:50:14'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('30-MAY-2015 17:56:52'),'DD-MON-YYYY HH24:MI:SS') 
and rownum < 10
ORDER BY PURGE_DATE;


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

etc..


2. HK TABLE USING CTAS
--SCRIPT
CREATE TABLE ACTB_HISTORY_NEW AS SELECT * FROM ACTB_HISTORY
WHERE TRN_DT  
BETWEEN to_date(to_char('01-JAN-2019 00:00:00'),'DD-MON-YYYY HH24:MI:SS')
AND to_date(to_char('16-JUL-2022 23:59:59'),'DD-MON-YYYY HH24:MI:SS');

--CREATE INDEX
CREATE INDEX using existing ddl and nologging 

--SWITCH TABLE
RENAME ACTB_HISTORY TO ACTB_HISTORY_OLD;
RENAME ACTB_HISTORY_NEW TO ACTB_HISTORY;

--GATHER STATS

--DROP OLD TABLE
wait for 2 weeks at least, if the trx is normal, then drop the table
if err occur, then rollback by switch back the table
DROP TABLE ACTB_HISTORY_OLD;


3. Using expdp/impdp 
Export the table full
Create ACTB_HISTORY_NEW table using ACTB_HISTORY ddl
Import using clause TRN_DT in 2019 - 2022 
Create index
Gather Stats new_table
Rename table (swtich)
Wait for couple weeks, then drop the old table




--SELECT to_char(emp_login_date,'DD-MON-YYYY HH24:MI:SS'),A.* 
--FROM emp_log A
--WHERE emp_login_date 
--BETWEEN to_date(to_char('21-MAY-2015 11:50:14'),'DD-MON-YYYY HH24:MI:SS')
--AND to_date(to_char('22-MAY-2015 17:56:52'),'DD-MON-YYYY HH24:MI:SS') 
--ORDER BY emp_login_date
