BEGIN

  DBMS_SCHEDULER.CREATE_JOB(JOB_NAME        => 'DO_MANUAL_PURGE',
                            JOB_TYPE        => 'PLSQL_BLOCK',
                            JOB_ACTION      => 'BEGIN PR_DO_MANUAL_PURGE; END;',
                            START_DATE      => SYSTIMESTAMP,
                            REPEAT_INTERVAL => NULL,
                            ENABLED         => TRUE,
                            COMMENTS        => 'STREAM FOR DO_MANUAL_PURGE');
  COMMIT;
END;
/
