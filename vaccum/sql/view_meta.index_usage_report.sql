
CREATE OR REPLACE VIEW meta.index_usage_report
 AS
 SELECT "pg_stat_all_indexes"."relid",
    "pg_stat_all_indexes"."indexrelid",
    "pg_stat_all_indexes"."schemaname",
    "pg_stat_all_indexes"."relname",
    "pg_stat_all_indexes"."indexrelname",
    "pg_stat_all_indexes"."idx_scan",
    "pg_stat_all_indexes"."idx_tup_read",
    "pg_stat_all_indexes"."idx_tup_fetch"
   FROM "pg_stat_all_indexes"
  WHERE ("pg_stat_all_indexes"."schemaname" = 'public'::"name");