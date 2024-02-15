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

set numformat 9999999999999999.999 

col spoolname new_value spoolname
select 'ICTB_PROBLEM_LOG_Purge_'||to_char(sysdate,'ddmmyyyy')||'.SPL' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;

set timing on

Declare
  cnt        NUMBER := 0;
  --Cursor declaration
Cursor CR_PURGE_DATA IS
    select b.rowid, b.*
      from fcc114.ICTB_PROBLEM_LOG b where logtime <= trunc(sysdate-365);

TYPE ty_old_records IS TABLE OF CR_PURGE_DATA%ROWTYPE INDEX BY PLS_INTEGER;
TYPE ty_tb_records IS TABLE OF fcc114.ICTB_PROBLEM_LOG%ROWTYPE INDEX BY PLS_INTEGER;
TYPE ty_tb_rowid IS TABLE OF ROWID INDEX BY PLS_INTEGER;
g_commit_freq  fcc114.cstbs_commitfreq.eod_commit_count%TYPE := 10000;

l_tb_old_records ty_old_records;
l_tb_records        ty_tb_records;
l_tb_rowid            ty_tb_rowid;
DML_ERRORS EXCEPTION;
PRAGMA EXCEPTION_INIT(DML_ERRORS, -24381);
BEGIN

  Open CR_PURGE_DATA;
  Loop
    FETCH CR_PURGE_DATA BULK COLLECT
      INTO l_tb_old_records LIMIT g_commit_freq;

  
    IF l_tb_old_records.COUNT > 0 THEN
    
      FOR i IN l_tb_old_records.FIRST .. l_tb_old_records.LAST LOOP
			l_tb_records(i).LOGTIME:= l_tb_old_records(i).LOGTIME;
			l_tb_records(i).BRN:= l_tb_old_records(i).BRN;
			l_tb_records(i).OP:= l_tb_old_records(i).OP;
			l_tb_records(i).PROD:= l_tb_old_records(i).PROD;
			l_tb_records(i).ACC:= l_tb_old_records(i).ACC;
			l_tb_records(i).ERRM:= l_tb_old_records(i).ERRM;
            l_tb_rowid(i) := l_tb_old_records(i).ROWID;
      END LOOP;
    
	--insertion into the backup table starts
      FORALL j IN l_tb_records.FIRST .. l_tb_records.LAST
        INSERT INTO fcc114.ICTB_PROBLEM_LOG_ARCH
        VALUES l_tb_records(j);

      
    --Deletion from the original table
	FORALL k IN l_tb_rowid.FIRST .. l_tb_rowid.LAST   SAVE EXCEPTIONS
	  DELETE FROM fcc114.ICTB_PROBLEM_LOG WHERE ROWID = l_tb_rowid(k);
	 cnt:= cnt+ sql%rowcount;--l_tb_rowid.COUNT;  


     l_tb_old_records.DELETE;
	 l_tb_records.DELETE;
	 l_tb_rowid.DELETE;


      COMMIT;
   END IF;
      EXIT WHEN CR_PURGE_DATA%NOTFOUND;
  
  END LOOP;
  COMMIT;
  dbms_output.put_line('The total no of Record deleted from ICTB_PROBLEM_LOG is '||cnt);
  CLOSE CR_PURGE_DATA;

EXCEPTION
  WHEN DML_ERRORS THEN
    dbms_output.put_line('Total No of errors is' ||sql%bulk_exceptions.count);
    for i in 1 .. sql%bulk_exceptions.count loop
      dbms_output.put_line('Error' || '~' || i || '~' ||
                           'occurred during ' || 'iteration' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX);
      dbms_output.put_line('The Oracle error details is' ||SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));
    end loop;
  WHEN OTHERS THEN
    dbms_output.put_line('The Whenother error of deletion operation' ||
                         SQLCODE || '~' || SQLERRM);
    dbms_output.put_line(dbms_utility.format_error_backtrace);
    ROLLBACK;
END;
/

set timing off

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') end from dual;

spool off;
exit;
