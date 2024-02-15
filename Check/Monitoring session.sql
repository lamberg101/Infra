with
eod as
(select a.branch_code,a.SESSION_ID,a.SERIAL_NO,target_stage,running_stage,eoc_status, c.eoc_batch, a.eod_date , a.error_code, floor((sysdate-c.START_TIME)*24*60) CURRBATCH, floor((sysdate-d.START_TIME)*24*60) CURREOC
from fcc114.aetb_eoc_branches a, fcc114.sttm_branch b,fcc114.aetb_eoc_programs c, fcc114.AETB_EOC_RUNCHART d
where a.branch_code = b.branch_code and b.record_stat ='O' and a.eoc_status <> 'C' and
a.branch_code=c.branch_code(+) and a.branch_code=d.branch_code(+)
and a.eod_date = c.eod_date(+) and a.running_stage = c.eoc_stage(+) and a.eod_date = d.eod_date(+) and a.running_stage = d.eoc_stage(+)
and (nvl(c.eoc_batch_status,'W')='W' or c.eoc_batch_status='A')
)
,
prevbatch as
(select a.branch_code, a.eoc_stage, a.eoc_batch, ceil((a.END_TIME-a.START_TIME)*24*60) PREV from fcc114.aetb_eoc_programs_history a,
(select branch_code,eod_date from fcc114.aetb_eoc_branches where eoc_status ='W') b
where a.branch_code = b.branch_code and a.eoc_batch_status = 'C' and
a.eod_date = (select max(c.eod_date) from fcc114.aetb_eoc_programs_history c where a.branch_code=c.branch_code and c.branch_code = b.branch_code and c.eod_date < b.eod_date)
)
,
sess as
(select s.inst_id,s.sid, s.serial#, p.spid, s.username, s.status, s.logon_time, s.sql_id,s.event from gv$session s, gv$process p where  s.username is not null
and    s.paddr = p.addr
and    s.status = 'ACTIVE'
and s.inst_id = p.inst_id),
preveoctiming as
(
select a.branch_code, a.eoc_stage, ceil((a.END_TIME-a.START_TIME)*24*60) PREV from fcc114.AETB_EOC_RUNCHART_HISTORY a,
(select branch_code,eod_date from fcc114.aetb_eoc_branches where eoc_status ='W') b
where a.branch_code = b.branch_code and a.EOC_STAGE_STATUS = 'C' and
a.eod_date = (select max(c.eod_date) from fcc114.AETB_EOC_RUNCHART_HISTORY c where a.branch_code=c.branch_code and c.branch_code = b.branch_code and c.eod_date < b.eod_date)
)
select case
when nvl(sid,1)=1 and e.eoc_status='W' then '***'
when e.eoc_status='A' then '**'
when (CURRBATCH>(prevbatch*1.5)) or (CURREOC>(preveoctiming*1.5)) then '*'
else ' ' end as alr ,
e.branch_code brn , to_char(e.eod_date,'DD-MON-YYYY') eod_date ,e.target_stage target,nvl(e.running_stage,'N/A') running,e.eoc_status ,
NVL(e.eoc_batch,nvl(e.running_stage,'N/A')) EOC_BATCH,
case when e.eoc_status='W' and nvl(sid,-1)<>-1 then lpad((case nvl(prevbatch,-1) when -1 then preveoctiming || ' min' else prevbatch || ' min' end),7,' ') else '  --' end as "PREV(m)" ,
case when e.eoc_status='W' and nvl(sid,-1)<>-1 then lpad((case nvl(CURRBATCH,-1) when -1 then CURREOC || ' min' else CURRBATCH || ' min' end),7,' ') else '  --' end as "CURR(m)",
case nvl(sid,1) when 1 then ' NO SESSION' else '''' || s.sid || ',' || s.serial# || ',@' || s.inst_id || '''' end "'SID,SN#,@INST'"
, nvl(s.username,'N/A') "USER", nvl(s.status,'N/A') status, nvl(to_char(s.logon_time),'N/A') logon_time, nvl(s.sql_id,'N/A') sql_id, nvl(s.event,'ERROR_CODE = ' || nvl(e.error_code,'N/A')) event
from
(select a.* , b.PREV prevbatch,c.PREV preveoctiming, c.eoc_stage from eod a, prevbatch b, preveoctiming c where a.branch_code = c.branch_code(+) and a.running_stage = c.eoc_stage(+)
and a.branch_code = b.branch_code(+) and a.running_stage = b.eoc_stage(+) and a.eoc_batch = b.eoc_batch(+)) e
, sess s
 where s.sid(+) = e.SESSION_ID and s.serial#(+) = e.SERIAL_NO
order by 1 desc,s.logon_time;
