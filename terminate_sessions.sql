-- Мягко отменить
select pg_cancel_backend(pid) 
from pg_stat_activity
where  query_start < (now() - interval '1 minutes')
and backend_type ='client backend'
and usename in ('pvso_prod','fss_employee_api','fss_integration','eln_prod')
--and state<>'idle';

-- Жестко прибить: равносильно kill -9
select pg_terminate_backend(pid) 
from pg_stat_activity
where backend_type ='client backend'
and query_start < (now() - interval '20 minutes')
and usename in ('pvso_prod','fss_employee_api','fss_integration','eln_prod','fss_eln_web_service','cabs_prod','fss_ea_migrate')
and state<>'idle';

-- Найти паршивую овцу читающую из V_FC_ELN_DATA_ORG_SIGN
select datname, usename, client_addr, query_start, wait_event_type, wait_event, query from pg_stat_activity
where query like '%V_FC_ELN_DATA_ORG_SIGN%'
and backend_type='client backend'
and usename='fss_employee_api'
order by query_start;

-- Отстрелить ту самую овцу.
select pg_terminate_backend(pid) 
from pg_stat_activity
where query like '%V_FC_ELN_DATA_ORG_SIGN%'
and backend_type='client backend'
and usename='fss_employee_api'
order by query_start;

-- Убить запрос пользователя, который работает больше 1 ой минуты. 
select pg_terminate_backend(pid) 
from pg_stat_activity
where backend_type ='client backend'
and query_start < (now() - interval '1 minutes')
and usename in ('prod_db')
and state<>'idle';
