col spoolname new_value spoolname
set timing on
select 'gwtb_msg_out_hist_purge_'||to_char(sysdate,'ddmmyyyy')||'.SPL' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;

CREATE TABLE fcc114.GWTB_MSG_OUT_HISTORY_BK AS SELECT * FROM fcc114.GWTB_MSG_OUT_HISTORY
WHERE SERVER_DT_STAMP >= ADD_MONTHS(SYSDATE, -12);

TRUNCATE TABLE fcc114.GWTB_MSG_OUT_HISTORY;

INSERT INTO fcc114.GWTB_MSG_OUT_HISTORY SELECT * FROM fcc114.GWTB_MSG_OUT_HISTORY_BK;

DROP TABLE fcc114.GWTB_MSG_OUT_HISTORY_BK;

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') end from dual;
spool off;
exit;
