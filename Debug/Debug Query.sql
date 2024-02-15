select * from smtb_current_users where user_id = '20190287';
select * from cstb_param where PARAM_NAME like '%DEBUG%' ;
--update cstb_param set PARAM_VAL = 'Y' where PARAM_NAME = 'REAL_DEBUG' ;
select * from cstb_debug_users where user_id = '20190287';
--UPDATE cstb_debug_users SET DEBUG ='Y' WHERE USER_ID = '20190287'
--INSERT INTO cstb_debug_users (Module, Debug, user_id) select MODULE, DEBUG, '20190287' from cstb_debug_users WHERE USER_ID = 'PARAMETER1'; 
