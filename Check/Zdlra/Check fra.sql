
--CHEK FRA
set linesize 900
COLUMN recovery_file_dest FORMAT a30                  HEADING 'Recovery File Dest'
COLUMN space_limit        FORMAT 999,999              HEADING 'Space Limit GB'
COLUMN space_used         FORMAT 999,999              HEADING 'Space Used GB'
COLUMN space_used_pct     FORMAT 999.99               HEADING '% Used'
COLUMN space_reclaimable  FORMAT 99,999,999,999,999   HEADING 'Space Reclaimable'
COLUMN pct_reclaimable    FORMAT 999.99               HEADING '% Reclaimable'
COLUMN number_of_files    FORMAT 999,999              HEADING 'Number of Files'

SELECT name recovery_file_dest, 
space_limit / 1024 / 1024 / 1024 space_limit_GB, 
space_used / 1024 / 1024 / 1024 space_used_GB, 
ROUND((space_used / space_limit)*100, 2) space_used_pct, 
space_reclaimable space_reclaimable, 
ROUND((space_reclaimable / space_limit)*100, 2) pct_reclaimable, 
number_of_files number_of_files
FROM v$recovery_file_dest;

