PASTIKAN SHUTDOWN TERLEBIH DAHULU MANAGE SERVER WEBLOGIC FUT
PASTIKAN LOGIN SEBAGAI SYSDBA UNTUK RESET PASSWORD, caranya :
-pwd
-oranev
-sqlplus / as sysdba
-show user
-alter user fcc114 identified by fcc114fut;
(di enter setelah mematikan manage server di weblogic FUT)
