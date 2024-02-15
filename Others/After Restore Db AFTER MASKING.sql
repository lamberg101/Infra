Steps to be done after fresh restoration in Testing ENV:
-change FCC114 password -> alter user FCC114 identified by passwordnyapa;
-disable archive mode in database -> login sqlplus '/ as sysdba' di putty -> shutdown immediate; -> startup mount -> alter database noarchivelog; -> alter database open;
-modify RELEASE & WORK_AREA in CSTB_PARAM -> select * from cstb_param where PARAM_NAME in ('WORK_AREA','RELEASE');
-modify ELCM(IP) related parameter in CSTB_PARAM 
	Get the URL from weblogic > deployments > FCUBS EAR > ELGatewayClient > testing > ambil salah 1 manage server
	example:	
	http://10.55.54.75:8001/FCUBS114UAT-ELGatewayClient/IntegrationController
	replace with
	http://10.55.54.75:9004/FCUBS114UATCR-ELGatewayClient/IntegrationController

