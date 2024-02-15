UPDATE /*+ PARALLEL 12 */ FCC114.STTM_CUSTOMER a
SET (a.CUSTOMER_NAME1, a.FULL_NAME) = 
(
    SELECT b.CUSTOMER_NAME1,b.FULL_NAME
    from FCC114.STTM_CUSTOMER_MASK b
    where a.CUSTOMER_NO=b.CUSTOMER_NO
    and b.CUSTOMER_NO in (
    '004731362','004790958','000605693'
    )
)
where a.CUSTOMER_NO in (
'004731362','004790958','000605693'
)
;

update /*+ PARALLEL 12 */ fcc114.sttm_customer
set CUSTOMER_NAME1= 'CUSTOMER_'||CUSTOMER_NO,
FULL_NAME= 'CUSTOMER_'||CUSTOMER_NO
where CUSTOMER_NO=CUSTOMER_NO
and CUSTOMER_NO in ('004731362','004790958','000605693');

select * from sttm_customer where CUSTOMER_NO in ('004731362','004790958','000605693');
select * from sttm_customer_mask where CUSTOMER_NO in ('004731362','004790958','000605693');