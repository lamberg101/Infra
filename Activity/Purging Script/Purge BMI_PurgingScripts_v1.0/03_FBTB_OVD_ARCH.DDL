drop table FBTB_OVD_ARCH;
/*-- Create table */
create table FBTB_OVD_ARCH
(
  seq_no           NUMBER(2),
  xref             VARCHAR2(48),
  ib_ovd           VARCHAR2(1),
  txn_amt          NUMBER(22,3),
  txn_ovd          VARCHAR2(1),
  role_ovd         VARCHAR2(1),
  multitripid      VARCHAR2(30),
  ovd_code         VARCHAR2(200),
  err_param        VARCHAR2(2000),
  charge_amend     VARCHAR2(1),
  charge1          NUMBER(22,3),
  charge2          NUMBER(22,3),
  charge3          NUMBER(22,3),
  charge4          NUMBER(22,3),
  charge5          NUMBER(22,3),
  xrate            NUMBER,
  host_ovd         VARCHAR2(1),
  isdefer          VARCHAR2(1),
  brn_ovddate      DATE,
  default_auth     VARCHAR2(1),
  chg_ovd          VARCHAR2(1),
  userlimit_ovd    VARCHAR2(1),
  brnmultitripflag VARCHAR2(1),
  cashhold_ovd     VARCHAR2(1),
  cashdep_ovd      VARCHAR2(1),
  warningcode      VARCHAR2(1000),
  warningdesc      VARCHAR2(4000),
  authstat         VARCHAR2(1),
  checkerid        VARCHAR2(96),
  branchcode       VARCHAR2(3)
)
/
