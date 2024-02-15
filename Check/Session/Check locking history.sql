SELECT  distinct a.sql_id, a.blocking_session,a.blocking_session_serial#,
a.user_id,s.sql_text,a.module, a.sample_time
FROM  V$ACTIVE_SESSION_HISTORY a, v$sql s
where a.sql_id=s.sql_id
and blocking_session is not null
and a.user_id <> 0 
and a.sample_time between to_date('12/03/2019 15:00', 'dd/mm/yyyy hh24:mi') ----> SESUAIKAN PARAMETER/TANGGALNYA
and to_date('12/03/2019 16:00', 'dd/mm/yyyy hh24:mi');