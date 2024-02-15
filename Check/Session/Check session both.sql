col machine for a60
  col username for a30
  col osuser for a30
  set lines 300 pages 1000
  SELECT inst_id,machine,username,osuser,
      NVL(active_count, 0) AS active,
      NVL(inactive_count, 0) AS inactive,
      NVL(killed_count, 0) AS killed 
  FROM   ( SELECT inst_id,machine, status,username,osuser, count(*) AS quantity
      FROM   gv$session
      GROUP BY inst_id, status, machine, status,username,osuser)
  PIVOT  (SUM(quantity) AS count FOR (status) IN ('ACTIVE' AS active, 'INACTIVE' AS inactive, 'KILLED' AS killed))
  where username not in ('SYS')
  ORDER BY inactive asc;