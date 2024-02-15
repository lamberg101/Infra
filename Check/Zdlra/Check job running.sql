
SELECT task_type, priority, state, count(*) current_count,
         DECODE(state, 'RUNNING',
               TO_CHAR(MIN(last_execute_time), 'DD-MON-YYYY HH24:MI:SS'),
           NULL) last_execute_time,
         (CASE WHEN priority >= 300
               THEN 'Maintenance'
               WHEN task_type IN ('PURGE_SBT', 'BACKUP_SBT',
                                  'RESTORE_SBT', 'OBSOLETE_SBT')
               THEN 'SBT'
               ELSE 'Work'
          END) work_type,
       TO_CHAR(MIN(creation_time), 'DD-MON-YYYY') min_creation
FROM ra_task
WHERE archived = 'N'
GROUP BY state, task_type, priority
ORDER BY state, priority desc;








