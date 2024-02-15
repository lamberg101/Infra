drop table AETB_EOC_PROGRAMS_HIST_TMP;
/*-- Create table */
create table AETB_EOC_PROGRAMS_HIST_TMP
(
  branch_code      VARCHAR2(3),
  eod_date         DATE,
  eoc_stage_seq    NUMBER,
  eoc_stage        VARCHAR2(20),
  eoc_batch        VARCHAR2(20),
  eoc_batch_seq    NUMBER,
  retry_seq_no     NUMBER,
  branch_date      DATE,
  eoc_batch_status VARCHAR2(1),
  eoc_ref_no       VARCHAR2(16),
  eoc_seq_no       NUMBER,
  session_id       VARCHAR2(50),
  serial_no        VARCHAR2(50),
  error_code       VARCHAR2(4000),
  error_param      VARCHAR2(4000),
  start_time       DATE,
  end_time         DATE,
  error            VARCHAR2(4000),
  eoc_type         VARCHAR2(50),
  execution_layer  VARCHAR2(50),
  error_handling   VARCHAR2(50),
  job_code         VARCHAR2(100)
)
/
