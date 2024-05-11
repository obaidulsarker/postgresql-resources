
CREATE OR REPLACE VIEW meta.unused_indexes
 AS
 SELECT "s"."schemaname",
    "s"."relname" AS "tablename",
    "s"."indexrelname" AS "indexname",
    "pg_relation_size"(("s"."indexrelid")::"regclass") AS "index_size"
   FROM ("pg_stat_user_indexes" "s"
     JOIN "pg_index" "i" ON (("s"."indexrelid" = "i"."indexrelid")))
  WHERE (("s"."schemaname" = 'public'::"name") AND ("s"."idx_scan" = 0) AND (0 <> ALL (("i"."indkey")::smallint[])) AND (NOT "i"."indisunique") AND (NOT (EXISTS ( SELECT 1
           FROM "pg_constraint" "c"
          WHERE ("c"."conindid" = "s"."indexrelid")))))
  ORDER BY ("pg_relation_size"(("s"."indexrelid")::"regclass")) DESC;
