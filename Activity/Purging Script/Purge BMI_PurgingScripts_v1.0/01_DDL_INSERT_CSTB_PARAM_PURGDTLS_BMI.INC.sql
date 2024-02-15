drop table CSTB_PARAM_PURGDTLS_BMI;
/*�-- Create table */
create table CSTB_PARAM_PURGDTLS_BMI
(
  table_name        VARCHAR2(100) not null,
  table_description VARCHAR2(4000),
  retention_days    NUMBER,
  last_purg_dt      DATE,
  next_purg_dt      DATE,
  purg_req          VARCHAR2(1),
  remarks           VARCHAR2(4000)
)
/
/*-- Create/Recreate primary, unique and foreign key constraints */
alter table CSTB_PARAM_PURGDTLS_BMI
  add primary key (TABLE_NAME)
/
prompt Importing table cstb_param_purgdtls_bmi...
set feedback off
set define off
insert into cstb_param_purgdtls_bmi (TABLE_NAME, TABLE_DESCRIPTION, RETENTION_DAYS, LAST_PURG_DT, NEXT_PURG_DT, PURG_REQ, REMARKS)
values ('SMTB_SMS_LOG', 'Stores signing (in-out) logs of Flexcube users', 90, null, null, 'Y', null);

insert into cstb_param_purgdtls_bmi (TABLE_NAME, TABLE_DESCRIPTION, RETENTION_DAYS, LAST_PURG_DT, NEXT_PURG_DT, PURG_REQ, REMARKS)
values ('FBTB_OVD', 'Stores the override details of Branch Transactions', 90, null, null, 'Y', null);

insert into cstb_param_purgdtls_bmi (TABLE_NAME, TABLE_DESCRIPTION, RETENTION_DAYS, LAST_PURG_DT, NEXT_PURG_DT, PURG_REQ, REMARKS)
values ('FBTB_TXNLOG_DETAILS_HIST', 'Stores the history of the details of a transaction for all stages for all transaction', 60, null, null, 'Y', null);

insert into cstb_param_purgdtls_bmi (TABLE_NAME, TABLE_DESCRIPTION, RETENTION_DAYS, LAST_PURG_DT, NEXT_PURG_DT, PURG_REQ, REMARKS)
values ('AETB_EOC_PROGRAMS_HISTORY', 'Stores all the programs that are completed in a agiven EOC cycle. This is an archival for ACTB_EOC_PROGRAMS table', 60, null, null, 'Y', null);

insert into cstb_param_purgdtls_bmi (TABLE_NAME, TABLE_DESCRIPTION, RETENTION_DAYS, LAST_PURG_DT, NEXT_PURG_DT, PURG_REQ, REMARKS)
values ('GWTB_BRNTXN_LOG', 'Contains logs of branh transaction', 0, null, null, 'N', 'This table is already getting purged in GWTBS_BRNTXN_HISTORY and there is no date condition to purge based on date, so purging not required.');

COMMIT;
prompt Done.
