set verify off

col spoolname new_value spoolname
select 'ms_archive_'||to_char(sysdate,'ddmmyyyy')||'.SPL' spoolname from dual;

spool '&spoolname'

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') begin from dual;

set serveroutput on;

set timing on

DECLARE
	l_branch_date DATE;
	l_purge_archive VARCHAR2(1):= 'A';
	p_err_code VARCHAR2(300):= '';
	p_err_params varchar2(10):= '';

	PROCEDURE dbg(p_msg VARCHAR2) IS
		l_msg VARCHAR2(32767);
	BEGIN
		IF fcc114.debug.pkg_debug_on <> 2 THEN      
			fcc114.debug.pr_debug('CS', '[CSARCHIVE]>'||l_msg);
		END IF;
	END dbg;

	FUNCTION fn_ms_arc_log_purge(p_branch VARCHAR2
							, p_date DATE
							, p_purge_archive VARCHAR2
							,p_error_code  IN OUT VARCHAR2
							,p_error_param IN OUT VARCHAR2)    
	RETURN boolean IS
	
    CURSOR c1(p_branch VARCHAR2, p_date DATE) IS
      SELECT ROWID r_id, a.*
        FROM fcc114.mstbs_archive_out a
       WHERE branch 	= p_branch
         AND branch_date < p_date;
		 
    TYPE ty_c1 IS TABLE OF c1%ROWTYPE INDEX BY PLS_INTEGER;
    l_tb_del ty_c1;
	
	BEGIN
  
    dbg('Start of function fn_archive_utilstxnlog...');
    IF c1%ISOPEN THEN
      CLOSE c1;
    END IF;
    OPEN c1(p_branch, p_date);
    LOOP
      l_tb_del.DELETE;
      FETCH c1 BULK COLLECT
        INTO l_tb_del LIMIT 10000;
      Dbg('Count...' || l_tb_del.COUNT);
      IF l_tb_del.COUNT > 0 THEN
        IF p_purge_archive='A' THEN
            FORALL i IN l_tb_del.FIRST .. l_tb_del.LAST
              INSERT INTO fcc114.msars_archive_out
              (DCN              
			,FROM_DATE        
			,TO_DATE          
			,LANGUAGE         
			,REFERENCE_NO     
			,ESN              
			,MSG_TYPE         
			,RECEIVER         
			,SERIAL_NO        
			,SUPPRESS_FLAG    
			,HOLD_STATUS      
			,DIRECTIVE_STATUS 
			,PROCESSED_FLAG   
			,PRIORITY         
			,MODULE           
			,NAME             
			,ADDRESS1         
			,ADDRESS2         
			,ADDRESS3         
			,ADDRESS4         
			,MEDIA            
			,PRODUCT          
			,BRANCH           
			,FORMAT           
			,CCY              
			,AMOUNT           
			,TESTING_STATUS   
			,MSG_STATUS       
			,PARENT_DCN       
			,BRANCH_DATE      
			,ORIGINAL_DCN     
			,MESSAGE          
			,ARCH_DATE        
			,ARCH_REGEN_DATE  
			,ARCH_MSG_STATUS  
			,REPAIR_REASON    
			,PDE_FLAG         
			,RUNNING_NO       
			)
           VALUES
              (l_tb_del(i).DCN
				,l_tb_del(i).FROM_DATE
				,l_tb_del(i).TO_DATE
				,l_tb_del(i).LANGUAGE
				,l_tb_del(i).REFERENCE_NO
				,l_tb_del(i).ESN
				,l_tb_del(i).MSG_TYPE
				,l_tb_del(i).RECEIVER
				,l_tb_del(i).SERIAL_NO
				,l_tb_del(i).SUPPRESS_FLAG
				,l_tb_del(i).HOLD_STATUS
				,l_tb_del(i).DIRECTIVE_STATUS
				,l_tb_del(i).PROCESSED_FLAG
				,l_tb_del(i).PRIORITY
				,l_tb_del(i).MODULE
				,l_tb_del(i).NAME
				,l_tb_del(i).ADDRESS1
				,l_tb_del(i).ADDRESS2
				,l_tb_del(i).ADDRESS3
				,l_tb_del(i).ADDRESS4
				,l_tb_del(i).MEDIA
				,l_tb_del(i).PRODUCT
				,l_tb_del(i).BRANCH
				,l_tb_del(i).FORMAT
				,l_tb_del(i).CCY
				,l_tb_del(i).AMOUNT
				,l_tb_del(i).TESTING_STATUS
				,l_tb_del(i).MSG_STATUS
				,l_tb_del(i).PARENT_DCN
				,l_tb_del(i).BRANCH_DATE
				,l_tb_del(i).ORIGINAL_DCN
				,l_tb_del(i).MESSAGE
				,l_tb_del(i).ARCH_DATE
				,l_tb_del(i).ARCH_REGEN_DATE
				,l_tb_del(i).ARCH_MSG_STATUS
				,l_tb_del(i).REPAIR_REASON
				,l_tb_del(i).PDE_FLAG
				,l_tb_del(i).RUNNING_NO
				);
    END IF;
        Dbg('Insert Sub Count...' || SQL%ROWCOUNT);
        FORALL i IN l_tb_del.FIRST .. l_tb_del.LAST
          DELETE fcc114.mstbs_archive_out WHERE ROWID = l_tb_del(i).r_id;
        Dbg('Delete Sub Count...' || SQL%ROWCOUNT);
        COMMIT;
     END IF;
      EXIT WHEN c1%NOTFOUND;
    END LOOP;
    IF c1%ISOPEN THEN
      CLOSE c1;
    END IF;
    COMMIT;
    dbg('End of function fn_archive_utilstxnlog...');
    l_tb_del.DELETE;
    RETURN TRUE;
