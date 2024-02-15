Plan hash value: 2637315847
---------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                                     | Name                      | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     | Pstart| Pstop |
---------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                              |                           |   506K|    35M|       |   256K  (1)| 00:51:14 |       |       |
|*  1 |  FILTER                                       |                           |       |       |       |            |          |       |       |
|*  2 |   VIEW                                        |                           |   506K|    35M|       |   256K  (1)| 00:51:14 |       |       |
|   3 |    COUNT                                      |                           |       |       |       |            |          |       |       |
|   4 |     VIEW                                      |                           |   506K|    29M|       |   256K  (1)| 00:51:14 |       |       |
|*  5 |      HASH JOIN                                |                           |   506K|    14M|  8912K|   256K  (1)| 00:51:14 |       |       |
|   6 |       PART JOIN FILTER CREATE                 | :BF0000                   |   506K|  2969K|       |   123K  (1)| 00:24:45 |       |       |
|   7 |        VIEW                                   | STVW_ACLASS_CUSTOMERS     |   506K|  2969K|       |   123K  (1)| 00:24:45 |       |       |
|   8 |         UNION-ALL                             |                           |       |       |       |            |          |       |       |
|   9 |          MINUS                                |                           |       |       |       |            |          |       |       |
|  10 |           SORT UNIQUE                         |                           |   506K|    20M|       |            |          |       |       |
|* 11 |            HASH JOIN                          |                           |   506K|    20M|       |   123K  (1)| 00:24:45 |       |       |
|  12 |             VIEW                              | STVW_ACLASS_CATEGORIES    |    68 |   816 |       |    28  (15)| 00:00:01 |       |       |
|  13 |              SORT UNIQUE                      |                           |    68 |  4200 |       |    28  (15)| 00:00:01 |       |       |
|  14 |               UNION-ALL                       |                           |       |       |       |            |          |       |       |
|  15 |                MINUS                          |                           |       |       |       |            |          |       |       |
|  16 |                 SORT UNIQUE                   |                           |    62 |  1860 |       |            |          |       |       |
|  17 |                  MERGE JOIN CARTESIAN         |                           |    62 |  1860 |       |    13   (0)| 00:00:01 |       |       |
|  18 |                   NESTED LOOPS                |                           |     5 |    90 |       |     3   (0)| 00:00:01 |       |       |
|* 19 |                    TABLE ACCESS BY INDEX ROWID| STTM_ACCOUNT_CLASS        |     1 |    12 |       |     2   (0)| 00:00:01 |       |       |
|* 20 |                     INDEX UNIQUE SCAN         | PK01_STTM_ACCOUNT_CLASS   |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 21 |                    INDEX RANGE SCAN           | PK01_STTM_ACCLS_CAT_RESTR |     5 |    30 |       |     1   (0)| 00:00:01 |       |       |
|  22 |                   BUFFER SORT                 |                           |    12 |   144 |       |    12   (0)| 00:00:01 |       |       |
|  23 |                    TABLE ACCESS BY INDEX ROWID| STTM_CUSTOMER_CAT         |    12 |   144 |       |     2   (0)| 00:00:01 |       |       |
|* 24 |                     INDEX RANGE SCAN          | XX22_STTMS_CUSTOMER_CAT   |    12 |       |       |     0   (0)| 00:00:01 |       |       |
|  25 |                 SORT UNIQUE                   |                           |     5 |   105 |       |            |          |       |       |
|  26 |                  NESTED LOOPS                 |                           |     5 |   105 |       |     3   (0)| 00:00:01 |       |       |
|* 27 |                   TABLE ACCESS BY INDEX ROWID | STTM_ACCOUNT_CLASS        |     1 |     8 |       |     2   (0)| 00:00:01 |       |       |
|* 28 |                    INDEX UNIQUE SCAN          | PK01_STTM_ACCOUNT_CLASS   |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 29 |                   INDEX RANGE SCAN            | PK01_STTM_ACCLS_CAT_RESTR |     5 |    65 |       |     1   (0)| 00:00:01 |       |       |
|  30 |                NESTED LOOPS                   |                           |     5 |   105 |       |     3   (0)| 00:00:01 |       |       |
|* 31 |                 TABLE ACCESS BY INDEX ROWID   | STTM_ACCOUNT_CLASS        |     1 |     8 |       |     2   (0)| 00:00:01 |       |       |
|* 32 |                  INDEX UNIQUE SCAN            | PK01_STTM_ACCOUNT_CLASS   |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 33 |                 INDEX RANGE SCAN              | PK01_STTM_ACCLS_CAT_RESTR |     5 |    65 |       |     1   (0)| 00:00:01 |       |       |
|  34 |                MERGE JOIN CARTESIAN           |                           |     1 |    30 |       |     5   (0)| 00:00:01 |       |       |
|  35 |                 NESTED LOOPS ANTI             |                           |     1 |    18 |       |     3   (0)| 00:00:01 |       |       |
|* 36 |                  TABLE ACCESS BY INDEX ROWID  | STTM_ACCOUNT_CLASS        |     1 |    12 |       |     2   (0)| 00:00:01 |       |       |
|* 37 |                   INDEX UNIQUE SCAN           | PK01_STTM_ACCOUNT_CLASS   |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 38 |                  INDEX RANGE SCAN             | PK01_STTM_ACCLS_CAT_RESTR |     5 |    30 |       |     1   (0)| 00:00:01 |       |       |
|  39 |                 BUFFER SORT                   |                           |    12 |   144 |       |     4   (0)| 00:00:01 |       |       |
|  40 |                  TABLE ACCESS BY INDEX ROWID  | STTM_CUSTOMER_CAT         |    12 |   144 |       |     2   (0)| 00:00:01 |       |       |
|* 41 |                   INDEX RANGE SCAN            | XX22_STTMS_CUSTOMER_CAT   |    12 |       |       |     0   (0)| 00:00:01 |       |       |
|  42 |             PARTITION HASH ALL                |                           |   156K|  4738K|       |   123K  (1)| 00:24:44 |     1 |   125 |
|* 43 |              TABLE ACCESS FULL                | STTM_CUSTOMER             |   156K|  4738K|       |   123K  (1)| 00:24:44 |     1 |   125 |
|  44 |           SORT UNIQUE                         |                           |     1 |    18 |       |            |          |       |       |
|* 45 |            TABLE ACCESS BY INDEX ROWID        | STTM_ACCLS_CUS_RESTR      |     1 |    18 |       |     2   (0)| 00:00:01 |       |       |
|* 46 |             INDEX RANGE SCAN                  | PK01_STTM_ACCLS_CUS_RESTR |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 47 |          TABLE ACCESS BY INDEX ROWID          | STTM_ACCLS_CUS_RESTR      |     1 |    18 |       |     2   (0)| 00:00:01 |       |       |
|* 48 |           INDEX RANGE SCAN                    | PK01_STTM_ACCLS_CUS_RESTR |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|  49 |       PARTITION HASH JOIN-FILTER              |                           |  5008K|   119M|       |   123K  (1)| 00:24:38 |:BF0000|:BF0000|
|* 50 |        TABLE ACCESS FULL                      | STTM_CUSTOMER             |  5008K|   119M|       |   123K  (1)| 00:24:38 |:BF0000|:BF0000|
---------------------------------------------------------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$1       
   2 - SEL$2        / from$_subquery$_001@SEL$1
   3 - SEL$2       
   4 - SEL$C8360722 / LOVALIAS@SEL$2
   5 - SEL$C8360722
   7 - SET$1        / A@SEL$5
   8 - SET$1       
  11 - SEL$6       
  12 - SET$2        / ACCAT@SEL$6
  13 - SET$2       
  17 - SEL$7       
  19 - SEL$7        / AC@SEL$7
  20 - SEL$7        / AC@SEL$7
  21 - SEL$7        / ACCAT@SEL$7
  23 - SEL$7        / CAT@SEL$7
  24 - SEL$7        / CAT@SEL$7
  26 - SEL$8       
  27 - SEL$8        / AC@SEL$8
  28 - SEL$8        / AC@SEL$8
  29 - SEL$8        / ACCAT@SEL$8
  30 - SEL$9       
  31 - SEL$9        / AC@SEL$9
  32 - SEL$9        / AC@SEL$9
  33 - SEL$9        / ACCAT@SEL$9
  34 - SEL$62973BB0
  36 - SEL$62973BB0 / AC@SEL$10
  37 - SEL$62973BB0 / AC@SEL$10
  38 - SEL$62973BB0 / STTMS_ACCLS_CAT_RESTR@SEL$11
  40 - SEL$62973BB0 / CAT@SEL$10
  41 - SEL$62973BB0 / CAT@SEL$10
  43 - SEL$6        / CUST@SEL$6
  45 - SEL$12       / STTMS_ACCLS_CUS_RESTR@SEL$12
  46 - SEL$12       / STTMS_ACCLS_CUS_RESTR@SEL$12
  47 - SEL$13       / STTMS_ACCLS_CUS_RESTR@SEL$13
  48 - SEL$13       / STTMS_ACCLS_CUS_RESTR@SEL$13
  50 - SEL$C8360722 / B@SEL$5
 
