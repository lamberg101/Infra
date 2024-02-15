drop table FBTB_TXNLOG_DETAILS_HIST_TMP;
/*-- Create table */
create table FBTB_TXNLOG_DETAILS_HIST_TMP
(
  branchcode     VARCHAR2(30),
  functionid     VARCHAR2(96),
  xrefid         VARCHAR2(192),
  userid         VARCHAR2(96),
  txnstageid     VARCHAR2(192),
  txnstatus      VARCHAR2(765),
  timestamp      DATE,
  checkerid      VARCHAR2(192),
  errorcode      CLOB,
  reqxml         CLOB,
  respxml        CLOB,
  onlinestatus   VARCHAR2(30),
  stagestartdate DATE,
  stageenddate   DATE,
  advice         CLOB,
  advicexml      VARCHAR2(600),
  stagestatus    VARCHAR2(30),
  inputslip      CLOB,
  inputslipxml   VARCHAR2(600)
)
/
