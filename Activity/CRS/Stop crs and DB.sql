
login to server using oracle
-- login to  db using sysdba
$> ps -ef | grep pmon
$> . oraenv 
$> enter
SQL> shutdown immediate;

--login to root
sudo su - 
$> sudo su -
Password:
$> ps -ef | grep tns
    grid 12517858        1   0   Aug 07      - 21:37 /oracle/app/grid/11.2.0.4/bin/tnslsnr LISTENER_SCAN1 -inherit
$> cd /oracle/app/grid/11.2.0.4/bin/
$> ls crsctl
$> crsctl stop crs -f
--wait until it finishes
$> ps -ef | grep pmon
--pastiin sevice sudah mati


Start db:
$> sqlplus / as sysdba


SQL> startup mount;
SQL> alter database open read only;


--RESTART MRP
select inst_id, sequence#, process, status from gv$managed_standby where process like 'MRP%';

--SHUTDOWN MRP
alter database recover managed standby database cancel;

--ACTIVATE MRP
alter database recover managed standby database using current logfile disconnect from session;



Start service
Login to root
$> ps -ef | grep tns
$> cd /oracle/app/grid/11.2.0.4/bin/
$> ./crsctl check crs
$> ./crsctl start crs
$> ./crsctl check crs

--$> ./crsctl enable crs
