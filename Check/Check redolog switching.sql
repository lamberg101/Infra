-- Check redolog switching
set pagesize 90
set linesize 150
set heading on
col day for a5
column "00:00" format 9999
column "01:00" format 9999
column "02:00" format 9999
column "03:00" format 9999
column "04:00" format 9999
column "05:00" format 9999
column "06:00" format 9999
column "07:00" format 9999
column "08:00" format 9999
column "09:00" format 9999
column "10:00" format 9999
column "11:00" format 9999
column "12:00" format 9999
column "13:00" format 9999
column "14:00" format 9999
column "15:00" format 9999
column "16:00" format 9999
column "17:00" format 9999
column "18:00" format 9999
column "19:00" format 9999
column "20:00" format 9999
column "21:00" format 9999
column "22:00" format 9999
column "23:00" format 9999
select * from ( 
select * from ( 
select to_char(first_time, 'dd/mm') as "DAY", 
sum(to_number(decode(to_char(first_time, 'hh24'), '00', 1, 0), '99')) "00:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '01', 1, 0), '99')) "01:00",
sum(to_number(decode(to_char(first_time, 'hh24'), '02', 1, 0), '99')) "02:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '03', 1, 0), '99')) "03:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '04', 1, 0), '99')) "04:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '05', 1, 0), '99')) "05:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '06', 1, 0), '99')) "06:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '07', 1, 0), '99')) "07:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '08', 1, 0), '99')) "08:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '09', 1, 0), '99')) "09:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '10', 1, 0), '99')) "10:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '11', 1, 0), '99')) "11:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '12', 1, 0), '99')) "12:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '13', 1, 0), '99')) "13:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '14', 1, 0), '99')) "14:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '15', 1, 0), '99')) "15:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '16', 1, 0), '99')) "16:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '17', 1, 0), '99')) "17:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '18', 1, 0), '99')) "18:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '19', 1, 0), '99')) "19:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '20', 1, 0), '99')) "20:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '21', 1, 0), '99')) "21:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '22', 1, 0), '99')) "22:00", 
sum(to_number(decode(to_char(first_time, 'hh24'), '23', 1, 0), '99')) "23:00"
from v$log_history
where extract(year from first_time) = extract(year from sysdate)
group by to_char(first_time, 'dd/mm')) 
order by to_date(extract(year from sysdate) || day, 'yyyy dd/mm') desc) 
where rownum <10;



-- Check redolog switing (total)
set pages 20
set lines 999
col 00 for a4
col 01 for a4
col 02 for a4
col 03 for a4
col 04 for a4
col 05 for a4
col 06 for a4
col 07 for a4
col 08 for a4
col 09 for a4
col 10 for a4
col 11 for a4
col 12 for a4
col 13 for a4
col 14 for a4
col 15 for a4
col 16 for a4
col 17 for a4
col 18 for a4
col 19 for a4
col 20 for a4
col 21 for a4
col 22 for a4
col 23 for a4
col day for a10
select to_char(first_time,'DD-MON-RR') day,
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)),'999') "00",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)),'999') "01",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)),'999') "02",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)),'999') "03",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)),'999') "04",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)),'999') "05",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)),'999') "06",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)),'999') "07",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)),'999') "08",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)),'999') "09",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)),'999') "10",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)),'999') "11",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)),'999') "12",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)),'999') "13",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)),'999') "14",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)),'999') "15",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)),'999') "16",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)),'999') "17",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)),'999') "18",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)),'999') "19",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)),'999') "20",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)),'999') "21",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)),'999') "22",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)),'999') "23",
sum(1) "TOTAL_IN_DAY" from v$log_history group by to_char(first_time,'DD-MON-RR') order by to_date(day);



-- Check redolog switing (average)
set pages 999 lines 400
col Day form a10
col h0 format 999
col h1 format 999
col h2 format 999
col h3 format 999
col h4 format 999
col h5 format 999
col h6 format 999
col h7 format 999
col h8 format 999
col h9 format 999
col h10 format 999
col h11 format 999
col h12 format 999
col h13 format 999
col h14 format 999
col h15 format 999
col h16 format 999
col h17 format 999
col h18 format 999
col h19 format 999
col h20 format 999
col h21 format 999
col h22 format 999
col h23 format 999
SELECT TRUNC (first_time) "Date", inst_id, TO_CHAR (first_time, 'Dy') "Day",
COUNT (1) "Total Switches Per Day",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '00', 1, 0)) "h0",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '01', 1, 0)) "h1",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '02', 1, 0)) "h2",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '03', 1, 0)) "h3",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '04', 1, 0)) "h4",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '05', 1, 0)) "h5",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '06', 1, 0)) "h6",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '07', 1, 0)) "h7",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '08', 1, 0)) "h8",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '09', 1, 0)) "h9",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '10', 1, 0)) "h10",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '11', 1, 0)) "h11",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '12', 1, 0)) "h12",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '13', 1, 0)) "h13",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '14', 1, 0)) "h14",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '15', 1, 0)) "h15",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '16', 1, 0)) "h16",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '17', 1, 0)) "h17",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '18', 1, 0)) "h18",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '19', 1, 0)) "h19",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '20', 1, 0)) "h20",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '21', 1, 0)) "h21",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '22', 1, 0)) "h22",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '23', 1, 0)) "h23",
ROUND (COUNT (1) / 24, 2) "Avg"
FROM gv$log_history
WHERE thread# = inst_id
AND first_time > sysdate -7
GROUP BY TRUNC (first_time), inst_id, TO_CHAR (first_time, 'Dy')
ORDER BY 1,2;