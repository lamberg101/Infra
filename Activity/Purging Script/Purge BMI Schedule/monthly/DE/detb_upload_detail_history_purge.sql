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
select 'DETB_UPLOAD_DETAIL_HISTORY_Purge_'||to_char(sysdate,'ddmmyyyy')||'.SPL' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;

set timing on

Declare
  cnt        NUMBER := 0;
  --Cursor declaration
  Cursor CR_PURGE_DATA IS
    select b.rowid--, b.*
      from fcc114.DETB_UPLOAD_DETAIL_HISTORY b
     where b.archival_date <= trunc(sysdate-365);


TYPE ty_to_be_deleted IS TABLE OF CR_PURGE_DATA%ROWTYPE INDEX BY PLS_INTEGER;
g_commit_freq fcc114.cstbs_commitfreq.eod_commit_count%TYPE := 10000;
l_tb_to_be_deleted ty_to_be_deleted;
DML_ERRORS EXCEPTION;
PRAGMA EXCEPTION_INIT(DML_ERRORS, -24381);
BEGIN

  Open CR_PURGE_DATA;
  Loop
    FETCH CR_PURGE_DATA BULK COLLECT
      INTO l_tb_to_be_deleted LIMIT g_commit_freq;

  
    IF l_tb_to_be_deleted.COUNT > 0 THEN
    
        FORALL k IN l_tb_to_be_deleted.FIRST .. l_tb_to_be_deleted.LAST   SAVE EXCEPTIONS
          INSERT INTO fcc114.DETB_UPLOAD_DETAIL_HIST_arch
            SELECT *
              FROM fcc114.DETB_UPLOAD_DETAIL_HISTORY 
             where ROWID = l_tb_to_be_deleted(k).ROWID;

    --Deletion from the original table
	FORALL k IN l_tb_to_be_deleted.FIRST .. l_tb_to_be_deleted.LAST   SAVE EXCEPTIONS
	  DELETE FROM fcc114.DETB_UPLOAD_DETAIL_HISTORY WHERE ROWID = l_tb_to_be_deleted(k).ROWID;
	 cnt:= cnt+ sql%rowcount;--l_tb_rowid.COUNT;  

     l_tb_to_be_deleted.DELETE;

      COMMIT;
   END IF;
      EXIT WHEN CR_PURGE_DATA%NOTFOUND;
  
  END LOOP;
  COMMIT;
  dbms_output.put_line('The total no of Record deleted from DETB_UPLOAD_DETAIL_HISTORY is '||cnt);
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

exit
