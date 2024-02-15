Plan hash value: 323467499
 
--------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                                    | Name                      | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     | Pstart| Pstop |
--------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                             |                           |   952K|    66M|       |   141K  (1)| 00:28:18 |       |       |
|*  1 |  FILTER                                      |                           |       |       |       |            |          |       |       |
|*  2 |   VIEW                                       |                           |   952K|    66M|       |   141K  (1)| 00:28:18 |       |       |
|   3 |    COUNT                                     |                           |       |       |       |            |          |       |       |
|   4 |     VIEW                                     |                           |   952K|    54M|       |   141K  (1)| 00:28:18 |       |       |
|*  5 |      HASH JOIN                               |                           |   952K|    32M|    20M|   141K  (1)| 00:28:18 |       |       |
|   6 |       VIEW                                   | STVW_ACLASS_CUSTOMERS     |   952K|     9M|       |   121K  (1)| 00:24:19 |       |       |
|   7 |        UNION-ALL                             |                           |       |       |       |            |          |       |       |
|   8 |         MINUS                                |                           |       |       |       |            |          |       |       |
|   9 |          SORT UNIQUE                         |                           |   952K|    39M|       |            |          |       |       |
|* 10 |           HASH JOIN                          |                           |   952K|    39M|       |   121K  (1)| 00:24:19 |       |       |
|  11 |            VIEW                              | STVW_ACLASS_CATEGORIES    |    60 |   720 |       |    18  (23)| 00:00:01 |       |       |
|  12 |             SORT UNIQUE                      |                           |    60 |  3740 |       |    18  (23)| 00:00:01 |       |       |
|  13 |              UNION-ALL                       |                           |       |       |       |            |          |       |       |
|  14 |               MINUS                          |                           |       |       |       |            |          |       |       |
|  15 |                SORT UNIQUE                   |                           |    54 |  1620 |       |            |          |       |       |
|  16 |                 MERGE JOIN CARTESIAN         |                           |    54 |  1620 |       |     7   (0)| 00:00:01 |       |       |
|  17 |                  NESTED LOOPS                |                           |     5 |    90 |       |     2   (0)| 00:00:01 |       |       |
|* 18 |                   TABLE ACCESS BY INDEX ROWID| STTM_ACCOUNT_CLASS        |     1 |    12 |       |     1   (0)| 00:00:01 |       |       |
|* 19 |                    INDEX UNIQUE SCAN         | PK01_STTM_ACCOUNT_CLASS   |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 20 |                   INDEX RANGE SCAN           | PK01_STTM_ACCLS_CAT_RESTR |     5 |    30 |       |     1   (0)| 00:00:01 |       |       |
|  21 |                  BUFFER SORT                 |                           |    12 |   144 |       |     6   (0)| 00:00:01 |       |       |
|  22 |                   TABLE ACCESS BY INDEX ROWID| STTM_CUSTOMER_CAT         |    12 |   144 |       |     1   (0)| 00:00:01 |       |       |
|* 23 |                    INDEX RANGE SCAN          | XX22_STTMS_CUSTOMER_CAT   |    12 |       |       |     1   (0)| 00:00:01 |       |       |
|  24 |                SORT UNIQUE                   |                           |     5 |   110 |       |            |          |       |       |
|  25 |                 NESTED LOOPS                 |                           |     5 |   110 |       |     2   (0)| 00:00:01 |       |       |
|* 26 |                  TABLE ACCESS BY INDEX ROWID | STTM_ACCOUNT_CLASS        |     1 |     8 |       |     1   (0)| 00:00:01 |       |       |
|* 27 |                   INDEX UNIQUE SCAN          | PK01_STTM_ACCOUNT_CLASS   |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 28 |                  INDEX RANGE SCAN            | PK01_STTM_ACCLS_CAT_RESTR |     5 |    70 |       |     1   (0)| 00:00:01 |       |       |
|  29 |               NESTED LOOPS                   |                           |     5 |   110 |       |     2   (0)| 00:00:01 |       |       |
|* 30 |                TABLE ACCESS BY INDEX ROWID   | STTM_ACCOUNT_CLASS        |     1 |     8 |       |     1   (0)| 00:00:01 |       |       |
|* 31 |                 INDEX UNIQUE SCAN            | PK01_STTM_ACCOUNT_CLASS   |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 32 |                INDEX RANGE SCAN              | PK01_STTM_ACCLS_CAT_RESTR |     5 |    70 |       |     1   (0)| 00:00:01 |       |       |
|  33 |               MERGE JOIN CARTESIAN           |                           |     1 |    30 |       |     3   (0)| 00:00:01 |       |       |
|  34 |                NESTED LOOPS ANTI             |                           |     1 |    18 |       |     2   (0)| 00:00:01 |       |       |
|* 35 |                 TABLE ACCESS BY INDEX ROWID  | STTM_ACCOUNT_CLASS        |     1 |    12 |       |     1   (0)| 00:00:01 |       |       |
|* 36 |                  INDEX UNIQUE SCAN           | PK01_STTM_ACCOUNT_CLASS   |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 37 |                 INDEX RANGE SCAN             | PK01_STTM_ACCLS_CAT_RESTR |     5 |    30 |       |     1   (0)| 00:00:01 |       |       |
|  38 |                BUFFER SORT                   |                           |    12 |   144 |       |     2   (0)| 00:00:01 |       |       |
|  39 |                 TABLE ACCESS BY INDEX ROWID  | STTM_CUSTOMER_CAT         |    12 |   144 |       |     1   (0)| 00:00:01 |       |       |
|* 40 |                  INDEX RANGE SCAN            | XX22_STTMS_CUSTOMER_CAT   |    12 |       |       |     1   (0)| 00:00:01 |       |       |
|  41 |            PARTITION HASH ALL                |                           |   333K|     9M|       |   121K  (1)| 00:24:19 |     1 |   125 |
|* 42 |             TABLE ACCESS BY LOCAL INDEX ROWID| STTM_CUSTOMER             |   333K|     9M|       |   121K  (1)| 00:24:19 |     1 |   125 |
|* 43 |              INDEX RANGE SCAN                | STTM_CUST_REC_INX1        |  2667K|       |       |  3528   (1)| 00:00:43 |     1 |   125 |
|  44 |          SORT UNIQUE                         |                           |     1 |    18 |       |            |          |       |       |
|* 45 |           TABLE ACCESS BY INDEX ROWID        | STTM_ACCLS_CUS_RESTR      |     1 |    18 |       |     1   (0)| 00:00:01 |       |       |
|* 46 |            INDEX RANGE SCAN                  | PK01_STTM_ACCLS_CUS_RESTR |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|* 47 |         TABLE ACCESS BY INDEX ROWID          | STTM_ACCLS_CUS_RESTR      |     1 |    18 |       |     1   (0)| 00:00:01 |       |       |
|* 48 |          INDEX RANGE SCAN                    | PK01_STTM_ACCLS_CUS_RESTR |     1 |       |       |     1   (0)| 00:00:01 |       |       |
|  49 |       PARTITION HASH ALL                     |                           |  5334K|   127M|       |  9433   (2)| 00:01:54 |     1 |   125 |
|* 50 |        INDEX FAST FULL SCAN                  | STTM_CUSTOMER_CUSTPAR     |  5334K|   127M|       |  9433   (2)| 00:01:54 |     1 |   125 |
--------------------------------------------------------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$1       
   2 - SEL$2        / from$_subquery$_001@SEL$1
   3 - SEL$2       
   4 - SEL$C8360722 / LOVALIAS@SEL$2
   5 - SEL$C8360722
   6 - SET$1        / A@SEL$5
   7 - SET$1       
  10 - SEL$6       
  11 - SET$2        / ACCAT@SEL$6
  12 - SET$2       
  16 - SEL$7       
  18 - SEL$7        / AC@SEL$7
  19 - SEL$7        / AC@SEL$7
  20 - SEL$7        / ACCAT@SEL$7
  22 - SEL$7        / CAT@SEL$7
  23 - SEL$7        / CAT@SEL$7
  25 - SEL$8       
  26 - SEL$8        / AC@SEL$8
  27 - SEL$8        / AC@SEL$8
  28 - SEL$8        / ACCAT@SEL$8
  29 - SEL$9       
  30 - SEL$9        / AC@SEL$9
  31 - SEL$9        / AC@SEL$9
  32 - SEL$9        / ACCAT@SEL$9
  33 - SEL$62973BB0
  35 - SEL$62973BB0 / AC@SEL$10
  36 - SEL$62973BB0 / AC@SEL$10
  37 - SEL$62973BB0 / STTMS_ACCLS_CAT_RESTR@SEL$11
  39 - SEL$62973BB0 / CAT@SEL$10
  40 - SEL$62973BB0 / CAT@SEL$10
  42 - SEL$6        / CUST@SEL$6
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
      INDEX_RS_ASC(@"SEL$6" "CUST"@"SEL$6" ("STTMS_CUSTOMER"."RECORD_STAT" "STTMS_CUSTOMER"."ONCE_AUTH"))
      NO_ACCESS(@"SEL$6" "ACCAT"@"SEL$6")
      INDEX_RS_ASC(@"SEL$12" "STTMS_ACCLS_CUS_RESTR"@"SEL$12" ("STTMS_ACCLS_CUS_RESTR"."ACCOUNT_CLASS" "STTMS_ACCLS_CUS_RESTR"."CUSTOMER_NO"))
      INDEX_RS_ASC(@"SEL$13" "STTMS_ACCLS_CUS_RESTR"@"SEL$13" ("STTMS_ACCLS_CUS_RESTR"."ACCOUNT_CLASS" "STTMS_ACCLS_CUS_RESTR"."CUSTOMER_NO"))
      USE_HASH(@"SEL$C8360722" "B"@"SEL$5")
      LEADING(@"SEL$C8360722" "A"@"SEL$5" "B"@"SEL$5")
      INDEX_FFS(@"SEL$C8360722" "B"@"SEL$5" ("STTMS_CUSTOMER"."CUSTOMER_NO" "STTMS_CUSTOMER"."SHORT_NAME" "STTMS_CUSTOMER"."CUSTOMER_NAME1"))
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
      OPT_PARAM('optimizer_index_caching' 90)
      OPT_PARAM('optimizer_index_cost_adj' 50)
      OPT_PARAM('_optimizer_adaptive_cursor_sharing' 'false')
      OPT_PARAM('_optimizer_extended_cursor_sharing_rel' 'none')
      OPT_PARAM('_optimizer_connect_by_cost_based' 'false')
      OPT_PARAM('_optimizer_extended_cursor_sharing' 'none')
      OPT_PARAM('_optimizer_cost_based_transformation' 'off')
      OPT_PARAM('query_rewrite_enabled' 'false')
      DB_VERSION('11.2.0.4')
      OPTIMIZER_FEATURES_ENABLE('11.2.0.4')
      IGNORE_OPTIM_EMBEDDED_HINTS
      END_OUTLINE_DATA
  */
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_NUMBER(:SYS_B_2)>TO_NUMBER(:SYS_B_1))
   2 - filter("RNO"<=TO_NUMBER(:SYS_B_2) AND "RNO">TO_NUMBER(:SYS_B_1))
   5 - access("A"."CUSTOMER_NO"="B"."CUSTOMER_NO")
  10 - access("ACCAT"."CUST_CAT"="CUST"."CUSTOMER_CATEGORY")
  18 - filter("AC"."CUSCAT_LIST"='D' AND "AC"."RECORD_STAT"='O' AND "AC"."AUTH_STAT"='A')
  19 - access("AC"."ACCOUNT_CLASS"=NVL(:1,:2))
  20 - access("ACCAT"."ACCOUNT_CLASS"=NVL(:1,:2))
  23 - access("CAT"."RECORD_STAT"='O' AND "CAT"."AUTH_STAT"='A')
  26 - filter("AC"."CUSCAT_LIST"='D')
  27 - access("AC"."ACCOUNT_CLASS"=NVL(:1,:2))
  28 - access("ACCAT"."ACCOUNT_CLASS"=NVL(:1,:2))
  30 - filter("AC"."CUSCAT_LIST"='A')
  31 - access("AC"."ACCOUNT_CLASS"=NVL(:1,:2))
  32 - access("ACCAT"."ACCOUNT_CLASS"=NVL(:1,:2))
  35 - filter("AC"."CUSCAT_LIST"='D' AND "AC"."RECORD_STAT"='O' AND "AC"."AUTH_STAT"='A')
  36 - access("AC"."ACCOUNT_CLASS"=NVL(:1,:2))
  37 - access("ACCOUNT_CLASS"=NVL(:1,:2))
  40 - access("CAT"."RECORD_STAT"='O' AND "CAT"."AUTH_STAT"='A')
  42 - filter(NVL("CUST"."FROZEN",'N')='N' AND NVL("CUST"."DECEASED",'N')='N' AND NVL("CUST"."WHEREABOUTS_UNKNOWN",'N')='N' AND 
              "CUST"."CUSTOMER_NO"<>:3 AND "CUST"."AUTH_STAT"='A')
  43 - access("CUST"."RECORD_STAT"='O')
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
   6 - "A"."CUSTOMER_NO"[VARCHAR2,9]
   7 - STRDEF[6], STRDEF[9]
   8 - STRDEF[BM VAR, 6], STRDEF[BM VAR, 9]
   9 - (#keys=2) "ACCAT"."ACCOUNT_CLASS"[VARCHAR2,6], "CUST"."CUSTOMER_NO"[VARCHAR2,9]
  10 - (#keys=1) "ACCAT"."ACCOUNT_CLASS"[VARCHAR2,6], "CUST"."CUSTOMER_NO"[VARCHAR2,9]
  11 - "ACCAT"."ACCOUNT_CLASS"[VARCHAR2,6], "ACCAT"."CUST_CAT"[VARCHAR2,10]
  12 - (#keys=2) STRDEF[6], STRDEF[10]
  13 - STRDEF[6], STRDEF[10]
  14 - STRDEF[BM VAR, 6], STRDEF[BM VAR, 10]
  15 - (#keys=2) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "CAT"."CUST_CAT"[VARCHAR2,10]
  16 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "CAT"."CUST_CAT"[VARCHAR2,10]
  17 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  18 - "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  19 - "AC".ROWID[ROWID,10], "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  21 - (#keys=0) "CAT"."CUST_CAT"[VARCHAR2,10]
  22 - "CAT"."CUST_CAT"[VARCHAR2,10]
  23 - "CAT".ROWID[ROWID,10]
  24 - (#keys=2) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "ACCAT"."CUST_CAT"[VARCHAR2,10]
  25 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "ACCAT"."CUST_CAT"[VARCHAR2,10]
  26 - "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  27 - "AC".ROWID[ROWID,10], "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  28 - "ACCAT"."CUST_CAT"[VARCHAR2,10]
  29 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "ACCAT"."CUST_CAT"[VARCHAR2,10]
  30 - "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  31 - "AC".ROWID[ROWID,10], "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  32 - "ACCAT"."CUST_CAT"[VARCHAR2,10]
  33 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6], "CAT"."CUST_CAT"[VARCHAR2,10]
  34 - (#keys=0) "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  35 - "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  36 - "AC".ROWID[ROWID,10], "AC"."ACCOUNT_CLASS"[VARCHAR2,6]
  38 - (#keys=0) "CAT"."CUST_CAT"[VARCHAR2,10]
  39 - "CAT"."CUST_CAT"[VARCHAR2,10]
  40 - "CAT".ROWID[ROWID,10]
  41 - "CUST"."CUSTOMER_NO"[VARCHAR2,9], "CUST"."CUSTOMER_CATEGORY"[VARCHAR2,10]
  42 - "CUST"."CUSTOMER_NO"[VARCHAR2,9], "CUST"."CUSTOMER_CATEGORY"[VARCHAR2,10]
  43 - "CUST".ROWID[ROWID,10]
  44 - (#keys=2) "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  45 - "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  46 - "STTMS_ACCLS_CUS_RESTR".ROWID[ROWID,10], "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  47 - "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  48 - "STTMS_ACCLS_CUS_RESTR".ROWID[ROWID,10], "ACCOUNT_CLASS"[VARCHAR2,6], "CUSTOMER_NO"[VARCHAR2,9]
  49 - "B"."CUSTOMER_NO"[VARCHAR2,9], "B"."CUSTOMER_NAME1"[VARCHAR2,105]
  50 - "B"."CUSTOMER_NO"[VARCHAR2,9], "B"."CUSTOMER_NAME1"[VARCHAR2,105]