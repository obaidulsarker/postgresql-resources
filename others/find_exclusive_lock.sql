SELECT 
         l.mode,
 	     a.state,
         a.query,
         count(1) AS cnt
FROM pg_stat_activity a
JOIN pg_locks l ON l.pid = a.pid
WHERE l.pid != pg_backend_pid()
AND l.mode like '%Exclusive%'
GROUP BY  l.mode,
 	     a.state,
         a.query
ORDER BY  count(1) DESC