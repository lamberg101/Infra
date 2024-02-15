--script Check Locking--

SELECT /*+ RULE */ DECODE(l.request,0,'Holder:',' Waiter:') blocker, lpad(' ',DECODE(l.request,0,0,1))||l.sid sid,
       s.serial#, l.inst_id, to_char(trunc(sysdate) + (l.ctime/24/60/60), 'HH24:MI:SS') seconds_in_wait,
       s.status, s.logon_time,
       --decode(l.request, 0, s.sql_id, null, s.prev_sql_id, s.prev_sql_id) sql_id, s.sql_hash_value,
       DECODE(l.request,0,'',' ')||decode(s.sql_id, null, s.prev_sql_id, s.sql_id) sql_id,
       decode(l.lmode,
              0,'(0)None',
              1,'(1)Null',
              2,'(2)Row Share',
              3,'(3)Row Exclu',
              4,'(4)Share',
              5,'(5)Share Row Ex',
              6,'(6)Exclusive') lmode,
       decode(l.request,
              0,'(0)None',
              1,'(1)Null',
              2,'(2)Row Share',
              3,'(3)Row Exclu',
              4,'(4)Share',
              5,'(5)Share Row Ex',
              6,'(6)Exclusive') request,
       l.type, l.block
  FROM gv$session s, gv$lock l
 WHERE EXISTS (SELECT 1 FROM gv$lock o WHERE o.lmode = 0 and o.id1 = l.id1 and o.id2 = l.id2)
   and l.inst_id = s.inst_id
   and l.sid = s.sid
--   and l.lmode=6
--   and l.request=0
--   and l.block>1
--   and l.ctime > 600
ORDER BY l.id1,l.request;
