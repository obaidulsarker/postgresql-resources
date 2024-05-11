CREATE OR REPLACE VIEW meta.v_get_vaccuum_tables_by_dead_rows
 AS
 SELECT "pg_stat_all_tables"."relname",
    "pg_stat_all_tables"."n_tup_ins",
    "pg_stat_all_tables"."n_tup_upd",
    "pg_stat_all_tables"."n_tup_del",
    "pg_stat_all_tables"."n_tup_hot_upd",
    "pg_stat_all_tables"."n_live_tup",
    "pg_stat_all_tables"."n_dead_tup",
    (('VACUUM(FULL, ANALYZE) '::"text" || ("pg_stat_all_tables"."relname")::"text") || ';'::"text") AS "sql_cmd_full",
    (('VACUUM(ANALYZE) '::"text" || ("pg_stat_all_tables"."relname")::"text") || ';'::"text") AS "sql_cmd_vacuum"
   FROM "pg_stat_all_tables"
  WHERE (("pg_stat_all_tables"."schemaname" = 'public'::"name") AND ("pg_stat_all_tables"."n_dead_tup" > 0))
  ORDER BY "pg_stat_all_tables"."n_dead_tup" DESC;