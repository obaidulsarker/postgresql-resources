
CREATE OR REPLACE VIEW meta.v_get_table_size
 AS
 WITH RECURSIVE "pg_inherit"("inhrelid", "inhparent") AS (
         SELECT "pg_inherits"."inhrelid",
            "pg_inherits"."inhparent"
           FROM "pg_inherits"
        UNION
         SELECT "child"."inhrelid",
            "parent"."inhparent"
           FROM "pg_inherit" "child",
            "pg_inherits" "parent"
          WHERE ("child"."inhparent" = "parent"."inhrelid")
        ), "pg_inherit_short" AS (
         SELECT "pg_inherit"."inhrelid",
            "pg_inherit"."inhparent"
           FROM "pg_inherit"
          WHERE (NOT ("pg_inherit"."inhparent" IN ( SELECT "pg_inherit_1"."inhrelid"
                   FROM "pg_inherit" "pg_inherit_1")))
        )
 SELECT "a"."table_schema",
    "a"."table_name",
    "a"."row_estimate",
    "pg_size_pretty"("a"."total_bytes") AS "total",
    "pg_size_pretty"("a"."index_bytes") AS "index",
    "pg_size_pretty"("a"."toast_bytes") AS "toast",
    "pg_size_pretty"("a"."table_bytes") AS "table"
   FROM ( SELECT "a_1"."oid",
            "a_1"."table_schema",
            "a_1"."table_name",
            "a_1"."row_estimate",
            "a_1"."total_bytes",
            "a_1"."index_bytes",
            "a_1"."toast_bytes",
            "a_1"."parent",
            (("a_1"."total_bytes" - "a_1"."index_bytes") - COALESCE("a_1"."toast_bytes", (0)::numeric)) AS "table_bytes"
           FROM ( SELECT "c"."oid",
                    "n"."nspname" AS "table_schema",
                    "c"."relname" AS "table_name",
                    "sum"("c"."reltuples") OVER (PARTITION BY "c"."parent") AS "row_estimate",
                    "sum"("pg_total_relation_size"(("c"."oid")::"regclass")) OVER (PARTITION BY "c"."parent") AS "total_bytes",
                    "sum"("pg_indexes_size"(("c"."oid")::"regclass")) OVER (PARTITION BY "c"."parent") AS "index_bytes",
                    "sum"("pg_total_relation_size"(("c"."reltoastrelid")::"regclass")) OVER (PARTITION BY "c"."parent") AS "toast_bytes",
                    "c"."parent"
                   FROM (( SELECT "pg_class"."oid",
                            "pg_class"."reltuples",
                            "pg_class"."relname",
                            "pg_class"."relnamespace",
                            "pg_class"."reltoastrelid",
                            COALESCE("pg_inherit_short"."inhparent", "pg_class"."oid") AS "parent"
                           FROM ("pg_class"
                             LEFT JOIN "pg_inherit_short" ON (("pg_inherit_short"."inhrelid" = "pg_class"."oid")))
                          WHERE ("pg_class"."relkind" = ANY (ARRAY['r'::"char", 'p'::"char"]))) "c"
                     LEFT JOIN "pg_namespace" "n" ON (("n"."oid" = "c"."relnamespace")))) "a_1"
          WHERE (("a_1"."oid" = "a_1"."parent") AND ("a_1"."table_schema" = 'public'::"name"))) "a"
  ORDER BY "a"."total_bytes" DESC;