Outline Data
-------------
 
  /*+
      BEGIN_OUTLINE_DATA
      USE_MERGE_CARTESIAN(@"SEL$7" "CAT"@"SEL$7")
      USE_NL(@"SEL$7" "ACCAT"@"SEL$7")
      LEADING(@"SEL$7" "AC"@"SEL$7" "ACCAT"@"SEL$7" "CAT"@"SEL$7")
      INDEX_RS_ASC(@"SEL$7" "CAT"@"SEL$7" ("STTMS_CUSTOMER_CAT"."RECORD_STAT" "STTMS_CUSTOMER_CAT"."AUTH_STAT"))
      INDEX(@"SEL$7" "ACCAT"@"SEL$7" ("STTMS_ACCLS_CAT_RESTR"."ACCOUNT_CLASS" "STTMS_ACCLS_CAT_RESTR"."CUST_CAT"))
      INDEX_RS_ASC(@"SEL$7" "AC"@"SEL$7" ("STTMS_ACCOUNT_CLASS"."ACCOUNT_CLASS"))
      USE_NL(@"SEL$8" "ACCAT"@"SEL$8")
      LEADING(@"SEL$8" "AC"@"SEL$8" "ACCAT"@"SEL$8")
      INDEX(@"SEL$8" "ACCAT"@"SEL$8" ("STTMS_ACCLS_CAT_RESTR"."ACCOUNT_CLASS" "STTMS_ACCLS_CAT_RESTR"."CUST_CAT"))
      INDEX_RS_ASC(@"SEL$8" "AC"@"SEL$8" ("STTMS_ACCOUNT_CLASS"."ACCOUNT_CLASS"))
      USE_NL(@"SEL$9" "ACCAT"@"SEL$9")
      LEADING(@"SEL$9" "AC"@"SEL$9" "ACCAT"@"SEL$9")
      INDEX(@"SEL$9" "ACCAT"@"SEL$9" ("STTMS_ACCLS_CAT_RESTR"."ACCOUNT_CLASS" "STTMS_ACCLS_CAT_RESTR"."CUST_CAT"))
      INDEX_RS_ASC(@"SEL$9" "AC"@"SEL$9" ("STTMS_ACCOUNT_CLASS"."ACCOUNT_CLASS"))
      USE_MERGE_CARTESIAN(@"SEL$62973BB0" "CAT"@"SEL$10")
      USE_NL(@"SEL$62973BB0" "STTMS_ACCLS_CAT_RESTR"@"SEL$11")
      LEADING(@"SEL$62973BB0" "AC"@"SEL$10" "STTMS_ACCLS_CAT_RESTR"@"SEL$11" "CAT"@"SEL$10")
      INDEX_RS_ASC(@"SEL$62973BB0" "CAT"@"SEL$10" ("STTMS_CUSTOMER_CAT"."RECORD_STAT" "STTMS_CUSTOMER_CAT"."AUTH_STAT"))
      INDEX(@"SEL$62973BB0" "STTMS_ACCLS_CAT_RESTR"@"SEL$11" ("STTMS_ACCLS_CAT_RESTR"."ACCOUNT_CLASS" "STTMS_ACCLS_CAT_RESTR"."CUST_CAT"))
      INDEX_RS_ASC(@"SEL$62973BB0" "AC"@"SEL$10" ("STTMS_ACCOUNT_CLASS"."ACCOUNT_CLASS"))
      USE_HASH(@"SEL$6" "CUST"@"SEL$6")
      LEADING(@"SEL$6" "ACCAT"@"SEL$6" "CUST"@"SEL$6")
      FULL(@"SEL$6" "CUST"@"SEL$6")
      NO_ACCESS(@"SEL$6" "ACCAT"@"SEL$6")
      INDEX_RS_ASC(@"SEL$12" "STTMS_ACCLS_CUS_RESTR"@"SEL$12" ("STTMS_ACCLS_CUS_RESTR"."ACCOUNT_CLASS" "STTMS_ACCLS_CUS_RESTR"."CUSTOMER_NO"))
      INDEX_RS_ASC(@"SEL$13" "STTMS_ACCLS_CUS_RESTR"@"SEL$13" ("STTMS_ACCLS_CUS_RESTR"."ACCOUNT_CLASS" "STTMS_ACCLS_CUS_RESTR"."CUSTOMER_NO"))
      USE_HASH(@"SEL$C8360722" "B"@"SEL$5")
      LEADING(@"SEL$C8360722" "A"@"SEL$5" "B"@"SEL$5")
      FULL(@"SEL$C8360722" "B"@"SEL$5")
      NO_ACCESS(@"SEL$C8360722" "A"@"SEL$5")
      NO_ACCESS(@"SEL$2" "LOVALIAS"@"SEL$2")
      NO_ACCESS(@"SEL$1" "from$_subquery$_001"@"SEL$1")
      OUTLINE(@"SEL$5")
      OUTLINE(@"SEL$4")
      MERGE(@"SEL$5")
      OUTLINE(@"SEL$7286615E")
      OUTLINE(@"SEL$3")
      OUTLINE(@"SEL$11")
      OUTLINE(@"SEL$10")
      OUTLINE_LEAF(@"SEL$1")
      OUTLINE_LEAF(@"SEL$2")
      MERGE(@"SEL$7286615E")
      OUTLINE_LEAF(@"SEL$C8360722")
      OUTLINE_LEAF(@"SET$1")
      OUTLINE_LEAF(@"SEL$13")
      OUTLINE_LEAF(@"SEL$12")
      OUTLINE_LEAF(@"SEL$6")
      OUTLINE_LEAF(@"SET$2")
      UNNEST(@"SEL$11")
      OUTLINE_LEAF(@"SEL$62973BB0")
      OUTLINE_LEAF(@"SEL$9")
      OUTLINE_LEAF(@"SEL$8")
      OUTLINE_LEAF(@"SEL$7")
      ALL_ROWS
      OPT_PARAM('_optimizer_adaptive_cursor_sharing' 'false')
      OPT_PARAM('_optimizer_extended_cursor_sharing_rel' 'none')
      OPT_PARAM('_optimizer_extended_cursor_sharing' 'none')
      DB_VERSION('11.2.0.4')
      OPTIMIZER_FEATURES_ENABLE('11.2.0.4')
      IGNORE_OPTIM_EMBEDDED_HINTS
      END_OUTLINE_DATA
  */
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_NUMBER(:SYS_B_1)<TO_NUMBER(:SYS_B_2))
   2 - filter("RNO">TO_NUMBER(:SYS_B_1) AND "RNO"<=TO_NUMBER(:SYS_B_2))
   5 - access("A"."CUSTOMER_NO"="B"."CUSTOMER_NO")
  11 - access("ACCAT"."CUST_CAT"="CUST"."CUSTOMER_CATEGORY")
  19 - filter("AC"."CUSCAT_LIST"='D' AND "AC"."RECORD_STAT"='O' AND "AC"."AUTH_STAT"='A')
  20 - access("AC"."ACCOUNT_CLASS"=NVL(:1,:2))
  21 - access("ACCAT"."ACCOUNT_CLASS"=NVL(:1,:2))
  24 - access("CAT"."RECORD_STAT"='O' AND "CAT"."AUTH_STAT"='A')
  27 - filter("AC"."CUSCAT_LIST"='D')
  28 - access("AC"."ACCOUNT_CLASS"=NVL(:1,:2))
  29 - access("ACCAT"."ACCOUNT_CLASS"=NVL(:1,:2))
  31 - filter("AC"."CUSCAT_LIST"='A')
  32 - access("AC"."ACCOUNT_CLASS"=NVL(:1,:2))
  33 - access("ACCAT"."ACCOUNT_CLASS"=NVL(:1,:2))
  36 - filter("AC"."CUSCAT_LIST"='D' AND "AC"."RECORD_STAT"='O' AND "AC"."AUTH_STAT"='A')
  37 - access("AC"."ACCOUNT_CLASS"=NVL(:1,:2))
  38 - access("ACCOUNT_CLASS"=NVL(:1,:2))
  41 - access("CAT"."RECORD_STAT"='O' AND "CAT"."AUTH_STAT"='A')
  43 - filter("CUST"."AUTH_STAT"='A' AND "CUST"."RECORD_STAT"='O' AND NVL("CUST"."FROZEN",'N')='N' AND NVL("CUST"."DECEASED",'N')='N' AND 
              NVL("CUST"."WHEREABOUTS_UNKNOWN",'N')='N' AND "CUST"."CUSTOMER_NO"<>:3)
  45 - filter("ALLOWED"='N')
  46 - access("ACCOUNT_CLASS"=NVL(:1,:2))
       filter("CUSTOMER_NO"<>:3)
  47 - filter("ALLOWED"='Y')
  48 - access("ACCOUNT_CLASS"=NVL(:1,:2))
       filter("CUSTOMER_NO"<>:3)
  50 - filter("B"."CUSTOMER_NO"<>:3)
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - "from$_subquery$_001"."CUSTOMER_NO"[VARCHAR2,9], "from$_subquery$_001"."CUSTOMER_NAME1"[VARCHAR2,105], "RNO"[NUMBER,22]
   2 - "from$_subquery$_001"."CUSTOMER_NO"[VARCHAR2,9], "from$_subquery$_001"."CUSTOMER_NAME1"[VARCHAR2,105], "RNO"[NUMBER,22]
   3 - "LOVALIAS"."CUSTOMER_NO"[VARCHAR2,9], "LOVALIAS"."CUSTOMER_NAME1"[VARCHAR2,105], ROWNUM[4]
   4 - "LOVALIAS"."CUSTOMER_NO"[VARCHAR2,9], "LOVALIAS"."CUSTOMER_NAME1"[VARCHAR2,105]
   5 - (#keys=1) "A"."CUSTOMER_NO"[VARCHAR2,9], "B"."CUSTOMER_NAME1"[VARCHAR2,105]
   6 - "A"."CUSTOMER_NO"[VARCHAR2,9], "A"."CUSTOMER_NO"[VARCHAR2,9]
   7 - "A"."CUSTOMER_NO"[VARCHAR2,9]
   8 - STRDEF[6], STRDEF[9]
   9 - STRDEF[BM VAR, 6], STRDEF[BM VAR, 9]
  10 - (#keys=2) "ACCAT"."ACCOUNT_CLASS"[VARCHAR2,6], "CUST"."CUSTOMER_NO"[VARCHAR2,9]
  11 - (#keys=1) "ACCAT"."ACCOUNT_CLASS"[VARCHAR2,6], "CUST"."CUSTOMER_NO"[VARCHAR2,9]
  12 - "ACCAT"."ACCOUNT_CLASS"[VARCHAR2,6], "ACCAT"."CUST_CAT"[VARCHAR2,10]
  13 - (#keys=2) STRDEF[6], STRDEF[10]
  14 - STRDEF[6], STRDEF[10]
  15 - STRDEF[BM VAR, 6], STRDEF[BM VAR, 10]
  16 - (#keys=2) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "CAT"."CUST_CAT"[VARCHAR2,10]
  17 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "CAT"."CUST_CAT"[VARCHAR2,10]
  18 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  19 - "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  20 - "AC".ROWID[ROWID,10], "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  22 - (#keys=0) "CAT"."CUST_CAT"[VARCHAR2,10]
  23 - "CAT"."CUST_CAT"[VARCHAR2,10]
  24 - "CAT".ROWID[ROWID,10]
  25 - (#keys=2) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "ACCAT"."CUST_CAT"[VARCHAR2,10]
  26 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "ACCAT"."CUST_CAT"[VARCHAR2,10]
  27 - "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  28 - "AC".ROWID[ROWID,10], "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  29 - "ACCAT"."CUST_CAT"[VARCHAR2,10]
  30 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "ACCAT"."CUST_CAT"[VARCHAR2,10]
  31 - "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  32 - "AC".ROWID[ROWID,10], "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  33 - "ACCAT"."CUST_CAT"[VARCHAR2,10]
  34 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "CAT"."CUST_CAT"[VARCHAR2,10]
  35 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  36 - "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  37 - "AC".ROWID[ROWID,10], "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  39 - (#keys=0) "CAT"."CUST_CAT"[VARCHAR2,10]
  40 - "CAT"."CUST_CAT"[VARCHAR2,10]
  41 - "CAT".ROWID[ROWID,10]
  42 - "CUST"."CUSTOMER_NO"[VARCHAR2,9], "CUST"."CUSTOMER_CATEGORY"[VARCHAR2,10]
  43 - "CUST"."CUSTOMER_NO"[VARCHAR2,9], "CUST"."CUSTOMER_CATEGORY"[VARCHAR2,10]
  44 - (#keys=2) "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  45 - "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  46 - "STTMS_ACCLS_CUS_RESTR".ROWID[ROWID,10], "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  47 - "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  48 - "STTMS_ACCLS_CUS_RESTR".ROWID[ROWID,10], "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  49 - "B"."CUSTOMER_NO"[VARCHAR2,9], "B"."CUSTOMER_NAME1"[VARCHAR2,105]
  50 - "B"."CUSTOMER_NO"[VARCHAR2,9], "B"."CUSTOMER_NAME1"[VARCHAR2,105]