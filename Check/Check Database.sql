--CHECK CREATED
select created from v$database;


--CHECK NAME
select name, database_role from v$database;


--CHECK ROLE
select inst_id,name, open_mode, database_role from gv$database;


--CHECK STARTUP
select instance_name,to_char(startup_time,'mm/dd/yyyy hh24:mi:ss') as startup_time from gv$instance;


--CHECK SIZE ALL
select 
    ( select round(sum(bytes)/1024/1024/1024,2) data_size from dba_data_files ) + 
    ( select round(nvl(sum(bytes),0)/1024/1024/1024,2) temp_size from dba_temp_files ) + 
    ( select round(sum(bytes)/1024/1024/1024,2) redo_size from sys.v_$log ) + 
    ( select round(sum(block_size*file_size_blks)/1024/1024/1024,2) controlfile_size from v$controlfile) 
"SIZE IN GB" from dual;


--CHECK VERSION
col product format a35
col version format a15
col status format a15 
select * from product_component_version;

