CREATE OR REPLACE PACKAGE BODY GIPKS_ARCHIVE_CUSTOM AS
 /*
  ----------------------------------------------------------------------------------------------------
  **
  ** File Name : GIPKS_ARCHIVE_CUSTOM.SQL
  **
  ** Module : CS
  **
  ** This source is part of the FLEXCUBE Software System
  ** and is copyrighted by Oracle Financial Services Software Limited.
  **
  ** All rights reserved.  No part of this work may be reproduced,
  ** stored in a retrieval system, adopted or transmitted in any form
  ** or by any means, electronic, mechanical, photographic, graphic,
  ** optic recording or otherwise, translated in any language or
  ** computer language, without the prior written permission from
  ** Oracle Financial Services Software Limited.
  **
  ** Oracle Financial Services Software Limited.
  ** 10-11, SDF I, SEEPZ, Andheri (East),
  ** Mumbai - 400 096.
  ** India.
  **** Copyright © 2001- 2011 by Oracle Financial Services Software Limited.
  ----------------------------------------------------------------------------------------------------
  */
  /*
  ----------------------------------------------------------------------------------------------------
        CHANGE HISTORY:
   **   Created By       : Kushab Dhule
   **   Created On       : 23-Aug-2021
   **   Reason           : Purge tables through batch automatically

   Note: Please maintain new tables to be purged in the "CSTB_PARAM_PURGDTLS_BMI" table before adding code in this package.
   
  ----------------------------------------------------------------------------------------------------
  */
  

  G_ARCHIVE_COMMIT_FREQ NUMBER;
  G_ARCHIVE_RETAIN_DAYS NUMBER;
  G_ARCHIVE_TILL_DATE DATE;
  PROCEDURE DBG(P_MSG VARCHAR2) IS
    L_MSG VARCHAR2(32767);
  BEGIN
    IF DEBUG.PKG_DEBUG_ON <> 2 THEN
      L_MSG := 'GIPKS_ARCHIVE_CUSTOM>>' || P_MSG;
      DEBUG.PR_DEBUG('GI', L_MSG);
    END IF;
  END DBG;
  
  FUNCTION FN_Cal_purgeDate(P_TABLE_NM      IN VARCHAR2,
                            P_DATE          OUT DATE,
                            P_Purg_req      OUT Varchar2,
                            P_Err_msg       IN OUT Varchar2) RETURN BOOLEAN IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    l_Nxt_Purge_dt date:=NULL;
  BEGIN
    DBG('Inside GIPKS_ARCHIVE_CUSTOM.FN_Cal_purgeDate..');
    Begin
      Select trunc(sysdate - nvl(retention_days, 90)),
             trunc(sysdate + nvl(retention_days, 90)),
             Purg_req
        into P_DATE, l_Nxt_Purge_dt, P_Purg_req
        from CSTB_PARAM_PURGDTLS_BMI
       where table_name = P_TABLE_NM;
      DBG('K-Got Purge_Date(P_DATE): '||P_DATE||' #l_Nxt_Purge_dt: '||l_Nxt_Purge_dt||' #P_Purg_req: '||P_Purg_req);
    Exception
      When others then
        P_Err_msg:='K-Failed to get P_date with err: '||Sqlerrm;
        P_Purg_req:='N';
        DBG(P_Err_msg);
    End;
    If P_Purg_req='Y' Then
      Update CSTB_PARAM_PURGDTLS_BMI cpp
       Set cpp.last_purg_dt=sysdate,
           cpp.next_purg_dt=l_Nxt_Purge_dt
      where table_name=P_TABLE_NM;
      Commit;
      DBG('K-Updated CSTB_PARAM_PURGDTLS_BMI for rows: '||Sql%rowcount);
    End If;
    DBG('Exiting GIPKS_ARCHIVE_CUSTOM.FN_Cal_purgeDate..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      P_Err_msg:='Error in fn_archive_sm' || SQLERRM || '~' ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      DBG(P_Err_msg);
      RETURN FALSE;
  END FN_Cal_purgeDate;

  PROCEDURE pr_purge_accrual(p_brn VARCHAR2) IS
    l_commit_freq          PLS_INTEGER := 10000;
    l_today                DATE;
    l_is_month_end         CHAR;
    l_month_end        	   DATE;
    purge_till_date        DATE;
    p_retn_period          NUMBER;
    purge_date             DATE;
    l_month_begn           DATE;
    p_ins_succ             BOOLEAN;
    TYPE ty_rowid IS TABLE of rowid INDEX BY BINARY_INTEGER;
    tb_rowid               ty_rowid;

     cursor cr_icent_hist_accr is
           SELECT rowid
            FROM ictbs_entries_history
            WHERE brn = p_brn
            AND acc in (select cust_ac_no from sttm_cust_account where branch_code=p_brn)
        and prod in (select product_code from ictm_product_definition where nvl(DEP,'N') <> 'Y')
        and prod in (select product_code from ictm_pr_int where nvl(back_calc_flag,'N') ='N')
            AND accr ='Y'
            AND LIQN = 'N'
            AND ent_dt <= trunc(sysdate-365);

      PROCEDURE pr_log(p_Branch  VARCHAR2,
                                 p_date    DATE,
                                 p_status  VARCHAR2,
                                 p_Errm    VARCHAR2) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
      BEGIN

        INSERT INTO ictb_purge_store
          (BRANCH_CODE, RUN_DATE, STATUS,ERROR)
        VALUES
          (p_Branch, p_date, p_status,p_Errm);

        update ICTB_PURGE_MONITOR
        set end_time = sysdate
        where branch_code = p_branch
            and run_dt=p_date
          and pmode='ACCR';

        COMMIT;

      EXCEPTION
        WHEN OTHERS THEN
           debug.pr_debug('IC','pr_log-> ' || SQLERRM);
          COMMIT;
      END pr_log;

     BEGIN
     global.pr_init(p_brn);
     debug.pr_debug('IC','Inside purging of accrual history');
     l_today:=global.application_date;
     debug.pr_debug('IC','Today date is :'||l_today);


     /*The below code shall be uncommented if the accrual or liquidation is based on retention period
     p_retn_period := nvl(cspkss_os_param.get_param_val('IC_RETN_PERIOD'),0);
     if nvl(cspkss_os_param.get_param_val('IC_ENTRIES_PURGING'),'N') <> 'Y' and p_retn_period <=0
     then
         pr_log(p_brn,global.application_date,'F','Purging Parameter is maintained as N');
         RETURN;
     end if;
     */


     if nvl(cspkss_os_param.get_param_val('IC_ENTRIES_PURGING'),'N') <> 'Y'
     then
         pr_log(p_brn,global.application_date,'F','Purging Parameter is maintained as N');
         RETURN;
     end if;


      /* The below code shall be uncommented if the accrual or liquidation is based on retention period
      IF CEPKS_DATE.fn_isceop(l_today,'MONTH') THEN
             l_is_month_end := 'Y';
     ELSE
                 l_is_month_end := 'N';
     END IF;
     debug.pr_debug('IC','Month End is :'||l_is_month_end);

         IF l_is_month_end='Y' THEN
             purge_till_date:=add_months(l_today,-p_retn_period);
             debug.pr_debug('IC',' purge_till_date:'||purge_till_date);
         ELSE
                  l_month_end := add_months(last_day(l_today),-1);
                  purge_till_date:=add_months( l_month_end,-p_retn_period);
                  debug.pr_debug('IC','purge_till_date:'||purge_till_date);
         END IF;
      */
      --purge_date :=cepks_date.fn_getcbop(l_today,'MONTH');
      insert into ICTB_PURGE_MONITOR
      values
      (p_brn
      ,'ACCR'
      ,global.application_date
      ,sysdate
      ,sysdate
      );
         OPEN cr_icent_hist_accr;
         LOOP

             FETCH cr_icent_hist_accr BULK COLLECT
                    INTO tb_rowid
             LIMIT l_commit_freq;
                  p_ins_succ :=FALSE;
                  IF  tb_rowid.count > 0 then
                    BEGIN
                     FORALL ent in tb_rowid.first .. tb_rowid.last
                       insert into ictb_entries_history_archive
                       select * from ictbs_entries_history where rowid = tb_rowid(ent) ;
                       COMMIT;
               p_ins_succ :=TRUE;
                    EXCEPTION
                    WHEN others THEN
                debug.pr_debug('IC','Archive Failed ' || sqlerrm );
              Declare
                        l_error_count number := 0;
                        j             number := 0;
              Begin
                        l_error_count := SQL%BULK_EXCEPTIONS.count;

                        For I IN 1 .. l_error_count LOOP
                          j := 0;

                          FOR k IN tb_rowid.FIRST .. tb_rowid.LAST LOOP
                            j := j + 1;
                            if j = SQL%BULK_EXCEPTIONS(i).error_index then
                              begin
                                pr_log(p_brn
                        ,global.application_date
                      ,'F','ACCR purge failed with ' || '~' ||tb_rowid(k) || '~' ||substr(SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE),1,1900)
                      );
                              exception
                                when others then
                                  null;
                              end;
                              exit;
                            end if;
                          End loop;
                        end loop;
                        End;
            end;
                  END IF;

            IF  tb_rowid.count > 0 and p_ins_succ then
                      FORALL ent in tb_rowid.first .. tb_rowid.last
                       delete from ictbs_entries_history where rowid=tb_rowid(ent) ;
                       COMMIT;
                  END IF;

              EXIT WHEN cr_icent_hist_accr%NOTFOUND;
         END LOOP;

         IF  cr_icent_hist_accr%isopen then
               CLOSE cr_icent_hist_accr;
         END IF;

     pr_log(p_brn,global.application_date,'S','ACCR Purging completed');
     COMMIT;

    debug.pr_debug('IC','Accrual Purging ends');
    EXCEPTION
        WHEN OTHERS THEN
          debug.pr_debug('IC','Error in pr_purge_accrual WOT ' || SQLERRM);
         pr_log(p_brn,global.application_date,'F','ACCR Purging Failed'||SQLERRM);
          ROLLBACK;
    END  pr_purge_accrual;
    
    PROCEDURE pr_purge_liquidation(p_brn VARCHAR2) IS
      l_commit_freq          PLS_INTEGER := 10000;
      l_today                DATE;
      purge_till_date        DATE;
      l_ret_dt          	   DATE;
      TYPE ty_rowid IS TABLE of rowid INDEX BY BINARY_INTEGER;
      tb_rowid               ty_rowid;
      p_retn_period          NUMBER;
      p_ins_succ             BOOLEAN;
       cursor cr_icent_hist_liqn is
             SELECT rowid
              FROM ictbs_entries_history
              WHERE brn = p_brn
              AND acc in (select cust_ac_no from sttm_cust_account where branch_code=p_brn)
          and prod in (select product_code from ictm_product_definition where nvl(DEP,'N') <> 'Y')
          and prod in (select product_code from ictm_pr_int where nvl(back_calc_flag,'N') ='N')
          AND LIQN = 'Y'
              AND ent_dt <= trunc(sysdate-365);

      PROCEDURE pr_log(p_Branch  VARCHAR2,
                                   p_date    DATE,
                                   p_status  VARCHAR2,
                                   p_Errm    VARCHAR2) IS
          PRAGMA AUTONOMOUS_TRANSACTION;
        BEGIN

          INSERT INTO ictb_purge_store
            (BRANCH_CODE, RUN_DATE, STATUS,ERROR)
          VALUES
            (p_Branch, p_date, p_status,p_Errm);

         update ICTB_PURGE_MONITOR
          set end_time = sysdate
          where branch_code = p_branch
              and run_dt=p_date
            and pmode='IC_LIQN';
          COMMIT;

        EXCEPTION
          WHEN OTHERS THEN
             debug.pr_debug('IC','pr_log-> ' || SQLERRM);
            COMMIT;
        END pr_log;



       BEGIN
       global.pr_init(p_brn);
       debug.pr_debug('IC','Inside purging of liquidation history');
       l_today:=global.application_date;
       debug.pr_debug('IC','Today date is :'||l_today);


       /* The below code shall be uncommented if the accrual or liquidation is based on retention period
       p_retn_period := nvl(cspkss_os_param.get_param_val('IC_RETN_PERIOD'),0);
       if nvl(cspkss_os_param.get_param_val('IC_ENTRIES_PURGING'),'N') <> 'Y' and p_retn_period <=0
       then
           pr_log(p_brn,global.application_date,'F',' Verify Purging Parameter and Retention Period');
           RETURN;
       end if;

       l_ret_dt:=add_months(l_today,-p_retn_period);
       purge_till_date :=cepks_date.fn_getcbop(l_ret_dt,'MONTH');
       debug.pr_debug('IC',' purge_till_date:'||purge_till_date);
       */

       if nvl(cspkss_os_param.get_param_val('IC_ENTRIES_PURGING'),'N') <> 'Y'
       then
           pr_log(p_brn,global.application_date,'F','Purging Parameter is maintained as N');
           RETURN;
       end if;
       --purge_till_date :=cepks_date.fn_getcbop(l_today,'MONTH');
           insert into ICTB_PURGE_MONITOR
           values
           (p_brn,
            'IC_LIQN',
            global.application_date,
            sysdate,
            sysdate);
           OPEN cr_icent_hist_liqn;
           LOOP

               FETCH cr_icent_hist_liqn BULK COLLECT
                      INTO tb_rowid
               LIMIT l_commit_freq;
                    p_ins_succ :=FALSE;
                    IF  tb_rowid.count > 0 then

                      begin
               FORALL ent in tb_rowid.first .. tb_rowid.last
                         insert into ictb_entries_history_archive
                         select * from ictbs_entries_history where rowid = tb_rowid(ent) ;
                         COMMIT;
                 p_ins_succ :=TRUE;
              EXCEPTION
              WHEN others THEN
                  debug.pr_debug('IC','Archive Failed ' || sqlerrm );
                Declare
                          l_error_count number := 0;
                          j             number := 0;
                Begin
                          l_error_count := SQL%BULK_EXCEPTIONS.count;

                          For I IN 1 .. l_error_count LOOP
                            j := 0;

                            FOR k IN tb_rowid.FIRST .. tb_rowid.LAST LOOP
                              j := j + 1;
                              if j = SQL%BULK_EXCEPTIONS(i).error_index then
                                begin
                                  pr_log(p_brn
                          ,global.application_date
                        ,'F','IC_LIQN purge failed with ' || '~' ||tb_rowid(k) || '~' ||substr(SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE),1,1900)
                        );
                                exception
                                  when others then
                                    null;
                                end;
                                exit;
                              end if;
                            End loop;
                          end loop;
                          End;
              end;
                    END IF;

              IF  tb_rowid.count > 0 and p_ins_succ then

                       FORALL ent in tb_rowid.first .. tb_rowid.last
                        DELETE FROM  ictbs_entries_history WHERE rowid=tb_rowid(ent) ;
                         COMMIT;
                    END IF;


                EXIT WHEN cr_icent_hist_liqn%NOTFOUND;
           END LOOP;

           IF  cr_icent_hist_liqn%isopen then
                 CLOSE cr_icent_hist_liqn;
           END IF;
      pr_log(p_brn,global.application_date,'S','IC_LIQN Purging completed');
          COMMIT;

      debug.pr_debug('IC','Liquidation Purging ends');
  EXCEPTION
      WHEN OTHERS THEN
        debug.pr_debug('IC','Error in pr_purge_accrual WOT ' || SQLERRM);
      pr_log(p_brn,global.application_date,'F','IC_LIQN Purging Failed'||SQLERRM);
        ROLLBACK;
  END  pr_purge_liquidation;
  
  PROCEDURE pr_purge_td(p_brn VARCHAR2) IS
    l_commit_freq          PLS_INTEGER := 10000;
    l_today                DATE;
    purge_till_date        DATE;
    l_is_month_end         CHAR;
    l_month_end        	   DATE;
    l_cnt                  NUMBER;
    p_ins_succ             BOOLEAN;
    TYPE ty_rowid IS TABLE of rowid INDEX BY BINARY_INTEGER;
    tb_rowid               ty_rowid;
    p_retn_period          NUMBER;
     cursor cr_icent_hist_liqn is
           SELECT rowid
            FROM ictbs_entries_history a
            WHERE brn = p_brn
        AND acc in (select cust_ac_no from sttm_cust_account where branch_code=p_brn and record_stat='C')
        AND prod in (select product_code from ictm_product_definition where nvl(dep,'N') = 'Y')
        AND ent_dt <= trunc(sysdate-365);

    PROCEDURE pr_log(p_Branch  VARCHAR2,
                     p_date    DATE,
                     p_status  VARCHAR2,
                     p_Errm    VARCHAR2) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
      BEGIN

        INSERT INTO ictb_purge_store
          (BRANCH_CODE, RUN_DATE, STATUS,ERROR)
        VALUES
          (p_Branch, p_date, p_status,p_Errm);

         update ICTB_PURGE_MONITOR
        set end_time = sysdate
        where branch_code = p_branch
            and run_dt=p_date
          and pmode='TD_CLOSE';

        COMMIT;

      EXCEPTION
        WHEN OTHERS THEN
           debug.pr_debug('IC','pr_log-> ' || SQLERRM);
          ROLLBACK;
      END pr_log;

     BEGIN
     global.pr_init(p_brn);
     debug.pr_debug('IC','Inside purging of liquidation history');
     l_today:=global.application_date;
     debug.pr_debug('IC','Today date is :'||l_today);

      if nvl(cspkss_os_param.get_param_val('IC_ENTRIES_PURGING'),'N') <> 'Y'
     then
         pr_log(p_brn,global.application_date,'F',' Verify Purging Parameter');
         RETURN;
     end if;

     --purge_till_date :=cepks_date.fn_getcbop(l_today,'MONTH');

     insert into ICTB_PURGE_MONITOR
     values
     (p_brn,
     'TD_CLOSE',
     global.application_date,
     sysdate,
     sysdate);
         OPEN cr_icent_hist_liqn;
         LOOP

             FETCH cr_icent_hist_liqn BULK COLLECT
                    INTO tb_rowid
             LIMIT l_commit_freq;
                p_ins_succ :=FALSE;
                 IF  tb_rowid.count > 0 then
                    BEGIN
                     FORALL ent in tb_rowid.first .. tb_rowid.last
                       insert into ictb_entries_history_archive
                       select * from ictbs_entries_history where rowid = tb_rowid(ent) ;
                       COMMIT;
               p_ins_succ :=TRUE;
                    EXCEPTION
                    WHEN others THEN
                debug.pr_debug('IC','Archive Failed ' || sqlerrm );
              Declare
                        l_error_count number := 0;
                        j             number := 0;
              Begin
                        l_error_count := SQL%BULK_EXCEPTIONS.count;

                        For I IN 1 .. l_error_count LOOP
                          j := 0;

                          FOR k IN tb_rowid.FIRST .. tb_rowid.LAST LOOP
                            j := j + 1;
                            if j = SQL%BULK_EXCEPTIONS(i).error_index then
                              begin
                                pr_log(p_brn
                        ,global.application_date
                      ,'F','TD_CLOSE purge failed with ' || '~' ||tb_rowid(k) || '~' ||substr(SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE),1,1900)
                      );
                              exception
                                when others then
                                  null;
                              end;
                              exit;
                            end if;
                           End loop;
                        end loop;
                        End;
            end;
                  END IF;

            IF  tb_rowid.count > 0 and p_ins_succ then

                     FORALL ent in tb_rowid.first .. tb_rowid.last
                      DELETE FROM  ictbs_entries_history WHERE rowid=tb_rowid(ent) ;
                       COMMIT;
                  END IF;

              EXIT WHEN cr_icent_hist_liqn%NOTFOUND;
         END LOOP;

         IF  cr_icent_hist_liqn%isopen then
               CLOSE cr_icent_hist_liqn;
         END IF;
       pr_log(p_brn,global.application_date,'S','TD_CLOSE Purging completed');
        COMMIT;

    debug.pr_debug('IC','Liquidation Purging ends');
  EXCEPTION
      WHEN OTHERS THEN
        debug.pr_debug('IC','Error in pr_purge_accrual WOT ' || SQLERRM);
      pr_log(p_brn,global.application_date,'F','TD_CLOSE Purging Failed'||SQLERRM);
        ROLLBACK;
  END  pr_purge_td;
  
  PROCEDURE pr_purge_zero_accr(p_brn VARCHAR2) IS
    l_commit_freq          PLS_INTEGER := 10000;
    l_today                DATE;
    l_is_month_end         CHAR;
    l_month_end        	   DATE;
    purge_till_date        DATE;
    p_retn_period          NUMBER;
    purge_date             DATE;
    zero_dt				   DATE;
    l_month_begn           DATE;
    p_ins_succ             BOOLEAN;
    TYPE ty_rowid IS TABLE of rowid INDEX BY BINARY_INTEGER;
    tb_rowid               ty_rowid;

     cursor cr_icent_zero_accr is
           SELECT rowid
            FROM ictbs_entries_history
            WHERE brn = p_brn
            AND acc in (select cust_ac_no from sttm_cust_account where branch_code=p_brn)
        and prod in (select product_code from ictm_product_definition where nvl(DEP,'N') <> 'Y')
        and prod in (select product_code from ictm_pr_int where nvl(back_calc_flag,'N') ='N')
            AND (amt=0 and amt_to_accrue=0 and accrued_amt=0 and cur_run_accr=0)
            AND LIQN = 'N'
            AND ent_dt <= trunc(sysdate-365);


      PROCEDURE pr_log(p_Branch  VARCHAR2,
                                 p_date    DATE,
                                 p_status  VARCHAR2,
                                 p_Errm    VARCHAR2) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
      BEGIN

        INSERT INTO ictb_purge_store
          (BRANCH_CODE, RUN_DATE, STATUS,ERROR)
        VALUES
          (p_Branch, p_date, p_status,p_Errm);

        update ICTB_PURGE_MONITOR
        set end_time = sysdate
        where branch_code = p_branch
            and run_dt=p_date
          and pmode='ZERO_ACCR';

        COMMIT;

      EXCEPTION
        WHEN OTHERS THEN
           debug.pr_debug('IC','pr_log-> ' || SQLERRM);
          COMMIT;
      END pr_log;

     BEGIN
     global.pr_init(p_brn);
     debug.pr_debug('IC','Inside purging of accrual history');
     l_today:=global.application_date;
     debug.pr_debug('IC','Today date is :'||l_today);

    debug.pr_debug('IC','ZERO Accrual Purging ends');
    if nvl(cspkss_os_param.get_param_val('IC_ZERO_PURGING'),'N') <> 'Y'
     then
         pr_log(p_brn,global.application_date,'F','Zero Purging Parameter is maintained as N');
         RETURN;
     end if;

      --zero_dt :=cepks_date.fn_getcbop(l_today,'MONTH');
      insert into ICTB_PURGE_MONITOR
      values
      (p_brn
      ,'ZERO_ACCR'
      ,global.application_date
      ,sysdate
      ,sysdate
      );
         tb_rowid.delete;
         OPEN cr_icent_zero_accr;
         LOOP

             FETCH cr_icent_zero_accr BULK COLLECT
                    INTO tb_rowid
             LIMIT l_commit_freq;
                  p_ins_succ :=FALSE;
                  IF  tb_rowid.count > 0 then
                    BEGIN
                     FORALL ent in tb_rowid.first .. tb_rowid.last
                       insert into ictb_entries_history_archive
                       select * from ictbs_entries_history where rowid = tb_rowid(ent) ;
                       COMMIT;
               p_ins_succ :=TRUE;
                    EXCEPTION
                    WHEN others THEN
                debug.pr_debug('IC','Archive Failed ' || sqlerrm );
              Declare
                        l_error_count number := 0;
                        j             number := 0;
              Begin
                        l_error_count := SQL%BULK_EXCEPTIONS.count;

                        For I IN 1 .. l_error_count LOOP
                          j := 0;

                          FOR k IN tb_rowid.FIRST .. tb_rowid.LAST LOOP
                            j := j + 1;
                            if j = SQL%BULK_EXCEPTIONS(i).error_index then
                              begin
                                pr_log(p_brn
                        ,global.application_date
                      ,'F','ZERO_ACCR purge failed with ' || '~' ||tb_rowid(k) || '~' ||substr(SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE),1,1900)
                      );
                              exception
                                when others then
                                  null;
                              end;
                              exit;
                            end if;
                          End loop;
                        end loop;
                        End;
            end;
                  END IF;

            IF  tb_rowid.count > 0 and p_ins_succ then
                      FORALL ent in tb_rowid.first .. tb_rowid.last
                       delete from ictbs_entries_history where rowid=tb_rowid(ent) ;
                       COMMIT;
                  END IF;

              EXIT WHEN cr_icent_zero_accr%NOTFOUND;
         END LOOP;

         IF  cr_icent_zero_accr%isopen then
               CLOSE cr_icent_zero_accr;
         END IF;

     pr_log(p_brn,global.application_date,'S','ZERO_ACCR Purging completed');
     COMMIT;

    debug.pr_debug('IC','Zero Accrual Purging ends');

  EXCEPTION
      WHEN OTHERS THEN
        debug.pr_debug('IC','Error in pr_purge_accrual WOT ' || SQLERRM);
       pr_log(p_brn,global.application_date,'F','ZERO_ACCR Purging Failed'||SQLERRM);
        ROLLBACK;
  END  pr_purge_zero_accr;
  
  FUNCTION FN_ARCHIVE_CL(P_BRANCH VARCHAR2)
    RETURN BOOLEAN IS
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
   BEGIN
        DBG('Start of function FN_ARCHIVE_CL...');
        DBG('p_branch...' || P_BRANCH);
        DBG('Head office...' || GLOBAL.HEAD_OFFICE);
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
    IF cur%ISOPEN THEN
      CLOSE cur;
    END IF;
    COMMIT;
    DBG('End of function FN_ARCHIVE_CL...');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DBG('Error in FN_ARCHIVE_CL...' || SQLERRM);
      ty_tb_accs.DELETE;
      IF cur%ISOPEN THEN
        CLOSE cur;
      END IF;
      RETURN FALSE;
  END FN_ARCHIVE_CL;

  FUNCTION FN_ARCHIVE_IC(P_BRANCH VARCHAR2) RETURN BOOLEAN IS
    l_job       VARCHAR2(200);
    l_job_no    NUMBER;
    l_tot_jobs  number := 0;
    l_reqd_jobs number := 0;
  BEGIN
    DEBUG.PR_DEBUG('IF', 'Inside GIPKS_ARCHIVE_CUSTOM.FN_ARCHIVE_IC... ');

    for c_cur in (select branch_code From sttm_branch where RECORD_STAT='O' and auth_stat='A')
	  loop
      l_job := 'Begin GIPKS_ARCHIVE_CUSTOM.pr_ic_entries_purge(' || '''' || c_cur.branch_code || ''');  end;';
      dbms_job.submit(l_job_no, l_job, SYSDATE, null);
	  commit;
    end loop;

    DEBUG.PR_DEBUG('IF', 'Job GIPKS_ARCHIVE_CUSTOM.pr_ic_entries_purge submitted for archival of FN_ARCHIVE_IC tables');

    COMMIT;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DEBUG.PR_DEBUG('IF','FAILED in FN_ARCHIVE_IC with error -> ' || SQLERRM);     
  END FN_ARCHIVE_IC;
  
  PROCEDURE pr_ic_entries_purge(P_BRANCH VARCHAR2) IS
  BEGIN
    DEBUG.PR_DEBUG('IF', 'Inside GIPKS_ARCHIVE_CUSTOM.pr_ic_entries_purge... ');
    pr_purge_accrual (P_BRANCH);
    pr_purge_liquidation(P_BRANCH);
    pr_purge_td(P_BRANCH);
    pr_purge_zero_accr(P_BRANCH);
    DEBUG.PR_DEBUG('IF', 'Done GIPKS_ARCHIVE_CUSTOM.pr_ic_entries_purge... ');
  END pr_ic_entries_purge;
  

  FUNCTION FN_ARCHIVE_WEEKLY(P_BRANCH      IN VARCHAR2,
                             P_ERROR_CODE  IN OUT VARCHAR2,
                             P_ERROR_PARAM IN OUT VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    DBG('Entering in FN_ARCHIVE_WEEKLY...');
    DBG('Calling FN_ARCHIVE_IC...');    
    IF NOT FN_ARCHIVE_IC(P_BRANCH) THEN
      DBG('failed in  FN_ARCHIVE_IC...');
      RETURN FALSE;
    END IF;
    DBG('Calling FN_ARCHIVE_CL...'); 
    IF NOT FN_ARCHIVE_CL(P_BRANCH) THEN
      DBG('failed in  FN_ARCHIVE_CL...');
      RETURN FALSE;
    END IF;
    DBG('Returning from FN_ARCHIVE_WEEKLY...');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DBG('Error in FN_ARCHIVE_WEEKLY' || SQLERRM || '~' ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      RETURN FALSE;
  END FN_ARCHIVE_WEEKLY;
 
 PROCEDURE PR_ARCH_AETB_EOC_PROGRAMS_HIST IS
    L_DATE DATE:=NULL;
    l_Purg_req Varchar2(1):='N';
    l_err_msg  Varchar2(4000):=NULL;
    
    Cursor CR_AETB_EOC_PROGRAMS_HIST (p_date date) is
     Select * from AETB_EOC_PROGRAMS_HISTORY
     Where branch_date>p_date; --to keep data into another table & delete rest data from main table
    Type ty_CR_AETB_EOC_PROGRAMS_HIST is table of CR_AETB_EOC_PROGRAMS_HIST%rowtype index by binary_integer;
    l_ty_CR_AETB_EOC_PROGRAMS_HIST ty_CR_AETB_EOC_PROGRAMS_HIST;
    
   CURSOR CR_AETB_EOC_PROGRAMS_HIST_TMP IS
    select * from AETB_EOC_PROGRAMS_HIST_TMP;
    TYPE TY_AETB_EOC_PROG_HIST_TMP IS TABLE OF CR_AETB_EOC_PROGRAMS_HIST_TMP%ROWTYPE INDEX BY BINARY_INTEGER;
    L_TY_AETB_EOC_PROG_HIST_TMP TY_AETB_EOC_PROG_HIST_TMP;
    
    BEGIN
      DBG('Entering PR_ARCH_AETB_EOC_PROGRAMS_HIST...');
      If Not FN_Cal_purgeDate('AETB_EOC_PROGRAMS_HISTORY',L_DATE,l_Purg_req,l_err_msg) Then
        DBG('failed in  FN_Cal_purgeDate...');
        L_DATE:=trunc(sysdate - 90);
        l_Purg_req:='N';
      End If;
      
      DBG('K-L_DATE: '||L_DATE||' #l_Purg_req: '||l_Purg_req);
      If l_Purg_req='Y' Then
         DBG('Purging FBTB_OVD Table...');
         Open CR_AETB_EOC_PROGRAMS_HIST (L_DATE);
         Loop
           Fetch CR_AETB_EOC_PROGRAMS_HIST BULK COLLECT INTO l_ty_CR_AETB_EOC_PROGRAMS_HIST LIMIT 10000;
           IF l_ty_CR_AETB_EOC_PROGRAMS_HIST.count=0 Then
              EXIT;
           Else
             FORALL i in l_ty_CR_AETB_EOC_PROGRAMS_HIST.first .. l_ty_CR_AETB_EOC_PROGRAMS_HIST.last
             Insert into AETB_EOC_PROGRAMS_HIST_TMP values l_ty_CR_AETB_EOC_PROGRAMS_HIST(i);
             Commit;
             l_ty_CR_AETB_EOC_PROGRAMS_HIST.Delete;
           End If;       
         End Loop;
         CLOSE CR_AETB_EOC_PROGRAMS_HIST;
         EXECUTE IMMEDIATE 'TRUNCATE TABLE AETB_EOC_PROGRAMS_HISTORY';
         
         OPEN CR_AETB_EOC_PROGRAMS_HIST_TMP;
          LOOP
              FETCH CR_AETB_EOC_PROGRAMS_HIST_TMP BULK COLLECT INTO L_TY_AETB_EOC_PROG_HIST_TMP LIMIT 10000;
              IF L_TY_AETB_EOC_PROG_HIST_TMP.COUNT = 0
              THEN
                  EXIT;
              ELSE
                  FORALL I IN L_TY_AETB_EOC_PROG_HIST_TMP.FIRST .. L_TY_AETB_EOC_PROG_HIST_TMP.LAST
                  INSERT INTO AETB_EOC_PROGRAMS_HISTORY VALUES L_TY_AETB_EOC_PROG_HIST_TMP(I);

                  COMMIT;
                  L_TY_AETB_EOC_PROG_HIST_TMP.DELETE;
              END IF;
          END LOOP;
          CLOSE CR_AETB_EOC_PROGRAMS_HIST_TMP;

          EXECUTE IMMEDIATE 'TRUNCATE TABLE AETB_EOC_PROGRAMS_HIST_TMP';
      End If;            
      DBG('Exiting PR_ARCH_AETB_EOC_PROGRAMS_HIST...');    
    EXCEPTION
      WHEN OTHERS THEN
        DBG('Error in PR_ARCH_AETB_EOC_PROGRAMS_HIST' || SQLERRM || '~' ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);  
 END PR_ARCH_AETB_EOC_PROGRAMS_HIST;
 
  
 PROCEDURE PR_ARCH_FBTB_TXNLOG_DETLS_HIST IS
    L_DATE DATE:=NULL;
    l_Purg_req Varchar2(1):='N';
    l_err_msg  Varchar2(4000):=NULL;
    
    Cursor CR_FBTB_TXNLOG_DETAILS_HIST (p_date date) is
     Select * from FBTB_TXNLOG_DETAILS_HIST
     Where timestamp>p_date; --to keep data into another table & delete rest data from main table
    Type ty_CR_FBTB_TXNLOG_DTLS_HIST is table of CR_FBTB_TXNLOG_DETAILS_HIST%rowtype index by binary_integer;
    l_ty_CR_FBTB_TXNLOG_DTLS_HIST ty_CR_FBTB_TXNLOG_DTLS_HIST;
    
   CURSOR CR_TXNLOG_DETAILS_TMP IS
    select * from FBTB_TXNLOG_DETAILS_HIST_TMP;
    TYPE TY_TXNLOG_DETAILS_TMP IS TABLE OF CR_TXNLOG_DETAILS_TMP%ROWTYPE INDEX BY BINARY_INTEGER;
    L_TXNLOG_DETAILS_TMP TY_TXNLOG_DETAILS_TMP;
    
    BEGIN
      DBG('Entering PR_ARCH_FBTB_TXNLOG_DETLS_HIST...');
      If Not FN_Cal_purgeDate('FBTB_TXNLOG_DETAILS_HIST',L_DATE,l_Purg_req,l_err_msg) Then
        DBG('failed in  FN_Cal_purgeDate...');
        L_DATE:=trunc(sysdate - 90);
        l_Purg_req:='N';
      End If;
      
      DBG('K-L_DATE: '||L_DATE||' #l_Purg_req: '||l_Purg_req);
      If l_Purg_req='Y' Then
         DBG('Purging FBTB_OVD Table...');
         Open CR_FBTB_TXNLOG_DETAILS_HIST (L_DATE);
         Loop
           Fetch CR_FBTB_TXNLOG_DETAILS_HIST BULK COLLECT INTO l_ty_CR_FBTB_TXNLOG_DTLS_HIST LIMIT 10000;
           IF l_ty_CR_FBTB_TXNLOG_DTLS_HIST.count=0 Then
              EXIT;
           Else
             FORALL i in l_ty_CR_FBTB_TXNLOG_DTLS_HIST.first .. l_ty_CR_FBTB_TXNLOG_DTLS_HIST.last
             Insert into FBTB_TXNLOG_DETAILS_HIST_TMP values l_ty_CR_FBTB_TXNLOG_DTLS_HIST(i);
             Commit;
             l_ty_CR_FBTB_TXNLOG_DTLS_HIST.Delete;
           End If;       
         End Loop;
         CLOSE CR_FBTB_TXNLOG_DETAILS_HIST;
         EXECUTE IMMEDIATE 'TRUNCATE TABLE FBTB_TXNLOG_DETAILS_HIST';
         
         OPEN CR_TXNLOG_DETAILS_TMP;
          LOOP
              FETCH CR_TXNLOG_DETAILS_TMP BULK COLLECT INTO L_TXNLOG_DETAILS_TMP LIMIT 10000;
              IF L_TXNLOG_DETAILS_TMP.COUNT = 0
              THEN
                  EXIT;
              ELSE
                  FORALL I IN L_TXNLOG_DETAILS_TMP.FIRST .. L_TXNLOG_DETAILS_TMP.LAST
                  INSERT INTO FBTB_TXNLOG_DETAILS_HIST VALUES L_TXNLOG_DETAILS_TMP(I);

                  COMMIT;
                  L_TXNLOG_DETAILS_TMP.DELETE;
              END IF;
          END LOOP;
          CLOSE CR_TXNLOG_DETAILS_TMP;

          EXECUTE IMMEDIATE 'TRUNCATE TABLE FBTB_TXNLOG_DETAILS_HIST_TMP';
      End If;            
      DBG('Exiting PR_ARCH_FBTB_TXNLOG_DETLS_HIST...');    
    EXCEPTION
      WHEN OTHERS THEN
        DBG('Error in PR_ARCH_FBTB_TXNLOG_DETLS_HIST' || SQLERRM || '~' ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);  
 END PR_ARCH_FBTB_TXNLOG_DETLS_HIST;
  
 PROCEDURE PR_ARCH_FBTB_OVD IS
    L_DATE DATE:=NULL;
    l_Purg_req Varchar2(1):='N';
    l_err_msg  Varchar2(4000):=NULL;
    Cursor cr_FBTB_OVD (p_date date) is
     Select * from FBTB_OVD
     Where brn_ovddate>p_date; --to keep data into another table & delete rest data from main table
    Type ty_cr_FBTB_OVD is table of cr_FBTB_OVD%rowtype index by binary_integer;
    l_ty_cr_FBTB_OVD ty_cr_FBTB_OVD;
    
    Cursor cr_FBTB_OVD_ARCH (p_date date) is
     Select * from FBTB_OVD_ARCH;
    Type ty_cr_FBTB_OVD_ARCH is table of cr_FBTB_OVD_ARCH%rowtype index by binary_integer;
    l_ty_cr_FBTB_OVD_ARCH ty_cr_FBTB_OVD_ARCH;
    
  BEGIN
    DBG('Entering PR_ARCH_FBTB_OVD...');
    If Not FN_Cal_purgeDate('FBTB_OVD',L_DATE,l_Purg_req,l_err_msg) Then
      DBG('failed in  FN_Cal_purgeDate...');
      L_DATE:=trunc(sysdate - 90);
      l_Purg_req:='N';
    End If;
    
    DBG('K-L_DATE: '||L_DATE||' #l_Purg_req: '||l_Purg_req);
    If l_Purg_req='Y' Then
       DBG('Purging FBTB_OVD Table...');
       Open cr_FBTB_OVD (L_DATE);
       Loop
         Fetch cr_FBTB_OVD BULK COLLECT INTO l_ty_cr_FBTB_OVD LIMIT 10000;
         IF l_ty_cr_FBTB_OVD.count=0 Then
            EXIT;
         Else
           FORALL i in l_ty_cr_FBTB_OVD.first .. l_ty_cr_FBTB_OVD.last
           Insert into FBTB_OVD_ARCH values l_ty_cr_FBTB_OVD(i);
           Commit;
           l_ty_cr_FBTB_OVD.Delete;
         End If;       
       End Loop;
       CLOSE cr_FBTB_OVD;
       EXECUTE IMMEDIATE 'TRUNCATE TABLE FBTB_OVD';
       
       Open cr_FBTB_OVD_ARCH (L_DATE);
       Loop
         Fetch cr_FBTB_OVD_ARCH BULK COLLECT INTO l_ty_cr_FBTB_OVD_ARCH LIMIT 10000;
         IF l_ty_cr_FBTB_OVD_ARCH.count=0 Then
            EXIT;
         Else
           FORALL i in l_ty_cr_FBTB_OVD_ARCH.first .. l_ty_cr_FBTB_OVD_ARCH.last
           Insert into FBTB_OVD values l_ty_cr_FBTB_OVD_ARCH(i);
           Commit;
           l_ty_cr_FBTB_OVD_ARCH.Delete;
         End If;       
       End Loop;
       CLOSE cr_FBTB_OVD_ARCH;
       EXECUTE IMMEDIATE 'TRUNCATE TABLE FBTB_OVD_ARCH';
    End If;            
    DBG('Exiting PR_ARCH_FBTB_OVD...');    
  EXCEPTION
    WHEN OTHERS THEN
      DBG('Error in PR_ARCH_FBTB_OVD' || SQLERRM || '~' ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);  
 END PR_ARCH_FBTB_OVD;
 
 FUNCTION FN_ARCH_SMTB_SMS_LOG(P_BRANCH VARCHAR2, P_DATE DATE) RETURN BOOLEAN IS
    L_CNT NUMBER;
    CURSOR CR_SMTB_SMS_LOG IS
      SELECT ROWID ROW_ID, A.*
        FROM SMTB_SMS_LOG A
       WHERE BRANCH_CODE = P_BRANCH
         AND TRUNC(END_TIME) <= P_DATE;
    CURSOR CR_SMTT_SMS_LOG IS
      SELECT ROWID ROW_ID, A.* FROM SMTT_SMS_LOG A;
    TYPE TBL_SMTB_SMS_LOG IS TABLE OF CR_SMTB_SMS_LOG%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE TBL_SMTT_SMS_LOG IS TABLE OF CR_SMTT_SMS_LOG%ROWTYPE INDEX BY BINARY_INTEGER;
    L_SMTB_SMS_LOG TBL_SMTB_SMS_LOG;
    L_SMTT_SMS_LOG TBL_SMTT_SMS_LOG;
  BEGIN
    DEBUG.PR_DEBUG('IF', 'Inside FN_ARCH_SMTB_SMS_LOG... ');
  
    IF NVL(G_ARCHIVE_COMMIT_FREQ, 0) = 0 THEN
      G_ARCHIVE_COMMIT_FREQ := NVL(TO_NUMBER(CSPKSS_OS_PARAM.GET_PARAM_VAL('ARCH_COMMIT_FREQ')),500);
    END IF;
    DBG('g_archive_commit_freq~' || G_ARCHIVE_COMMIT_FREQ);
    IF CR_SMTB_SMS_LOG%ISOPEN THEN
      CLOSE CR_SMTB_SMS_LOG;
    END IF;
    OPEN CR_SMTB_SMS_LOG;
    LOOP
      FETCH CR_SMTB_SMS_LOG BULK COLLECT
        INTO L_SMTB_SMS_LOG LIMIT G_ARCHIVE_COMMIT_FREQ;
      DBG('Sub Count...' || L_SMTB_SMS_LOG.COUNT);
      IF CR_SMTB_SMS_LOG%ROWCOUNT > 0 THEN
        BEGIN
          SAVEPOINT SAVE_POINT_SMS_LOG;
          FOR J IN 1 .. L_SMTB_SMS_LOG.COUNT LOOP
            INSERT INTO SMTB_SMS_LOG_HIST
              (SEQUENCE_NO,
               START_TIME,
               LOG_TYPE,
               DESCRIPTION,
               END_TIME,
               EXIT_FLAG,
               TERMINAL_ID,
               USER_ID,
               FUNCTION_ID,
               BRANCH_CODE,
               SYSTEM_START_TIME,
               SYSTEM_END_TIME,
               MODULE_CODE)
            VALUES
              (L_SMTB_SMS_LOG(J).SEQUENCE_NO,
               L_SMTB_SMS_LOG(J).START_TIME,
               L_SMTB_SMS_LOG(J).LOG_TYPE,
               L_SMTB_SMS_LOG(J).DESCRIPTION,
               L_SMTB_SMS_LOG(J).END_TIME,
               L_SMTB_SMS_LOG(J).EXIT_FLAG,
               L_SMTB_SMS_LOG(J).TERMINAL_ID,
               L_SMTB_SMS_LOG(J).USER_ID,
               L_SMTB_SMS_LOG(J).FUNCTION_ID,
               L_SMTB_SMS_LOG(J).BRANCH_CODE,
               L_SMTB_SMS_LOG(J).SYSTEM_START_TIME,
               L_SMTB_SMS_LOG(J).SYSTEM_END_TIME,
               L_SMTB_SMS_LOG(J).MODULE_CODE);
            DBG('Insert Sub Count...' || SQL%ROWCOUNT);
            DELETE FROM SMTB_SMS_LOG
             WHERE ROWID = L_SMTB_SMS_LOG(J).ROW_ID;
            DBG('Delete Sub Count...' || SQL%ROWCOUNT);
          END LOOP;
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SAVE_POINT_SMS_LOG;
        END;
      END IF;
      EXIT WHEN CR_SMTB_SMS_LOG%NOTFOUND;
      L_SMTB_SMS_LOG.DELETE;
    END LOOP;
    IF CR_SMTB_SMS_LOG%ISOPEN THEN
      CLOSE CR_SMTB_SMS_LOG;
    END IF;
  
    DEBUG.PR_DEBUG('IF', 'Done the archival of FN_ARCH_SMTB_SMS_LOG tables');
  
    COMMIT;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DEBUG.PR_DEBUG('IF','FAILED in FN_ARCH_SMTB_SMS_LOG with error -> ' || SQLERRM);
      ROLLBACK TO SAVE_POINT_SMS_LOG;
      L_SMTB_SMS_LOG.DELETE;
      IF CR_SMTB_SMS_LOG%ISOPEN THEN
        CLOSE CR_SMTB_SMS_LOG;
      END IF;
      RETURN FALSE;
  END FN_ARCH_SMTB_SMS_LOG;
  
  PROCEDURE PR_ARCH_CSTB_MSG_LOG IS
    CURSOR C1(P_MSG_ID VARCHAR2) IS
      SELECT ROWID R_ID, A.* FROM CSTB_MSG_LOG A WHERE MSG_ID < P_MSG_ID;
    TYPE TY_C1 IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
    L_TB_DEL      TY_C1;
    L_MSG_ID      VARCHAR2(20);
    L_REQ_SEQ_VAL VARCHAR2(10) := 0;
  BEGIN
    DBG('Start of PROC PR_ARCH_CSTB_MSG_LOG...');
    IF C1%ISOPEN THEN
      CLOSE C1;
    END IF;
    L_REQ_SEQ_VAL := 0;
    L_MSG_ID      := '6' || TO_CHAR(SYSDATE, 'YYDDD') ||LPAD(L_REQ_SEQ_VAL, 10, '0');
    DBG('ARCHIVING TILL .' || L_MSG_ID);
    OPEN C1(L_MSG_ID);
    LOOP
      L_TB_DEL.DELETE;
      FETCH C1 BULK COLLECT
        INTO L_TB_DEL LIMIT G_ARCHIVE_COMMIT_FREQ;
      DBG('Sub Count...' || L_TB_DEL.COUNT);
      IF L_TB_DEL.COUNT > 0 THEN
        FORALL I IN L_TB_DEL.FIRST .. L_TB_DEL.LAST
          INSERT /*+ APPEND_VALUES */
          INTO CSTB_MSG_LOG_HIST
            (MSG_ID,
             SOURCE_CODE,
             MSG_TYPE,
             REQUEST,
             RESPONSE,
             FC_RESPONSE,
             STATUS)
          VALUES
            (L_TB_DEL(I).MSG_ID,
             L_TB_DEL(I).SOURCE_CODE,
             L_TB_DEL(I).MSG_TYPE,
             L_TB_DEL(I).REQUEST,
             L_TB_DEL(I).RESPONSE,
             L_TB_DEL(I).FC_RESPONSE,
             L_TB_DEL(I).STATUS);
        DBG('Insert Sub Count...' || SQL%ROWCOUNT);
        FORALL I IN L_TB_DEL.FIRST .. L_TB_DEL.LAST
          DELETE CSTB_MSG_LOG WHERE ROWID = L_TB_DEL(I).R_ID;
        DBG('Delete Sub Count...' || SQL%ROWCOUNT);
        COMMIT;
      END IF;
      EXIT WHEN C1%NOTFOUND;
    END LOOP;
    IF C1%ISOPEN THEN
      CLOSE C1;
    END IF;
    COMMIT;
    DBG('End of PROC PR_ARCH_CSTB_MSG_LOG...');
    L_TB_DEL.DELETE;

  EXCEPTION
    WHEN OTHERS THEN
      DBG('Error in PR_ARCH_CSTB_MSG_LOG, ERROR: ' || SQLERRM);
      L_TB_DEL.DELETE;
      IF C1%ISOPEN THEN
        CLOSE C1;
      END IF;
  END PR_ARCH_CSTB_MSG_LOG;    
  
  PROCEDURE PR_ARCHIVE_SM(P_BRANCH IN VARCHAR2) IS
    L_DATE DATE:=NULL;
    l_Purg_req Varchar2(1):='N';
    l_err_msg  Varchar2(4000):=NULL;
  BEGIN
    DBG('Entering PR_ARCHIVE_SM...');
    If Not FN_Cal_purgeDate('SMTB_SMS_LOG',L_DATE,l_Purg_req,l_err_msg) Then
      DBG('failed in  FN_Cal_purgeDate...');
      L_DATE:=trunc(sysdate - 90);
      l_Purg_req:='N';
    End If;
    DBG('K-L_DATE: '||L_DATE||' #l_Purg_req: '||l_Purg_req);
    If l_Purg_req='Y' Then
      DBG('Calling FN_ARCH_SMTB_SMS_LOG with L_DATE: '||L_DATE);
      IF NOT FN_ARCH_SMTB_SMS_LOG(P_BRANCH, L_DATE) THEN
        DBG('failed in  FN_ARCH_SMTB_SMS_LOG...');
      Else
        PR_ARCH_CSTB_MSG_LOG;
      END IF;      
    End If;
    DBG('Exiting PR_ARCHIVE_SM...');
  EXCEPTION
    WHEN OTHERS THEN
      DBG('Error in fn_archive_sm' || SQLERRM || '~' ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
  END PR_ARCHIVE_SM;
  
  PROCEDURE PR_PURGE_BMI_TABLES IS
    l_sql    VARCHAR2(1000);
    l_job_id NUMBER;
  BEGIN
    DBG('Entering PR_PURGE_BMI_TABLES...');
     ----------------------------------SMTB_SMS_LOG---------------------------------------------------------------------------
     FOR rec IN (Select distinct Branch_code from sttm_branch where record_stat='O' and auth_stat='A') LOOP
      l_sql:=NULL;
      l_sql := 'BEGIN GIPKS_ARCHIVE_CUSTOM.PR_ARCHIVE_SM(''' ||rec.BRANCH_CODE || '''); END;';
      dbms_job.submit(l_job_id, l_sql);
      COMMIT;
     END LOOP;
   -------------------------------------------------------------------------------------------------------------
   ---------------------------------------FBTB_OVD----------------------------------------------------------------------
    l_sql:=NULL;
    l_sql := 'BEGIN GIPKS_ARCHIVE_CUSTOM.PR_ARCH_FBTB_OVD; END;';
    dbms_job.submit(l_job_id, l_sql);    
   ---------------------------------------------------------------------------------------------------------------------   
   ---------------------------------------FBTB_TXNLOG_DETAILS_HIST----------------------------------------------------------------------   
    l_sql:=NULL;
    l_sql := 'BEGIN GIPKS_ARCHIVE_CUSTOM.PR_ARCH_FBTB_TXNLOG_DETLS_HIST; END;';
    dbms_job.submit(l_job_id, l_sql);    
   
   ---------------------------------------------------------------------------------------------------------------------
   ---------------------------------------AETB_EOC_PROGRAMS_HISTORY----------------------------------------------------------------------   
    l_sql:=NULL;
    l_sql := 'BEGIN GIPKS_ARCHIVE_CUSTOM.PR_ARCH_AETB_EOC_PROGRAMS_HIST; END;';
    dbms_job.submit(l_job_id, l_sql);    
   
   ---------------------------------------------------------------------------------------------------------------------
   
   
    DBG('Exiting PR_PURGE_BMI_TABLES...');
  EXCEPTION
    WHEN OTHERS THEN
      DBG('Error in PR_PURGE_BMI_TABLES' || SQLERRM || '~' ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
  END PR_PURGE_BMI_TABLES;

BEGIN
  
  DBG('code area...');

END GIPKS_ARCHIVE_CUSTOM;
/
