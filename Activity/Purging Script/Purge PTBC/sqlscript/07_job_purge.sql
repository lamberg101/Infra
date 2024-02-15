select * from dba_scheduler_running_jobs where job_name in ('DO_MANUAL_PURGE','PURGE_TXNLOG_DETAIL_HIST','PURGE_TXNLOG_MASTER_HIST');
