-- Список блокирующих сессий. 
select pid,usename,datname,query_start, wait_event_type, wait_event, state, query, backend_type 
from pg_stat_activity 
where pid in (
select pid from pg_catalog.pg_locks
)
order by query_start,query,usename;
