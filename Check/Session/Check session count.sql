set lines 300
select distinct username,machine, osuser,inst_id, 
count(*) from gv$session  
where osuser != 'oracle' 
group by username,machine, osuser, inst_id 
order by count(*) desc;