--script fix sttm_cust_account
BEGIN
for i in (select /*+ PARALLEL 12 */ * from fcc114.sttm_cust_account)
loop
update /*+ PARALLEL 12 */ fcc114.sttm_cust_account
set AC_DESC= 'CUSTOMER_NO'||i.CUST_NO
where CUST_NO=i.CUST_NO;
end loop;
end;



--script fix sttm_customer 
BEGIN
for i in (select /*+ PARALLEL 12 */ * from fcc114.sttm_customer)
loop
update /*+ PARALLEL 12 */ fcc114.sttm_customer
set CUSTOMER_NAME1= 'CUSTOMER_'||i.CUSTOMER_NO,
FULL_NAME= 'CUSTOMER_'||i.CUSTOMER_NO
where CUSTOMER_NO=i.CUSTOMER_NO;
end loop;
end;
