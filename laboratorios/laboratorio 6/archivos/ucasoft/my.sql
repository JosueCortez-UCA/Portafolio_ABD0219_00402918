-- a
select now();

-- b
SELECT d.datname AS Name, pg_catalog.pg_get_userbyid(d.datdba) AS Owner,
  CASE WHEN pg_catalog.has_database_privilege(d.datname, 'CONNECT')
    THEN pg_catalog.pg_size_pretty(pg_catalog.pg_database_size(d.datname)) 
    ELSE 'No Access' 
  END AS SIZE 
FROM pg_catalog.pg_database d 
ORDER BY 
  CASE WHEN pg_catalog.has_database_privilege(d.datname, 'CONNECT') 
    THEN pg_catalog.pg_database_size(d.datname)
    ELSE NULL 
END;

-- c
\c ucasoft

SELECT nspname || '.' || relname AS "relation",
   pg_size_pretty(pg_total_relation_size(C.oid)) AS "total_size"
 FROM pg_class C
 LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
 WHERE nspname NOT IN ('pg_catalog', 'information_schema')
   AND C.relkind <> 'i'
   AND nspname !~ '^pg_toast'
 ORDER BY pg_total_relation_size(C.oid) DESC;

-- d
\x

-- e
SELECT now() - query_start as "runtime", usename, datname, wait_event, state, query
FROM  pg_stat_activity
WHERE now() - query_start > '10 minutes'::interval
ORDER BY runtime DESC;

-- f
SELECT query, calls, total_time, rows, 100.0 * shared_blks_hit /
       nullif(shared_blks_hit + shared_blks_read, 0) AS hit_percent
FROM pg_stat_statements ORDER BY total_time DESC LIMIT 10;
