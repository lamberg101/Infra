set linesize 300
set pagesize 999
col segment_name format a35
col owner format a20
col tablespace_name format a30
select * from ( select owner, segment_name, segment_type, tablespace_name, round(sum(bytes/1024/1024),2) size_mb 
from dba_segments group by segment_name, owner, segment_type, tablespace_name order by 5 desc ) 
where tablespace_name='&tablespace_name'
and rownum<=100
order by tablespace_name;