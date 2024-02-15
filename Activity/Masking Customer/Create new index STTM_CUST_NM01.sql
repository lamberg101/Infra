create index FCC114.STTM_CUST_NM01 on FCC114.STTM_CUSTOMER (CUSTOMER_NAME1,FULL_NAME)
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
  )
  PARALLEL 16;

alter index FCC114.STTM_CUST_NM01 noparallel;