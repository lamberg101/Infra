select  owner, tablespace_name, segment_type, segment_name,sum(bytes/1024/1024) MB 
from dba_segments 
where tablespace_name='PRD_IAS_ORASDPM'
and segment_type in ('TABLE','TABLE PARTITION')
group by owner, tablespace_name, segment_name, segment_type
order by segment_type;

https://oracle.zoom.us/my/morris.putrayasa?pwd=NTFFVXdnTXIwUWNsYS9ab2ZqcnhvUT09