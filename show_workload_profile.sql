-- Show active sessions
select usename
, state
,backend_type
, min(query_start)
, max(query_start)
,query 
,count(1)
from pg_stat_activity
where state='active'
and backend_type<>'parallel worker'
group by usename, state, query,backend_type
order by count(1) desc;

select 
usename
, state
,backend_type
, min(query_start)
, max(query_start)
,query ,
count(1)
from pg_stat_activity
where state like '%idle%'
and backend_type<>'parallel worker'
group by usename, state, query,backend_type
order by min(query_start) desc;

-- Count active users
select usename,state, count(*)
from pg_stat_activity
where state='active'
group by usename, state
order by 3 desc,1;

-- Show transactions working more one minute
select pid,usename,datname,query_start, wait_event_type, wait_event, state, query, backend_type 
from pg_stat_activity
where  query_start < (now() - interval '1 minutes')
and backend_type ='client backend'
and usename  not in ('postgres','rep')
and usename is not null
and state<>'idle';
