-- Create table
create table STTM_CUSTOMER
(
  customer_no               VARCHAR2(9) not null,
  customer_type             CHAR(1),
  customer_name1            VARCHAR2(105),
  address_line1             VARCHAR2(105),
  address_line3             VARCHAR2(105),
  address_line2             VARCHAR2(105),
  address_line4             VARCHAR2(105),
  country                   VARCHAR2(3),
  short_name                VARCHAR2(20),
  nationality               VARCHAR2(3),
  language                  VARCHAR2(3),
  exposure_country          VARCHAR2(3),
  local_branch              VARCHAR2(3),
  liability_no              VARCHAR2(9),
  unique_id_name            VARCHAR2(20),
  unique_id_value           VARCHAR2(20),
  frozen                    CHAR(1),
  deceased                  CHAR(1),
  whereabouts_unknown       CHAR(1),
  customer_category         VARCHAR2(10),
  ho_ac_no                  VARCHAR2(105),
  record_stat               CHAR(1),
  auth_stat                 CHAR(1),
  mod_no                    NUMBER(4),
  maker_id                  VARCHAR2(12),
  maker_dt_stamp            DATE,
  checker_id                VARCHAR2(12),
  checker_dt_stamp          DATE,
  once_auth                 CHAR(1) default 'N',
  fx_cust_clean_risk_limit  NUMBER(22,3),
  overall_limit             NUMBER(24,3),
  fx_clean_risk_limit       NUMBER(24,3),
  credit_rating             VARCHAR2(10),
  revision_date             DATE,
  limit_ccy                 VARCHAR2(3),
  cas_cust                  CHAR(1),
  liab_node                 VARCHAR2(105),
  sec_cust_clean_risk_limit NUMBER(22,3),
  sec_clean_risk_limit      NUMBER(22,3),
  sec_cust_pstl_risk_limit  NUMBER(22,3),
  sec_pstl_risk_limit       NUMBER(22,3),
  liab_br                   VARCHAR2(3),
  past_due_flag             VARCHAR2(1),
  default_media             VARCHAR2(15),
  ssn                       VARCHAR2(11),
  swift_code                VARCHAR2(12),
  loc_code                  VARCHAR2(3),
  short_name2               VARCHAR2(20),
  utility_provider          VARCHAR2(1) default 'N',
  utility_provider_id       VARCHAR2(35),
  risk_profile              VARCHAR2(20),
  debtor_category           VARCHAR2(10),
  full_name                 VARCHAR2(105),
  udf_1                     VARCHAR2(150),
  udf_2                     VARCHAR2(150),
  udf_3                     VARCHAR2(150),
  udf_4                     VARCHAR2(150),
  udf_5                     VARCHAR2(150),
  aml_required              CHAR(1),
  aml_customer_grp          VARCHAR2(9),
  mailers_required          CHAR(1),
  group_code                VARCHAR2(10),
  exposure_category         VARCHAR2(20),
  cust_classification       VARCHAR2(20),
  cif_status                VARCHAR2(20),
  cif_status_since          DATE,
  charge_group              VARCHAR2(10),
  introducer                VARCHAR2(9),
  cust_clg_group            VARCHAR2(10),
  chk_digit_valid_reqd      VARCHAR2(1),
  alg_id                    VARCHAR2(20),
  ft_accting_as_of          VARCHAR2(1),
  unadvised                 VARCHAR2(1) default 'N',
  tax_group                 VARCHAR2(10),
  consol_tax_cert_reqd      VARCHAR2(1),
  individual_tax_cert_reqd  VARCHAR2(1),
  cls_ccy_allowed           VARCHAR2(1) default 'D',
  cls_participant           VARCHAR2(1),
  fx_netting_customer       VARCHAR2(9),
  risk_category             VARCHAR2(4),
  fax_number                VARCHAR2(105),
  ext_ref_no                VARCHAR2(20),
  crm_customer              VARCHAR2(1),
  issuer_customer           VARCHAR2(1),
  treasury_customer         VARCHAR2(1),
  cif_creation_date         DATE,
  wht_pct                   NUMBER,
  rp_customer               VARCHAR2(1),
  generate_mt920            VARCHAR2(1),
  kyc_details               VARCHAR2(1),
  staff                     VARCHAR2(1),
  kyc_ref_no                VARCHAR2(16),
  utility_provider_type     VARCHAR2(35),
  joint_venture             VARCHAR2(1) default 'N',
  jv_limit_tracking         VARCHAR2(1) default 'N',
  private_customer          VARCHAR2(1),
  lc_collateral_pct         NUMBER(7,4),
  elcm_customer             VARCHAR2(1) default 'Y',
  elcm_customer_no          VARCHAR2(20),
  auto_create_account       CHAR(1) default 'N',
  auto_cust_ac_no           VARCHAR2(20),
  track_limits              CHAR(1) default 'N',
  ar_ap_tracking            VARCHAR2(1),
  date_of_birth             DATE
)
partition by hash (CUSTOMER_NO)
(
  partition STTM_CUST_HASH_P100
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P101
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P102
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P103
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P104
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P105
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P106
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P107
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P108
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P109
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P110
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P111
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P112
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P113
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P114
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P115
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P116
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P117
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P118
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P119
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P120
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P121
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P122
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P123
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P124
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P125
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P126
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P127
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P128
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P129
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P130
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P131
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P132
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P133
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P134
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P135
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P136
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P137
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P138
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P139
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P140
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P141
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P142
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P143
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P144
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P145
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P146
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P147
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P148
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P149
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P150
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P151
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P152
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P153
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P154
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P155
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P156
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P157
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P158
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P159
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P160
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P161
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P162
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P163
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P164
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P165
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P166
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P167
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P168
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P169
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P170
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P171
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P172
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P173
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P174
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P175
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P176
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P177
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P178
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P179
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P180
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P181
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P182
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P183
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P184
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P185
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P186
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P187
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P188
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P189
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P190
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P191
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P192
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P193
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P194
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P195
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P196
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P197
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P198
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P199
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P200
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P201
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P202
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P203
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P204
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P205
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P206
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P207
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P208
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P209
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P210
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P211
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P212
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P213
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P214
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P215
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P216
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P217
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P218
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P219
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P220
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P901
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P902
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P998
    tablespace FCCDATALAR,
  partition STTM_CUST_HASH_P999
    tablespace FCCDATALAR
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table STTM_CUSTOMER
  add constraint PK01_STTM_CUSTOMER primary key (CUSTOMER_NO)
  using index 
  tablespace FCC114
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
-- Create/Recreate indexes 
create index IDX_STTM_CUST2 on STTM_CUSTOMER (UNIQUE_ID_NAME||UNIQUE_ID_VALUE)
  tablespace FCCINDXMED
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
create index INDX1_STTM_CUSTOMER on STTM_CUSTOMER (LIABILITY_NO)
  tablespace FCCINDXMED
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
create index IX05_STTMS_CUSTOMER on STTM_CUSTOMER (CUSTOMER_TYPE)
  tablespace FCCINDXMED
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
create index STTM_CUSTOMER_CONV1 on STTM_CUSTOMER (SHORT_NAME)
  tablespace FCCINDXMED
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
create index STTM_CUSTOMER_CONV2 on STTM_CUSTOMER (EXT_REF_NO)
  tablespace FCCINDXMED
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
create index STTM_CUSTOMER_CONV3 on STTM_CUSTOMER (UNIQUE_ID_NAME, UNIQUE_ID_VALUE)
  tablespace FCCINDXMED
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
create unique index STTM_CUSTOMER_CUSBRN on STTM_CUSTOMER (LOCAL_BRANCH, CUSTOMER_NO)
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
create index STTM_CUST_REC_INX on STTM_CUSTOMER (RECORD_STAT)
  tablespace FCCINDXMED
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
create index STTM_CUST_REC_INX1 on STTM_CUSTOMER (RECORD_STAT, ONCE_AUTH);
create unique index UI01_STTM_CUSTOMER on STTM_CUSTOMER (UTILITY_PROVIDER_ID)
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
create unique index UI02_STTM_CUSTOMER on STTM_CUSTOMER (SSN)
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
create index X3_STTM_CUSTOMER on STTM_CUSTOMER (SWIFT_CODE)
  tablespace FCCINDXMED
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
create index XX22_STTMS_CUSTOMER on STTM_CUSTOMER (CUSTOMER_CATEGORY)
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
grant select on STTM_CUSTOMER to AUDITOR;
grant select on STTM_CUSTOMER to FCCDEV;
grant select on STTM_CUSTOMER to FCCDWH;
grant select on STTM_CUSTOMER to FCCECH;
grant select on STTM_CUSTOMER to READ_ONLY_ROLE;
