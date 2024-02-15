
set time on;
set timing on;

!echo this is A
update /*+ PARALLEL 12 */ fcc114.sttm_cust_account
set AC_DESC= 'CUSTOMER_NO'||CUST_NO
where CUST_NO=CUST_NO
and AC_DESC like 'A%'; 
commit;

exit;


update /*+ PARALLEL 12 */ fcc114.sttm_cust_account
where CUST_NO=CUST_NO
and AC_DESC like 'A%'; 
commit;

UPDATE TableA
SET TableA.column1 = TableB.column1,
    TableA.column2 = TableB.column2,
    -- Repeat for all columns to be updated
FROM TableB
WHERE TableA.primary_key = TableB.primary_key;


UPDATE /*+ PARALLEL 12 */ FCC114.STTM_CUSTOMER
SET (CUSTOMER_NAME1, FULL_NAME) = 
(
    SELECT CUSTOMER_NAME1, FULL_NAME
    from STTM_CUSTOMER_MASK
    WHERE CUSTOMER_NO in ('004731362');
);


update /*+ PARALLEL 12 */ fcc114.sttm_customer
set CUSTOMER_NAME1= 'CUSTOMER_'||i.CUSTOMER_NO,
FULL_NAME= 'CUSTOMER_'||i.CUSTOMER_NO
where CUSTOMER_NO=i.CUSTOMER_NO