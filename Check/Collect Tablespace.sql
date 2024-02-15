set lines 175 pages 1000 ver off feed off
col tablespace_name form a26
col file_name for a50
col "TS_size(MB)" form 99g999g999
col used form 999g999g999
col free form 999g999g999
col max form 999g999g999
col alrt for a4
break on report
compute sum of bytes on report
compute sum of "TS_size(MB)" on report
compute sum of used on report
compute sum of free on report
compute sum of max on report

SELECT status, NAME TABLESPACE_NAME, TYPE, extent_mgt, "TS_size(MB)", used, "TS_size(MB)" - used free, pct_used,real_pct_used, alrt
FROM (SELECT d.status status, d.tablespace_name NAME, d.CONTENTS TYPE,
 d.extent_management extent_mgt,
  d.segment_space_management segment_mgt,
   NVL (a.BYTES / 1024 / 1024, 0) "TS_size(MB)",
    NVL (a.BYTES / 1024 / 1024 - NVL (f.BYTES / 1024 / 1024, 0), 0) used,
    NVL (FLOOR (((a.BYTES - NVL (f.BYTES, 0)) / a.BYTES * 100)), 0) pct_used,
NVL (FLOOR (((a.BYTES - NVL (f.BYTES, 0)) / a.MAXBYTES * 100)), 0) real_pct_used,
    (case when NVL (FLOOR (((a.BYTES - NVL (f.BYTES, 0)) / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 95 then '****'
    when NVL (FLOOR (((a.BYTES - NVL (f.BYTES, 0)) / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 90 then '***'
    when NVL (FLOOR (((a.BYTES - NVL (f.BYTES, 0)) / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 85 then '**'
    when NVL (FLOOR (((a.BYTES - NVL (f.BYTES, 0)) / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 80 then '*' else ' ' end) alrt
      FROM SYS.dba_tablespaces d,
       (SELECT tablespace_name, SUM (BYTES) BYTES , sum(decode(maxbytes,0,bytes,maxbytes)) maxbytes
FROM dba_data_files
 GROUP BY tablespace_name) a,
  (SELECT tablespace_name, SUM (BYTES) BYTES
   FROM dba_free_space
    GROUP BY tablespace_name) f
     WHERE d.tablespace_name = a.tablespace_name(+)
      AND d.tablespace_name = f.tablespace_name(+)
      AND NOT (d.extent_management LIKE 'LOCAL'
       AND (d.CONTENTS LIKE 'TEMPORARY' or d.CONTENTS = 'UNDO')
)
 UNION ALL
  SELECT d.status status, d.tablespace_name NAME, d.CONTENTS TYPE,
   d.extent_management extent_mgt,
    d.segment_space_management segment_mgt,
     NVL (a.BYTES / 1024 / 1024, 0) "TS_size(MB)",
      NVL (t.BYTES / 1024 / 1024, 0) used,
       NVL (FLOOR ((t.BYTES / a.BYTES * 100)), 0) pct_used,
NVL (FLOOR ((t.BYTES / a.MAXBYTES * 100)), 0) real_pct_used,
       (case when NVL (FLOOR ((t.BYTES / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 95 then '****'
       when NVL (FLOOR ((t.BYTES / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 90 then '***'
       when NVL (FLOOR ((t.BYTES / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 85 then '**'
       when NVL (FLOOR ((t.BYTES / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 80 then '*' else ' ' end) alrt
FROM SYS.dba_tablespaces d,
 (SELECT tablespace_name, SUM (BYTES) BYTES , sum(decode(maxbytes,0,bytes,maxbytes)) maxbytes
  FROM dba_temp_files
   GROUP BY tablespace_name) a,
    (SELECT tablespace tablespace_name, SUM (blocks*8192) BYTES
     FROM v$sort_usage
      GROUP BY tablespace) t
       WHERE d.tablespace_name = a.tablespace_name(+)
AND d.tablespace_name = t.tablespace_name(+)
 AND d.extent_management LIKE 'LOCAL'
  AND d.CONTENTS LIKE 'TEMPORARY'
   UNION ALL
    (select d.status status,d.tablespace_name NAME,d.contents TYPE,
    d.extent_management extent_mgt,
     d.segment_space_management segment_mgt,
      NVL (a.BYTES / 1024 / 1024, 0) "TS_size(MB)",
       NVL (t.BYTES / 1024 / 1024, 0) used,
NVL (FLOOR ((t.BYTES / a.BYTES * 100)), 0) pct_used,
NVL (FLOOR ((t.BYTES / a.MAXBYTES * 100)), 0) real_pct_used,
(case when NVL (FLOOR ((t.BYTES / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >= 95 then '****'
 when NVL (FLOOR ((t.BYTES / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >=90 then '***'
 when NVL (FLOOR ((t.BYTES / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >=85 then '**'
 when NVL (FLOOR ((t.BYTES / decode(a.MAXBYTES,0,a.BYTES,a.MAXBYTES) * 100)), 0) >=80 then '*' else ' ' end) alrt
 from SYS.dba_tablespaces d,
  (select tablespace_name, SUM (BYTES) BYTES,sum(decode(maxbytes,0,bytes,maxbytes)) maxbytes
   FROM dba_data_files
    GROUP BY tablespace_name) a,
     (
      select tablespace_name,sum(bytes) BYTES from dba_undo_extents where status in ('ACTIVE') group by tablespace_name
       ) t
where d.tablespace_name=a.tablespace_name(+)
 AND d.tablespace_name=t.tablespace_name(+)
  AND d.extent_management LIKE 'LOCAL' 
   AND d.CONTENTS ='UNDO'
    )
     ) where name like upper('%&1%')
order by pct_used desc, name
/
set ver on
