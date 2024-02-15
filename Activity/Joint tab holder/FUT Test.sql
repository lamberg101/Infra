explain plan for 
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


select distinct (table_name), stale_stats, last_analyzed 
from dba_tab_statistics 
where table_name in (
'STTM_ACCOUNT_CLASS',
'STTM_CUSTOMER_CAT',
'STTM_ACCLS_CUS_RESTR',
'STTM_CUSTOMER'
)
order by table_name asc;


select * from table(dbms_xplan.display(format=>'advanced'));



select * from dba_indexes where table_name='STTM_CUSTOMER';
select * from dba_ind_columns where table_name='STTM_CUSTOMER' and index_name='STTM_CUSTOMER_CUSTPAR';

select * from table(dbms_xplan.display(format=>'advanced'));

