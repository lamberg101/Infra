set timing on
Declare
  l_job       VARCHAR2(200);
  l_job_no    NUMBER;
  l_tot_jobs  number := 0;
  l_reqd_jobs number := 0;
begin
    for c_cur in (select branch_code From sttm_branch)
	loop
      l_job := 'Begin fcc114.pr_ic_entries_purge(' || '''' || c_cur.branch_code || ''');  end;';
      dbms_job.submit(l_job_no, l_job, SYSDATE, null);
	  commit;
    end loop;
end;
/
exit;
