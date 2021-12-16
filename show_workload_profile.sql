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
