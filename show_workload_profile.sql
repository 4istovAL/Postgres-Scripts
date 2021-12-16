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
