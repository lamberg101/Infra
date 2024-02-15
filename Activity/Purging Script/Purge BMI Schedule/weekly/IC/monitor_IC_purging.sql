set lines 190 pages 1000
select PMODE,count(*) from fcc114.ICTB_PURGE_MONITOR where trunc(start_time) = trunc(sysdate) and branch_code <> '999' group by pmode;
