
Steps:
- Cancel the MRP (if in standby)
- Bring to mount stage (stop using srvctl, then start mount)
- Check datafile no and location
- Backup as copy (RMAN)
- Switch to copy (RMAN)
- Delete datafile (from RMAN or manually in ASM)
- Stop then start database
- Start the MRP


------------------------------------------------------------------------------------------------------------
**Example Datafile no 4

1. Backup datafile
RMAN> BACKUP AS COPY DATAFILE 4 FORMAT "+NEWDISK";

--alter datafile offline
--RMAN> SQL "ALTER DATABASE DATAFILE ''+DATA/orcl/datafile/users.261.689589837'' OFFLINE";

2. Switch to copy 
RMAN> SWITCH DATAFILE 4 TO COPY;

--recover
--RMAN> RECOVER DATAFILE "+USERDATA/orcl/datafile/users.256.689682663";

--alter online
--RMAN> SQL "ALTER DATABASE DATAFILE ''+USERDATA/orcl/datafile/users.256.689682663'' ONLINE";

4. Delete from rman or ASM (manually)
RMAN> DELETE DATAFILECOPY "+DATA/orcl/datafile/users.261.689589837";



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



Move ASM files from one diskgroup to another diskgroup tips

Oracle Database Tips by Donald BurlesonJuly 22, 2015
Question:  I need to move datafiles from one diskgroup to another ASM diskgroup.  How do I migrate ASM files between diskgroups?

Answer:  Moving data files from one ASM diskgroup to another diskgroup involves these steps:

--Step 1: Get the data file name:
select file_name from dba_data_files;

--Step 2:  Identify the target diskgroup to migrate to:
select name from v$asm_diskgroup;

--Step 3:  Take the old data file offline:
alter database datafile '+MYDB_OLDDATA/mysid/app_data.nnn' offline; 

--Step 4:  Copy the datafile to the new diskgroup (using RMAN)
$ rman target / 
connected to target database: TESTDB (DBID=1234) 

RMAN> copy datafile '+MYDB_OLDDATA/mysid/app_data.nnn' to '+MYDB_NEWDATA'; 

--Step 6: Get the new filename:
select file_name from dba_data_files; 

--Step 7: Re-name the data file:
SQL> alter database rename file 
'+MYDB_OLDDATA/mysid/app_data.nnn' 
to 
'+MYDB_NEWDATA/mysid/app_data.nnn';

After Oracle renames the ASM database file in the data dictionary, it will remove the original ASM database file (+MYDB_OLDDATA/mysid/app_data.nnn). 

Step 8: Rename the RMAN data file:

RMAN> switch datafile '+MYDB_NEWDATA/mysid/app_data.nnn' to copy;

Step 9: Use RMAN recovery to the new data file:

RMAN> recover datafile '+MYDB_NEWDATA/mysid/app_data.nnn';

Step 10:  Put the data file online:

RMAN> alter database datafile '+MYDB_NEWDATA/mysid/app_data.nnn' online;

Step 11: Delete the old ASM file from the old diskgroup.
$ ORACLE_SID=+ASM; export ORACLE_SID

$ sqlplus "/ as sysdba"

SQL> ALTER DISKGROUP TESTDB_DATA2 DROP FILE '+TESTDB_OLDDATA/mysid/app_data.nnn';


