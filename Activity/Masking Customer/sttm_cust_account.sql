-- Create table
create table STTM_CUST_ACCOUNT
(
  branch_code                  VARCHAR2(3) not null,
  cust_ac_no                   VARCHAR2(20) not null,
  ac_desc                      VARCHAR2(105),
  cust_no                      VARCHAR2(9),
  ccy                          VARCHAR2(3),
  account_class                VARCHAR2(6),
  ac_stat_no_dr                CHAR(1) default 'N',
  ac_stat_no_cr                CHAR(1) default 'N',
  ac_stat_block                CHAR(1) default 'N',
  ac_stat_stop_pay             CHAR(1) default 'N',
  ac_stat_dormant              CHAR(1) default 'N',
  joint_ac_indicator           CHAR(1),
  ac_open_date                 DATE,
  ac_stmt_day                  NUMBER(2),
  ac_stmt_cycle                CHAR(1) default 'M',
  alt_ac_no                    VARCHAR2(20),
  cheque_book_facility         CHAR(1),
  atm_facility                 CHAR(1),
  passbook_facility            CHAR(1),
  ac_stmt_type                 CHAR(1) default 'S',
  dr_ho_line                   VARCHAR2(16),
  cr_ho_line                   VARCHAR2(16),
  cr_cb_line                   VARCHAR2(16),
  dr_cb_line                   VARCHAR2(16),
  sublimit                     NUMBER(22,3),
  uncoll_funds_limit           NUMBER(22,3),
  ac_stat_frozen               CHAR(1) default 'N',
  previous_statement_date      DATE,
  previous_statement_balance   NUMBER(22,3),
  previous_statement_no        NUMBER(3),
  tod_limit_start_date         DATE,
  tod_limit_end_date           DATE,
  tod_limit                    NUMBER(22,3),
  nominee1                     VARCHAR2(105),
  nominee2                     VARCHAR2(105),
  dr_gl                        VARCHAR2(9),
  cr_gl                        VARCHAR2(9),
  record_stat                  CHAR(1) default 'O',
  auth_stat                    CHAR(1) default 'U',
  mod_no                       NUMBER(4),
  maker_id                     VARCHAR2(12),
  maker_dt_stamp               DATE,
  checker_id                   VARCHAR2(12),
  checker_dt_stamp             DATE,
  once_auth                    CHAR(1) default 'N',
  limit_ccy                    VARCHAR2(3),
  line_id                      CHAR(11),
  offline_limit                NUMBER(22,3),
  cas_account                  CHAR(1),
  acy_opening_bal              NUMBER default 0,
  lcy_opening_bal              NUMBER default 0,
  acy_today_tover_dr           NUMBER default 0,
  lcy_today_tover_dr           NUMBER default 0,
  acy_today_tover_cr           NUMBER default 0,
  lcy_today_tover_cr           NUMBER default 0,
  acy_tank_cr                  NUMBER default 0,
  acy_tank_dr                  NUMBER default 0,
  lcy_tank_cr                  NUMBER default 0,
  lcy_tank_dr                  NUMBER default 0,
  acy_tover_cr                 NUMBER default 0,
  lcy_tover_cr                 NUMBER default 0,
  acy_tank_uncollected         NUMBER default 0,
  acy_curr_balance             NUMBER default 0,
  lcy_curr_balance             NUMBER default 0,
  acy_blocked_amount           NUMBER default 0,
  acy_avl_bal                  NUMBER default 0,
  acy_unauth_dr                NUMBER default 0,
  acy_unauth_tank_dr           NUMBER default 0,
  acy_unauth_cr                NUMBER default 0,
  acy_unauth_tank_cr           NUMBER default 0,
  acy_unauth_uncollected       NUMBER default 0,
  acy_unauth_tank_uncollected  NUMBER default 0,
  acy_mtd_tover_dr             NUMBER default 0,
  lcy_mtd_tover_dr             NUMBER default 0,
  acy_mtd_tover_cr             NUMBER default 0,
  lcy_mtd_tover_cr             NUMBER default 0,
  acy_accrued_dr_ic            NUMBER default 0,
  acy_accrued_cr_ic            NUMBER default 0,
  date_last_cr_activity        DATE,
  date_last_dr_activity        DATE,
  date_last_dr                 DATE,
  date_last_cr                 DATE,
  acy_uncollected              NUMBER,
  tod_start_date               DATE,
  tod_end_date                 DATE,
  dormancy_date                DATE,
  dormancy_days                NUMBER(3),
  has_tov                      CHAR(1) default 'N',
  last_ccy_conv_date           DATE,
  address1                     VARCHAR2(105),
  address2                     VARCHAR2(105),
  address3                     VARCHAR2(105),
  address4                     VARCHAR2(105),
  type_of_chq                  VARCHAR2(1) default 'C',
  atm_cust_ac_no               VARCHAR2(13),
  atm_dly_amt_limit            NUMBER(22,3),
  atm_dly_count_limit          NUMBER(3),
  gen_stmt_only_on_mvmt        CHAR(1),
  ac_stat_de_post              CHAR(1),
  display_iban_in_advices      VARCHAR2(1),
  clearing_bank_code           VARCHAR2(20),
  clearing_ac_no               VARCHAR2(32),
  iban_ac_no                   VARCHAR2(35),
  reg_cc_availability          VARCHAR2(1),
  reg_cc_available_funds       NUMBER(22,3),
  prev_ac_srno_printed_in_pbk  NUMBER(10),
  latest_srno_submitted        NUMBER(10),
  prev_runbal_printed_in_pbk   NUMBER(22,3),
  latest_runbal_submmited      NUMBER(22,3),
  prev_page_no                 NUMBER(8),
  prev_line_no                 NUMBER(8),
  mt210_reqd                   VARCHAR2(1),
  acc_stmt_type2               CHAR(1),
  acc_stmt_day2                NUMBER(2),
  ac_stmt_cycle2               CHAR(1),
  previous_statement_date2     DATE,
  previous_statement_balance2  NUMBER(22,3),
  previous_statement_no2       NUMBER(3),
  gen_stmt_only_on_mvmt2       CHAR(1),
  acc_stmt_type3               CHAR(1),
  acc_stmt_day3                NUMBER(2),
  ac_stmt_cycle3               CHAR(1),
  previous_statement_date3     DATE,
  previous_statement_balance3  NUMBER(22,3),
  previous_statement_no3       NUMBER(3),
  gen_stmt_only_on_mvmt3       CHAR(1),
  sweep_type                   NUMBER default 0,
  master_account_no            VARCHAR2(20),
  auto_deposits_bal            NUMBER,
  cas_customer                 VARCHAR2(1) default 'N',
  account_type                 VARCHAR2(1),
  min_reqd_bal                 NUMBER,
  positive_pay_ac              CHAR(1),
  stale_days                   NUMBER(4),
  cr_auto_ex_rate_lmt          NUMBER(22,3),
  dr_auto_ex_rate_lmt          NUMBER(22,3),
  track_receivable             VARCHAR2(1),
  receivable_amount            NUMBER,
  product_list                 VARCHAR2(1),
  txn_code_list                VARCHAR2(1),
  special_condition_product    VARCHAR2(1),
  special_condition_txncode    VARCHAR2(1),
  reg_d_applicable             CHAR(1),
  regd_periodicity             VARCHAR2(1),
  regd_start_date              DATE,
  regd_end_date                DATE,
  td_cert_printed              CHAR(1),
  checkbook_name_1             VARCHAR2(105),
  checkbook_name_2             VARCHAR2(105),
  auto_reorder_check_required  CHAR(1),
  auto_reorder_check_level     NUMBER(3),
  auto_reorder_check_leaves    NUMBER(3),
  netting_required             VARCHAR2(1) default 'N',
  referral_required            VARCHAR2(1) default 'N',
  lodgement_book_facility      VARCHAR2(1),
  acc_status                   VARCHAR2(4),
  status_since                 DATE,
  inherit_reporting            VARCHAR2(1),
  overdraft_since              DATE,
  prev_ovd_date                DATE,
  status_change_automatic      VARCHAR2(1),
  overline_od_since            DATE,
  tod_since                    DATE,
  prev_tod_since               DATE,
  dormant_param                VARCHAR2(1) default 'B',
  dr_int_due                   NUMBER,
  excl_sameday_rvrtrns_fm_stmt VARCHAR2(1) default 'N',
  allow_back_period_entry      CHAR(1) default 'N',
  auto_prov_reqd               VARCHAR2(1),
  exposure_category            VARCHAR2(20),
  risk_free_exp_amount         NUMBER(22,3),
  provision_amount             NUMBER(22,3),
  credit_txn_limit             NUMBER,
  cr_lm_start_date             DATE,
  cr_lm_rev_date               DATE,
  statement_account            VARCHAR2(20),
  account_derived_status       VARCHAR2(4),
  prov_ccy_type                VARCHAR2(1) default 'L',
  chg_due                      NUMBER,
  withdrawable_uncolled_fund   NUMBER(22,7),
  defer_recon                  VARCHAR2(1),
  consolidation_reqd           VARCHAR2(1),
  funding                      VARCHAR2(1),
  funding_branch               VARCHAR2(3),
  funding_account              VARCHAR2(20),
  mod9_validation_reqd         VARCHAR2(1),
  validation_digit             NUMBER(1),
  location                     VARCHAR2(15),
  media                        VARCHAR2(15),
  acc_tanked_stat              VARCHAR2(1),
  gen_interim_stmt             VARCHAR2(1),
  gen_interim_stmt_on_mvmt     VARCHAR2(1),
  gen_balance_report           VARCHAR2(1),
  interim_report_since         VARCHAR2(3),
  interim_report_type          VARCHAR2(1),
  balance_report_since         VARCHAR2(3),
  balance_report_type          VARCHAR2(1),
  interim_debit_amt            NUMBER(22,3),
  interim_credit_amt           NUMBER(22,3),
  interim_stmt_day_count       NUMBER(2),
  interim_stmt_ytd_count       NUMBER(4),
  mode_of_operation            CHAR(1),
  inf_acc_opening_amt          NUMBER(22,3),
  inf_pay_in_option            VARCHAR2(1),
  inf_offset_branch            VARCHAR2(3),
  inf_offset_account           VARCHAR2(20),
  inf_waive_acc_open_charge    VARCHAR2(1),
  daylight_limit_amount        NUMBER(22,3) default 0,
  trnover_lmt_code             VARCHAR2(10),
  passbook_number              NUMBER(16),
  country_code                 VARCHAR2(3),
  consol_chg_acc               VARCHAR2(20),
  escrow_transfer              CHAR(1) default 'N',
  escrow_branch_code           VARCHAR2(3),
  escrow_ac_no                 VARCHAR2(20),
  escrow_percentage            NUMBER(22,3),
  sod_notification_percent     NUMBER,
  salary_account               VARCHAR2(1),
  repl_cust_sig                CHAR(1),
  max_no_cheque_rejections     NUMBER,
  no_cheque_rejections         NUMBER,
  fund_id                      VARCHAR2(16),
  linked_dep_branch            VARCHAR2(3),
  linked_dep_acc               VARCHAR2(16),
  mudarabah_accounts           VARCHAR2(1) default 'N',
  zakat_exemption              VARCHAR2(1),
  account_auto_closed          VARCHAR2(1) default 'N',
  consol_chg_brn               VARCHAR2(3),
  no_of_chq_rej_reset_on       DATE,
  crs_stat_reqd                VARCHAR2(1) default 'N',
  contribute_to_pdm            CHAR(1),
  exclude_from_distribution    CHAR(1),
  ac_set_close                 CHAR(1),
  ac_set_close_date            DATE,
  project_account              VARCHAR2(1) default 'N',
  acy_sweep_ineligible         NUMBER,
  mt110_recon_reqd             VARCHAR2(1) default 'N',
  sweep_required               VARCHAR2(1),
  auto_deposit                 VARCHAR2(1),
  sweep_out                    VARCHAR2(1),
  auto_create_pool             VARCHAR2(1),
  last_purge_date              DATE,
  default_waiver               VARCHAR2(1) default 'N',
  auto_dc_request              CHAR(1) default 'N',
  auto_chqbk_request           CHAR(1) default 'N',
  nsf_blacklist_status         CHAR(1) default 'N',
  nsf_auto_update              VARCHAR2(1),
  intermediary_required        VARCHAR2(1)
)
partition by list (BRANCH_CODE)
(
  partition STTM_CUST_ACCOUNT_P000 values ('000')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P101 values ('101')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P102 values ('102')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P103 values ('103')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P104 values ('104')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P105 values ('105')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P106 values ('106')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P107 values ('107')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P108 values ('108')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P109 values ('109')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P110 values ('110')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P111 values ('111')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P112 values ('112')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P113 values ('113')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P114 values ('114')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P115 values ('115')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P116 values ('116')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P117 values ('117')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P118 values ('118')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P119 values ('119')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P120 values ('120')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P128 values ('128')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P129 values ('129')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P901 values ('901')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P121 values ('121')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P122 values ('122')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P123 values ('123')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P124 values ('124')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P125 values ('125')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P131 values ('131')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P132 values ('132')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P133 values ('133')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P134 values ('134')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P135 values ('135')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P136 values ('136')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P137 values ('137')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P141 values ('141')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P142 values ('142')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P143 values ('143')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P151 values ('151')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P152 values ('152')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P153 values ('153')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P161 values ('161')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P162 values ('162')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P163 values ('163')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P210 values ('210')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P211 values ('211')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P212 values ('212')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P213 values ('213')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P214 values ('214')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P215 values ('215')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P217 values ('217')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P219 values ('219')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P220 values ('220')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P221 values ('221')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P222 values ('222')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P223 values ('223')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P224 values ('224')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P225 values ('225')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P226 values ('226')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P227 values ('227')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P228 values ('228')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P229 values ('229')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P230 values ('230')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P231 values ('231')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P232 values ('232')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P233 values ('233')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P234 values ('234')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P235 values ('235')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P236 values ('236')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P237 values ('237')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P241 values ('241')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P242 values ('242')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P251 values ('251')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P252 values ('252')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P253 values ('253')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P261 values ('261')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P262 values ('262')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P263 values ('263')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P301 values ('301')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P302 values ('302')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P303 values ('303')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P304 values ('304')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P305 values ('305')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P306 values ('306')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P307 values ('307')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P308 values ('308')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P309 values ('309')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P310 values ('310')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P311 values ('311')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P312 values ('312')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P313 values ('313')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P314 values ('314')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P315 values ('315')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P316 values ('316')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P317 values ('317')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P318 values ('318')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P319 values ('319')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P320 values ('320')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P321 values ('321')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P322 values ('322')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P323 values ('323')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P324 values ('324')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P325 values ('325')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P326 values ('326')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P327 values ('327')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P328 values ('328')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P329 values ('329')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P330 values ('330')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P331 values ('331')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P332 values ('332')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P333 values ('333')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P334 values ('334')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P335 values ('335')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P336 values ('336')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P337 values ('337')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P338 values ('338')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P339 values ('339')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P340 values ('340')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P341 values ('341')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P342 values ('342')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P343 values ('343')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P344 values ('344')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P345 values ('345')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P346 values ('346')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P347 values ('347')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P348 values ('348')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P349 values ('349')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P350 values ('350')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P351 values ('351')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P352 values ('352')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P353 values ('353')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P354 values ('354')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P355 values ('355')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P356 values ('356')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P357 values ('357')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P358 values ('358')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P359 values ('359')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P360 values ('360')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P361 values ('361')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P362 values ('362')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P363 values ('363')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P364 values ('364')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P365 values ('365')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P366 values ('366')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P367 values ('367')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P368 values ('368')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P369 values ('369')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P370 values ('370')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P371 values ('371')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P372 values ('372')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P373 values ('373')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P374 values ('374')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P375 values ('375')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P376 values ('376')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P377 values ('377')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P378 values ('378')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P379 values ('379')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P380 values ('380')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P381 values ('381')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P382 values ('382')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P383 values ('383')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P384 values ('384')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P385 values ('385')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P386 values ('386')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P387 values ('387')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P388 values ('388')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P389 values ('389')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P390 values ('390')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P391 values ('391')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P392 values ('392')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P393 values ('393')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P394 values ('394')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P395 values ('395')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P396 values ('396')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P397 values ('397')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P398 values ('398')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P399 values ('399')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P401 values ('401')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P402 values ('402')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P411 values ('411')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P412 values ('412')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P413 values ('413')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P421 values ('421')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P422 values ('422')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P423 values ('423')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P424 values ('424')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P425 values ('425')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P426 values ('426')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P427 values ('427')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P431 values ('431')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P432 values ('432')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P433 values ('433')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P441 values ('441')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P442 values ('442')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P443 values ('443')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P451 values ('451')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P452 values ('452')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P461 values ('461')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P462 values ('462')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P501 values ('501')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P502 values ('502')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P503 values ('503')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P504 values ('504')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P505 values ('505')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P506 values ('506')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P507 values ('507')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P508 values ('508')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P509 values ('509')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P510 values ('510')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P511 values ('511')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P512 values ('512')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P513 values ('513')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P514 values ('514')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P515 values ('515')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P516 values ('516')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P517 values ('517')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P518 values ('518')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P519 values ('519')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P520 values ('520')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P521 values ('521')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P522 values ('522')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P523 values ('523')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P524 values ('524')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P525 values ('525')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P526 values ('526')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P527 values ('527')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P528 values ('528')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P529 values ('529')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P530 values ('530')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P531 values ('531')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P532 values ('532')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P533 values ('533')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P534 values ('534')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P535 values ('535')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P536 values ('536')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P537 values ('537')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P538 values ('538')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P539 values ('539')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P540 values ('540')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P541 values ('541')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P542 values ('542')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P543 values ('543')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P544 values ('544')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P545 values ('545')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P546 values ('546')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P547 values ('547')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P548 values ('548')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P549 values ('549')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P550 values ('550')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P551 values ('551')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P552 values ('552')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P553 values ('553')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P601 values ('601')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P602 values ('602')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P603 values ('603')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P604 values ('604')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P605 values ('605')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P606 values ('606')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P607 values ('607')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P608 values ('608')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P611 values ('611')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P612 values ('612')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P613 values ('613')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P614 values ('614')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P615 values ('615')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P616 values ('616')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P617 values ('617')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P618 values ('618')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P619 values ('619')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P620 values ('620')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P621 values ('621')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P622 values ('622')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P623 values ('623')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P624 values ('624')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P625 values ('625')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P631 values ('631')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P632 values ('632')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P633 values ('633')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P634 values ('634')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P701 values ('701')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P702 values ('702')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P703 values ('703')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P704 values ('704')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P705 values ('705')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P706 values ('706')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P707 values ('707')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P708 values ('708')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P709 values ('709')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P710 values ('710')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P711 values ('711')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P712 values ('712')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P713 values ('713')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P714 values ('714')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P715 values ('715')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P716 values ('716')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P717 values ('717')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P721 values ('721')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P722 values ('722')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P723 values ('723')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P724 values ('724')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P725 values ('725')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P731 values ('731')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P732 values ('732')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P733 values ('733')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P734 values ('734')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P735 values ('735')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P741 values ('741')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P742 values ('742')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P743 values ('743')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P744 values ('744')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P745 values ('745')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P746 values ('746')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P747 values ('747')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P748 values ('748')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P749 values ('749')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P751 values ('751')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P752 values ('752')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P753 values ('753')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P761 values ('761')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P771 values ('771')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P772 values ('772')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P773 values ('773')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P774 values ('774')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P775 values ('775')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P801 values ('801')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P802 values ('802')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P803 values ('803')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P804 values ('804')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P805 values ('805')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P806 values ('806')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P807 values ('807')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P808 values ('808')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P809 values ('809')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P810 values ('810')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P811 values ('811')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P812 values ('812')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P813 values ('813')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P814 values ('814')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P815 values ('815')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P816 values ('816')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P817 values ('817')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P821 values ('821')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P822 values ('822')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P823 values ('823')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P824 values ('824')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P825 values ('825')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P826 values ('826')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P827 values ('827')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P831 values ('831')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P832 values ('832')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P841 values ('841')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P842 values ('842')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P851 values ('851')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P852 values ('852')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P861 values ('861')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P862 values ('862')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P863 values ('863')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P871 values ('871')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P881 values ('881')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P882 values ('882')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P883 values ('883')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P891 values ('891')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTM_CUST_ACCOUNT_P999 values ('999')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP130 values ('130')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT126 values ('126')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT127 values ('127')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT138 values ('138')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT139 values ('139')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT140 values ('140')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT144 values ('144')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT145 values ('145')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT154 values ('154')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT155 values ('155')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT164 values ('164')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT216 values ('216')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT218 values ('218')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT238 values ('238')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT239 values ('239')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT240 values ('240')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT243 values ('243')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT244 values ('244')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT245 values ('245')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT246 values ('246')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT247 values ('247')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT248 values ('248')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT249 values ('249')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT250 values ('250')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT254 values ('254')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT255 values ('255')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT256 values ('256')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT257 values ('257')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT403 values ('403')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT404 values ('404')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT405 values ('405')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT406 values ('406')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT407 values ('407')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT408 values ('408')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT409 values ('409')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT410 values ('410')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT414 values ('414')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT428 values ('428')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT429 values ('429')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT430 values ('430')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT434 values ('434')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT435 values ('435')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT436 values ('436')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT437 values ('437')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT438 values ('438')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT439 values ('439')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT440 values ('440')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT444 values ('444')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT445 values ('445')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT446 values ('446')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT447 values ('447')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT448 values ('448')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT449 values ('449')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT450 values ('450')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT453 values ('453')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT454 values ('454')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT455 values ('455')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT456 values ('456')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT457 values ('457')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT458 values ('458')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT459 values ('459')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT460 values ('460')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT463 values ('463')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT464 values ('464')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT465 values ('465')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT466 values ('466')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT467 values ('467')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT468 values ('468')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT469 values ('469')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT470 values ('470')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT471 values ('471')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT472 values ('472')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT473 values ('473')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT474 values ('474')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT475 values ('475')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT476 values ('476')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT477 values ('477')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT478 values ('478')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT479 values ('479')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT480 values ('480')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT481 values ('481')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT482 values ('482')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT483 values ('483')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT484 values ('484')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT485 values ('485')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT486 values ('486')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT487 values ('487')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT488 values ('488')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT489 values ('489')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT490 values ('490')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT491 values ('491')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT492 values ('492')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT493 values ('493')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT554 values ('554')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT555 values ('555')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT556 values ('556')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT557 values ('557')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT558 values ('558')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT559 values ('559')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT560 values ('560')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT561 values ('561')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT562 values ('562')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT563 values ('563')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT564 values ('564')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT567 values ('567')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT609 values ('609')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT610 values ('610')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT626 values ('626')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT627 values ('627')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT628 values ('628')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT629 values ('629')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT630 values ('630')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT635 values ('635')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT636 values ('636')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT637 values ('637')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT638 values ('638')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT640 values ('640')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT718 values ('718')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT719 values ('719')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT720 values ('720')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT726 values ('726')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT727 values ('727')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT736 values ('736')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT737 values ('737')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT750 values ('750')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT754 values ('754')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT755 values ('755')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT762 values ('762')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT818 values ('818')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT819 values ('819')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT820 values ('820')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT828 values ('828')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT829 values ('829')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT830 values ('830')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT833 values ('833')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT834 values ('834')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT843 values ('843')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT853 values ('853')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT854 values ('854')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT884 values ('884')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT885 values ('885')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT886 values ('886')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNT892 values ('892')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP887 values ('887')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP494 values ('494')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP258 values ('258')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP259 values ('259')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP495 values ('495')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP415 values ('415')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP416 values ('416')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP417 values ('417')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP639 values ('639')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP146 values ('146')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP872 values ('872')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP844 values ('844')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP835 values ('835')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP496 values ('496')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP728 values ('728')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP565 values ('565')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP566 values ('566')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP568 values ('568')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP418 values ('418')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP419 values ('419')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP569 values ('569')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP729 values ('729')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP156 values ('156')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP420 values ('420')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP497 values ('497')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP498 values ('498')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP776 values ('776')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP641 values ('641')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP642 values ('642')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP643 values ('643')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP644 values ('644')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP836 values ('836')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP147 values ('147')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP201 values ('201')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP202 values ('202')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP203 values ('203')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP204 values ('204')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP205 values ('205')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP206 values ('206')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP207 values ('207')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP208 values ('208')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP209 values ('209')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP260 values ('260')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP264 values ('264')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP265 values ('265')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP266 values ('266')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP267 values ('267')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP268 values ('268')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP269 values ('269')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP270 values ('270')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP271 values ('271')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP272 values ('272')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP273 values ('273')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP274 values ('274')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP275 values ('275')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP645 values ('645')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition STTMCUSTACCOUNTP499 values ('499')
    tablespace FCCDATALAR
    pctfree 10
    initrans 16
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    )
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table STTM_CUST_ACCOUNT
  add constraint PK01_STTM_CUST_ACCOUNT primary key (BRANCH_CODE, CUST_AC_NO)
  using index 
  tablespace FCC114
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index HI100_1_CR on STTM_CUST_ACCOUNT (CR_GL)
  tablespace FCC114
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index HI100_1_DR on STTM_CUST_ACCOUNT (DR_GL)
  tablespace FCC114
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX01_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (ESCROW_AC_NO, ESCROW_BRANCH_CODE)
  tablespace FCCINDXSML
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index INDX1_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (BRANCH_CODE, ACCOUNT_TYPE, AUTH_STAT, RECORD_STAT, CUST_AC_NO)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IX01_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (CUST_NO)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IX03_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (MASTER_ACCOUNT_NO, BRANCH_CODE)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IX04_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (BRANCH_CODE, DORMANCY_DATE, AC_STAT_DORMANT)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IX05_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (BRANCH_CODE, STATEMENT_ACCOUNT);
create unique index UI01_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (BRANCH_CODE, ALT_AC_NO)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index UI02_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (ATM_CUST_AC_NO)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index UI04_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (BRANCH_CODE, CUST_AC_NO, RECORD_STAT)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 16
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index UI05_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (CUST_NO, CUST_AC_NO)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index UI06_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (CUST_AC_NO)
  tablespace FCCINDXLAR
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index XXI06_STTM_CUST_ACCOUNT on STTM_CUST_ACCOUNT (AUTH_STAT)
  tablespace FCC114
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Grant/Revoke object privileges 
grant select on STTM_CUST_ACCOUNT to AUDITOR;
grant select on STTM_CUST_ACCOUNT to FCCDEV;
grant select on STTM_CUST_ACCOUNT to FCCDWH;
grant select on STTM_CUST_ACCOUNT to FCCECH;
grant select on STTM_CUST_ACCOUNT to FCCZAINI;
grant select on STTM_CUST_ACCOUNT to READ_ONLY_ROLE;
