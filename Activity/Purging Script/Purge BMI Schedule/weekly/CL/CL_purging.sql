set serveroutput on size 1000000
set head on
set array 1
set linesize 10000
set pagesize 50000
set long 10000
set colsep ";"
set echo on
set trimspool on
set numformat 9999999999999999.99

set verify off

col spoolname new_value spoolname
select 'CL_Hist_Purge_'||to_char(sysdate,'ddmmyyyy')||'.spl' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;

set timing on

select count(*) From fcc114.cltb_account_apps_master A
where  A.account_status in ('L','V') 
and (select max(b.paid_date) From fcc114.cltb_amount_paid b
where a.account_number = b.account_number
and a.branch_code = b.branch_code) <= trunc(sysdate-365)
order by branch_code;

declare
  cursor cur(p_Date date) is
    select A.account_number, A.Branch_Code
      From fcc114.cltb_account_apps_master A
     where A.account_status in ('L', 'V')
       and (select max(b.paid_date)
              From fcc114.cltb_amount_paid b
             where a.account_number = b.account_number
               and a.branch_code = b.branch_code) <= p_Date
     order by branch_code;

  p_purge_Date DATE;

  ty_tb_accs dbms_sql.varchar2s;
  ty_tb_bran dbms_sql.varchar2s;
begin

select trunc(sysdate-365) into p_purge_Date from dual;

  OPEN cur(p_purge_Date);
  loop
  
    ty_tb_accs.delete;
  
    FETCH cur BULK COLLECT
      INTO ty_tb_accs, ty_tb_bran LIMIT 10000;
    Begin
      IF ty_tb_accs.COUNT > 0 THEN
      
        FORALL i IN ty_tb_accs.FIRST .. ty_tb_accs.LAST
          INSERT INTO fcc114.CLTB_ACCOUNT_SCHED_HIST_ARCH
            SELECT *
              FROM fcc114.CLTB_ACCOUNT_SCHEDULES_HISTORY
             where account_number = ty_tb_accs(i)
               and branch_code = ty_tb_bran(i);
      
        FORALL i IN ty_tb_accs.FIRST .. ty_tb_accs.LAST
          DELETE FROM fcc114.CLTB_ACCOUNT_SCHEDULES_HISTORY
           where account_number = ty_tb_accs(i)
             and branch_code = ty_tb_bran(i);
      
        --------------------------------------------------------------------------------------        
        FORALL i IN ty_tb_accs.FIRST .. ty_tb_accs.LAST
          INSERT INTO fcc114.CLTB_COMP_CALC_HIST_ARCH
            SELECT *
              FROM fcc114.CLTB_COMP_CALC_HISTORY
             where account_number = ty_tb_accs(i)
               and branch_code = ty_tb_bran(i);
      
        FORALL i IN ty_tb_accs.FIRST .. ty_tb_accs.LAST
          DELETE FROM fcc114.CLTB_COMP_CALC_HISTORY
           where account_number = ty_tb_accs(i)
             and branch_code = ty_tb_bran(i);
        --------------------------------------------------------------------------------------          
        FORALL i IN ty_tb_accs.FIRST .. ty_tb_accs.LAST
          INSERT INTO fcc114.CLTB_COMP_BALANCES_HIST_ARCH
            SELECT *
              FROM fcc114.CLTB_COMP_BALANCES_HISTORY
             where account_number = ty_tb_accs(i)
               and branch_code = ty_tb_bran(i);
      
        FORALL i IN ty_tb_accs.FIRST .. ty_tb_accs.LAST
          DELETE FROM fcc114.CLTB_COMP_BALANCES_HISTORY
           where account_number = ty_tb_accs(i)
             and branch_code = ty_tb_bran(i);
      
        --------------------------------------------------------------------------------------    
        commit;
      
      END IF;
    exception
      when others then
        rollback;
    end;
    EXIT WHEN cur%NOTFOUND;
  end loop;
  CLOSE cur;
end;
/

select count(*) From fcc114.cltb_account_apps_master A
where  A.account_status in ('L','V') 
and (select max(b.paid_date) From fcc114.cltb_amount_paid b
where a.account_number = b.account_number
and a.branch_code = b.branch_code) <= trunc(sysdate-365)
order by branch_code;

set timing off

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') end from dual;

SPOOL OFF;
exit;
