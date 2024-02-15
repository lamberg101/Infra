SELECT DBMS_METADATA.GET_DDL('PACKAGE_BODY','STPKS_STDCIFIS_KERNEL','FCC114') FROM DUAL;

select * from dba_objects where object_name like '%ICDUDVAL%' and owner = 'FCC114' and object_type = 'PACKAGE BODY';

select * from cstb_fid_data_sources where function_id = 'ICDUDVAL' order by 3; 
