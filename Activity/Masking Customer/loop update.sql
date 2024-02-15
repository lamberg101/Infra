--script fix sttm_cust_account
BEGIN
for i in (select /*+ PARALLEL 12 */ * from fcc114.sttm_cust_account)
loop
update /*+ PARALLEL 12 */ fcc114.sttm_cust_account
set AC_DESC= 'CUSTOMER_NO'||i.CUST_NO
where CUST_NO=i.CUST_NO;
end loop;
end;


--script fix  sttm_customer
BEGIN
for i in (select /*+ PARALLEL 12 */ * from fcc114.sttm_customer)
loop
update /*+ PARALLEL 12 */ fcc114.sttm_customer
set CUSTOMER_NAME1= 'CUSTOMER_'||i.CUSTOMER_NO,
FULL_NAME= 'CUSTOMER_'||i.CUSTOMER_NO
where CUSTOMER_NO=i.CUSTOMER_NO
and ;
end loop;
end;



create index FCC114.TEMP_AC_DESC_idx on FCC114.STTM_CUST_ACCOUNT (AC_DESC);



explain plan for

BEGIN
for i in (select /*+ PARALLEL 12 */ * from fcc114.sttm_customer)
loop
update /*+ PARALLEL 12 */ fcc114.sttm_customer
set CUSTOMER_NAME1= 'CUSTOMER_'||i.CUSTOMER_NO,
FULL_NAME= 'CUSTOMER_'||i.CUSTOMER_NO
where CUSTOMER_NO=i.CUSTOMER_NO
and CUSTOMER_NAME1 like '%DEDY';
end loop;
end;



UPDATE /*+ PARALLEL 12 */ FCC114.STTM_CUSTOMER a
SET (a.CUSTOMER_NAME1, a.FULL_NAME) = 
(
    SELECT b.CUSTOMER_NAME1, b.FULL_NAME
    from FCC114.STTM_CUSTOMER_MASK b
    WHERE b.CUSTOMER_NO in ('004731362')
)
where a.CUSTOMER_NO=b.CUSTOMER_NO
and a.CUSTOMER_NO in ('004731362')
;

explain plan for
UPDATE /*+ PARALLEL(12) */ fcc114.sttm_customer
SET CUSTOMER_NAME1 = 'CUSTOMER_' || CUSTOMER_NO,
    FULL_NAME = 'CUSTOMER_' || CUSTOMER_NO;




select * from sttm_customer where CUSTOMER_NAME1='DEDY' ;
