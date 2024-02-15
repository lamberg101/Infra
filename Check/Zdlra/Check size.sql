SET NUMF 9,999,999.999
COLUMN name FORMAT A10
set lines 300
SELECT name, total_space, used_space, freespace, freespace_goal, 
SUM(recovery_window_space) sum_recovery_window_space
FROM ra_storage_location 
JOIN ra_database 
ON (storage_location = name)
GROUP BY name, total_space, used_space, freespace, freespace_goal;