EXCEPTION
    WHEN OTHERS 
	THEN
      dbg('Error in fn_archive_utilstxnlog...' || SQLERRM);
	  p_error_code 	:= sqlcode;
	  p_error_param := 'Failed in fn_ms_arc_log_purge';
      l_tb_del.DELETE;
      IF c1%ISOPEN THEN
        CLOSE c1;
      END IF;
      RETURN FALSE;
END fn_ms_arc_log_purge;


BEGIN
	select trunc(sysdate-365) into l_branch_date from dual;
	For x in  (select branch_code from fcc114.sttm_branch  where auth_stat = 'A'  and record_stat='O') 
	loop

		Insert into fcc114.tab_before_purge
		values('mstb_archive_out',x.branch_code ,(SELECT count(1) FROM fcc114.mstb_archive_out WHERE branch = x.branch_code AND trunc(branch_date) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);

		Insert into fcc114.tab_before_purge
		values('msar_archive_out',x.branch_code ,(SELECT count(1) FROM fcc114.msar_archive_out WHERE branch = x.branch_code AND trunc(branch_date) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);


		BEGIN

			IF NOT  fn_ms_arc_log_purge(x.branch_code,
                  l_branch_date,
                  l_purge_archive,
                  p_err_code,
                  p_err_params)
			then
				fcc114.debug.pr_debug('AC','Came back with failure from elpks_archive.fn_archive_gwoutlog'||p_err_code);
			END IF;
  
    	END;  

		Insert into fcc114.tab_after_purge
		values('mstb_archive_out', x.branch_code ,(SELECT Count(1) FROM fcc114.mstb_archive_out WHERE branch = x.branch_code AND trunc(branch_date) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);

		Insert into fcc114.tab_after_purge
		values('msar_archive_out', x.branch_code ,(SELECT Count(1) FROM fcc114.msar_archive_out WHERE branch = x.branch_code AND trunc(branch_date) < to_date(l_branch_date,'DD-MM-YYYY')),sysdate);

		
		fcc114.debug.pr_debug('CS','After package call elpks_archive.fn_archive_el');

		commit;
	End Loop;
END;
/

set timing off

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') end from dual;

spool off;
exit;
