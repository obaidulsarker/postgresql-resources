SELECT state, COUNT(*) AS connection_count
FROM pg_stat_activity
GROUP BY state;
