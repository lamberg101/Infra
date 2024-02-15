1. Shutdown MRP di node 1.
SQL> alter database recover managed standby database cancel;

--2. Defer log_archive_dest yang berhubungan ke DR lain (jika cascade).
--SYS@rptfcubs1> alter system set log_archive_dest_2='defer'; 

3. Shutdown Database Node 2.
SQL> shutdown immediate;

3. Shutdown Database Node 3.
SQL> shutdown immediate;


4. Check status FLASHBACK_ON database Node 1
SQL> select flashback_on from v$database;

FLASHBACK_ON
------------------
NO

--If NO, then alter the FLASHBACK_ON to on
SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.

SQL> startup mount;

SQL> alter database flashback on;
Database altered.

SQL> select flashback_on from v$database;

FLASHBACK_ON
------------------
YES

5. Alter db to snapshot standby role
SQL> alter database convert to snapshot standby;
Database altered.

SQL> select open_mode, database_role from v$database;

OPEN_MODE          DATABASE_ROLE
------------       ----------------
MOUNTED            SNAPSHOT STANDBY


6. Make open write mode
SQL> startup force;

SQL> select database_role, open_mode from v$database;

DATABASE_ROLE       OPEN_MODE
----------------    --------------------
SNAPSHOT STANDBY    READ WRITE


7. Startup database Node 2
SQL> startup;
SQL> select database_role, open_mode from v$database;

DATABASE_ROLE        OPEN_MODE
----------------    --------------------
SNAPSHOT STANDBY     READ WRITE


8. Startup database Node 3
SQL> startup;
SQL> select database_role, open_mode from gv$database;

DATABASE_ROLE        OPEN_MODE
----------------    --------------------
SNAPSHOT STANDBY     READ WRITE



SQL> select database_role, open_mode from gv$database;

--Check
set lines 300
col db_unique_name for a10
col host_name for a10
select distinct host_name, name, db_unique_name, instance_name, database_role, open_mode from gv$instance, gv$database;


======================================================================================================================


Convert back to Physical standby

1. Shutdown database node 2
SQL> shutdown immediate;


2. Shutdown database node 3
SQL> shutdown immediate;


3. Shutdown database and startup mount node 1
SQL> shutdown immediate;
SQL> startup mount;


4. Alter to physical standby Node 1
SQL> alter database convert to physical standby;

5. Change Flashback ke off on Node 1
SQL> shutdown immediate;
SQL> startup mount;
SQL> alter database flashback off;


6. Alter database read only dan aktivasi MRP Node 1
SQL> alter database open read only;
Database altered.

--SQL> alter database recover managed standby database using current logfile disconnect from session;
--Database altered
--
--7. Cek database dan status MRP Node 1
--SQL> select open_mode, database_role from v$database;
--
--OPEN_MODE            DATABASE_ROLE
---------------------- ----------------
--READ ONLY WITH APPLY PHYSICAL STANDBY
--
--SQL> select process,  status, sequence# from v$managed_standby;
--
--PROCESS   STATUS        SEQUENCE#
----------- ------------ ----------
--ARCH      CONNECTED             0
--ARCH      CONNECTED             0
--ARCH      CONNECTED             0
--ARCH      CONNECTED             0
--MRP0      WAIT_FOR_LOG     130268


8. Startup database read only Node 2 & 3
SQL> startup mount;
SQL> alter database open read only;


--Check
set lines 300
col db_unique_name for a10
col host_name for a10
select distinct host_name, name, db_unique_name, instance_name, database_role, open_mode from gv$instance, gv$database;


--check again, make sure mrp applying
SQL> select process,  status, sequence# from v$managed_standby;


--switchlog
SQL> itch logfile; --10x

--check the gap and alert log
