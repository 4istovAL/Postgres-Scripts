select query, client_addr, count(1)
from pg_stat_activity
where  backend_type ='client backend'
and state<>'idle'
and usename  not in ('postgres','rep')
and usename is not null
group by query, client_addr
order by 3 desc;


select * from public.pg_stat_statements
where stddev_time>15 
and query not like '%pg_catalog%'
and query not like '%pg_stat_statements%'
order by stddev_time desc;
