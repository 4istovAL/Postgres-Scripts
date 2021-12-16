SELECT backend_xmin, usename, state,backend_type, min(query_start), max(query_start),query ,count(1) 
FROM pg_stat_activity
WHERE usename  not in ('postgres','rep') --exclude system users and processes
and usename is not null
and backend_type<>'parallel worker'
and backend_xmin is not null
group by  backend_xmin, usename, state,backend_type,query
order by min;
