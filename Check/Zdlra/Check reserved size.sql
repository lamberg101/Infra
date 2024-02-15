SET NUMF 9,999,999.999  
set lines 1000 pages 1000
col recovery_window_goal for a30 
col new_recovery_window for a30 
col max_retention_window for a30 
col db_unique_name for a20 
select 
	PURGE_ORDER, 
	rad.DB_UNIQUE_NAME, 
	size_estimate,
	disk_reserved_space,
	space_usage,
	recovery_window_space, 
	RECOVERY_WINDOW_GOAL, 
	NEW_RECOVERY_WINDOW, 
	NEW_PCT_RECOVERY, 
	PCT_STORAGE 
from ra_purging_queue rapq, ra_database rad 
where rapq.db_key=rad.db_key 
order by PCT_STORAGE desc;