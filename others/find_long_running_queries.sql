SELECT a.datname,
         l.relation::regclass,
         l.transactionid,
         l.mode,
 	 a.state,
         l.GRANTED,
		 a.client_addr,
         a.usename,
         a.query,
         a.query_start,
         age(now(), a.query_start) AS "age",
         a.pid
FROM pg_stat_activity a
JOIN pg_locks l ON l.pid = a.pid
WHERE l.pid != pg_backend_pid()
ORDER BY a.query_start;