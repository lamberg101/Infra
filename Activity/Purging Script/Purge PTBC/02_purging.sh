ORACLE_HOME=/oracledb1/app/oracle/product/11.2.0/dbhome_1;
ORACLE_SID=prdfcubs1;
CURDATE=`date "+%Y%m%d"`; export CURDATE
export ORACLE_HOME ORACLE_SID
$ORACLE_HOME/bin/sqlplus FCUBSPRD/"fR0DOSDr4G#1" <<EOF > /rmanbackup/backup/purging/logs/${CURDATE}purgingfcubs.log
set time on timi on;
@/home/oracle/script/tablespace_actual.sql
@/rmanbackup/backup/purging/sqlscript/02_create_backup_tables.sql
@/rmanbackup/backup/purging/sqlscript/03_pr_purge_txnlog_detail_hist.prc
@/rmanbackup/backup/purging/sqlscript/04_pr_purge_txnlog_master_hist.prc
@/rmanbackup/backup/purging/sqlscript/05_pr_do_manual_purge.prc
@/rmanbackup/backup/purging/sqlscript/06_do_manual_purge_script.sql
@/rmanbackup/backup/purging/sqlscript/07_job_purge.sql
@/home/oracle/script/tablespace_actual.sql
exit;
EOF

