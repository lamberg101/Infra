Create tuning task
===================================================================

DECLARE
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
            sql_id      => 'fxdbrc4jhqn5r',
            scope       => DBMS_SQLTUNE.scope_comprehensive,
            time_limit  => 60,
            task_name   => 'fxdbrc4jhqn5r_tuning_task',
            description => 'Tuning task for statement fxdbrc4jhqn5r.');
  DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

Execute tuning task
=============================
EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => 'fxdbrc4jhqn5r_tuning_task');

Status of tuning task
=====================================================
Once you execute the tuning task, you should be able to find the status of the task

SELECT task_name, status 
FROM dba_advisor_log 
WHERE task_name like 'fxdbrc4jhqn5r_tuning_task';

======================================================================
Display recommendations
==================================================================
Once the tuning task is executed successfully, the recommendations can be displayed using below

SET LONG 10000;
SET PAGESIZE 1000
SET LINESIZE 200
SELECT DBMS_SQLTUNE.report_tuning_task('fxdbrc4jhqn5r_tuning_task') AS recommendations FROM dual;
SET PAGESIZE 24
=====================================================================
Drop tuning task

Once you get the recommendations, you can drop the tuning task

BEGIN
  DBMS_SQLTUNE.drop_tuning_task (task_name => 'fxdbrc4jhqn5r_tuning_task');
END;
/
====================================