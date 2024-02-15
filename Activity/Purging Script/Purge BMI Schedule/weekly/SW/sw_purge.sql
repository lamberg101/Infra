set verify off

col spoolname new_value spoolname
select 'SWPKS_PURGE_'||to_char(sysdate,'ddmmyyyy')||'.SPL' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;

set timing on

DECLARE
  P_ERRCODE   VARCHAR2(100);
  P_ERR_PARAM VARCHAR2(100);
BEGIN
  
  fcc114.GLOBAL.PR_INIT('000', 'SYSTEM');
  IF NOT fcc114.SWPKS_PURGE.FN_PURGE_TXN_LOG('000', P_ERRCODE, P_ERR_PARAM) THEN
    DBMS_OUTPUT.PUT_LINE('Failed');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Successs');
  END IF;

  COMMIT;
  
END;
/

set timing off

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') end from dual;

spool off;

exit;
