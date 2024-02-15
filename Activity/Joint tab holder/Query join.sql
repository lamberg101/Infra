select *
  from (select Lovalias.*,
               rownum Rno
          from (select *
                  from (select CUSTOMER_NO,
                               CUSTOMER_NAME1
                          from (select A.CUSTOMER_NO,
                                       B.SHORT_NAME,
                                       B.CUSTOMER_NAME1
                                  from STVWS_ACLASS_CUSTOMERS A,
                                       STTMS_CUSTOMER         B
                                 where A.CUSTOMER_NO = B.CUSTOMER_NO
                                       and A.ACCOUNT_CLASS = NVL(:1, :2)
                                       and A.CUSTOMER_NO <> :3))
                 order by :"SYS_B_0") Lovalias)
where Rno > :"SYS_B_1"
       and Rno <= :"SYS_B_2";


select table_name, owner, stale_stats, last_analyzed 
from dba_tab_statistics 
where table_name in (
'STVW_ACLASS_CUSTOMERS',
'STVW_ACLASS_CATEGORIES',
'STTM_ACCOUNT_CLASS',
'STTM_CUSTOMER_CAT',
'PK01_STTM_ACCOUNT_CLASS',
'STTM_CUSTOMER',
'STTM_ACCLS_CUS_RESTR'
)
order by last_analyzed asc;