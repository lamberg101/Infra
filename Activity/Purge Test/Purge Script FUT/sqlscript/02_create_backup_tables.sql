drop table FBTB_TXNLOG_MASTER_HIST_BK;
CREATE TABLE FBTB_TXNLOG_MASTER_HIST_BK AS
    SELECT * FROM FBTB_TXNLOG_MASTER_HIST WHERE 1 = 2;

drop table FBTB_TXNLOG_DETAILS_HIST_BK;
CREATE TABLE FBTB_TXNLOG_DETAILS_HIST_BK AS
    SELECT * FROM FBTB_TXNLOG_DETAILS_HIST WHERE 1 = 2;