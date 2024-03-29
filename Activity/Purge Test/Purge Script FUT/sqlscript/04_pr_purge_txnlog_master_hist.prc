CREATE OR REPLACE PROCEDURE PR_PURGE_TXNLOG_MASTER_HIST
IS
  CURSOR CR_TXNLOG_MASTER_HIST IS
    select * from FBTB_TXNLOG_MASTER_HIST WHERE POSTINGDATE >= (SYSDATE - 60);

  CURSOR CR_TXNLOG_MASTER_HIST1 IS
    select * from FBTB_TXNLOG_MASTER_HIST_BK;

  TYPE TY_TXNLOG_MASTER_HIST IS TABLE OF CR_TXNLOG_MASTER_HIST%ROWTYPE INDEX BY BINARY_INTEGER;
  L_TXNLOG_MASTER_HIST TY_TXNLOG_MASTER_HIST;

  TYPE TY_TXNLOG_MASTER_HIST1 IS TABLE OF CR_TXNLOG_MASTER_HIST1%ROWTYPE INDEX BY BINARY_INTEGER;
  L_TXNLOG_MASTER_HIST1 TY_TXNLOG_MASTER_HIST1;

BEGIN
                   
  OPEN CR_TXNLOG_MASTER_HIST;
  LOOP
      FETCH CR_TXNLOG_MASTER_HIST BULK COLLECT INTO L_TXNLOG_MASTER_HIST LIMIT 10000;
      IF L_TXNLOG_MASTER_HIST.COUNT = 0
      THEN
          EXIT;
      ELSE
          FORALL I IN L_TXNLOG_MASTER_HIST.FIRST .. L_TXNLOG_MASTER_HIST.LAST
          INSERT INTO FBTB_TXNLOG_MASTER_HIST_BK VALUES L_TXNLOG_MASTER_HIST(I);

          COMMIT;
          L_TXNLOG_MASTER_HIST.DELETE;
      END IF;
  END LOOP;
  CLOSE CR_TXNLOG_MASTER_HIST;

  EXECUTE IMMEDIATE 'TRUNCATE TABLE FBTB_TXNLOG_MASTER_HIST';

  OPEN CR_TXNLOG_MASTER_HIST1;
  LOOP
      FETCH CR_TXNLOG_MASTER_HIST1 BULK COLLECT INTO L_TXNLOG_MASTER_HIST1 LIMIT 10000;
      IF L_TXNLOG_MASTER_HIST1.COUNT = 0
      THEN
          EXIT;
      ELSE
          FORALL I IN L_TXNLOG_MASTER_HIST1.FIRST .. L_TXNLOG_MASTER_HIST1.LAST
          INSERT INTO FBTB_TXNLOG_MASTER_HIST VALUES L_TXNLOG_MASTER_HIST1(I);

          COMMIT;
          L_TXNLOG_MASTER_HIST1.DELETE;
      END IF;
  END LOOP;
  CLOSE CR_TXNLOG_MASTER_HIST1;

  EXECUTE IMMEDIATE 'TRUNCATE TABLE FBTB_TXNLOG_MASTER_HIST_BK';
END;
/
