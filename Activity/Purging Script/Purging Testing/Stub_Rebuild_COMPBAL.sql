set head on
set array 1
set linesize 10000
set pagesize 50000
set long 10000
set echo on
set trimspool on
set colsep ';'
set numformat 9999999999999999.99
SPOOL D:\Bal_breakup.SPL

declare 
cursor Alacc is
select account_number from cltb_account_apps_master where account_number in (
select distinct A.account_number from FCC114.CLTB_ACCOUNT_COMP_BAL_BREAKUP a, FCC114.cltb_account_master b  where a.account_number=b.account_number and a.component='PRINCIPAL' AND A.BALANCE > b.AMOUNT_FINANCED AND B.ACCOUNT_STATUS='A'
) and account_status='A' and account_number in (select distinct A.account_number from FCC114.CLTB_ACCOUNT_COMP_BAL_BREAKUP a, FCC114.cltb_account_master b  
where a.account_number=b.account_number and a.component='PRINCIPAL' AND A.BALANCE > b.AMOUNT_FINANCED AND B.ACCOUNT_STATUS='A'
and (length(a.balance) > 15 or length(a.lcy_balance) > 15));


cursor c1(p_account varchar2) is
select USER_DEFINED_STATUS,sch_due, os_princ , b.*   from 
(
select 
A.ACCOUNT_NUMBER,  USER_DEFINED_STATUS ,  min( case when nvl(amount_settled,0) = 0 then schedule_due_date else null end) sch_due, 
sum(amount_due) - sum(amount_settled) os_princ -- ,
from cltb_account_schedules  A, cltb_account_apps_master B
where component_name = 'PRINCIPAL'
AND A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
 and account_status <>  'L'
GROUP BY   A. ACCOUNT_NUMBER, USER_DEFINED_STATUS
) a, 
(SELECT  a.*
FROM CLTB_ACCOUNT_COMP_BAL_BREAKUP A , cltb_account_apps_master B
WHERE 
COMPONENT ='PRINCIPAL'
AND A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
and account_status  <>  'L'
) b 
where a.account_number  = b.account_number  
and user_defined_status = status_code
and os_princ <> balance
and a.account_number =  p_account
;
c1rec c1%rowtype; 

cursor c2 (p_account varchar2) is
select USER_DEFINED_STATUS,sch_due, os_profit , b.*   from 
(
 select
A.ACCOUNT_NUMBER,  USER_DEFINED_STATUS ,  min( case when nvl(amount_settled,0) = 0 then schedule_due_date else null end) sch_due, 
sum(accrued_amount) - sum(amount_settled) os_profit -- ,
from cltb_account_schedules  A, cltb_account_apps_master B
where component_name = 'PROFIT' 
AND A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
 and account_status <>  'L'
GROUP BY   A. ACCOUNT_NUMBER, USER_DEFINED_STATUS
) a, 
(select * from CLTB_ACCOUNT_COMP_BAL_BREAKUP
where ( account_number, component,   status_code, creation_date) 
in
(SELECT  a.account_number, component,   status_code, max(creation_date)  creation_date 
FROM CLTB_ACCOUNT_COMP_BAL_BREAKUP A , cltb_account_apps_master B 
WHERE 
COMPONENT ='PROFIT'
AND A.ACCOUNT_NUMBER = B.ACCOUNT_NUMBER
and account_status  <>  'L' 
and user_defined_status = status_code
 group by a.account_number, component,  status_code
)
)  b 
where a.account_number  = b.account_number   
and user_defined_status = status_code
and os_profit <> balance
and a.account_number = p_account;
c2rec c2%rowtype; 

begin 
for acc in Alacc loop
Dbms_Output.put_line('Updating PRINCIPAL'||acc.account_number);
 update CLTB_ACCOUNT_COMP_BAL_BREAKUP 
   set balance = 0,
   lcy_balance = 0 
   where  COMPONENT ='PRINCIPAL'  
   and account_number  =    acc.account_number;
OPEN c1 (acc.account_number);
LOOP
Dbms_Output.put_line('Updating PRINCIPAL1'||c1rec.account_number);
   FETCH c1 INTO  c1rec ;
   EXIT WHEN c1%NOTFOUND;
    
   update CLTB_ACCOUNT_COMP_BAL_BREAKUP 
   set balance = c1rec.os_princ,
   lcy_balance = c1rec.os_princ  
   where  account_number  =    c1rec.account_number
   and status_code = c1rec.user_defined_status 
   and component = 'PRINCIPAL' ;
   
   /*update CLTB_ACCOUNT_COMP_BAL_BREAKUP 
   set balance = 0,
   lcy_balance = 0 
   where  COMPONENT ='PRINCIPAL'  
   and account_number  =    c2rec.account_number
   and 
   (gl_code  <> c2rec.gl_code
   or gl_type  <>  c2rec.gl_type
   or creation_date <> c2rec.creation_date 
   or status_code <> c2rec.user_defined_status
   )
   ; */
      
  commit;  
  Dbms_Output.put_line('Updated PRINCIPAL'||c1rec.account_number);
END LOOP;
CLOSE c1;

--PROFIT

OPEN c2(acc.account_number);
LOOP
Dbms_Output.put_line('Updating PROFIT'||c1rec.account_number);
   FETCH c2 INTO  c2rec ;
   EXIT WHEN c2%NOTFOUND;
   update CLTB_ACCOUNT_COMP_BAL_BREAKUP 
   set balance = c2rec.os_profit,
   lcy_balance = c2rec.os_profit 
   where  account_number  =    c2rec.account_number
   and gl_code  = c2rec.gl_code
   and gl_type  =  c2rec.gl_type  
   and creation_date = c2rec.creation_date
   and status_code = c2rec.user_defined_status
   and COMPONENT ='PROFIT';
   
   update CLTB_ACCOUNT_COMP_BAL_BREAKUP 
   set balance = 0,
   lcy_balance = 0 
   where  COMPONENT ='PROFIT'  
   and account_number  =    c2rec.account_number
   and 
   (gl_code  <> c2rec.gl_code
   or gl_type  <>  c2rec.gl_type
   or creation_date <> c2rec.creation_date 
   or status_code <> c2rec.user_defined_status
   )
   ; 
  commit;  
  Dbms_Output.put_line('Updated PROFIT'||c1rec.account_number);
END LOOP;
CLOSE c2;

end loop;
end;  
/

--delete from fcc114.CLTB_ACCOUNT_COMP_BAL_BREAKUP where component ='PRINCIPAL' and and GL_code ='123001004' and account_number in ('363C301171180002');
--commit;

set echo off
spool off

