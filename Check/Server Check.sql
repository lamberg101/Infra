
1.	Masuk ke putty, DB Prod 1 ( 10.55.53.203)
username: oracle
password: ORAdb01!@#

2.	bash
3.	ps -ef|grep pmon
(asm 1 bmiprd1)

4.	ps -ef|grep tns
(tns listener 3)

5.	lsnrctl status
(uptime kalau off merah)

6.	crsctl stat res -t
(pastikan semua Target dan State online, kecuali ora.gsd dan ora.oc4j)

