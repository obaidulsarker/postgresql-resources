
CREATE OR REPLACE VIEW meta.v_get_vacuum_script_by_free_storage
 AS
 SELECT "tbl"."tablename",
    "tbl"."tbloat",
    "round"(("tbl"."wastedbytes" / ((1024 * 1024))::numeric), 2) AS "wastedbytes_mb",
    (('VACUUM(FULL, ANALYZE) '::"text" || ("tbl"."tablename")::"text") || ';'::"text") AS "sql_full_vacuum",
    (('VACUUM(ANALYZE) '::"text" || ("tbl"."tablename")::"text") || ';'::"text") AS "sql_vacuum"
   FROM ( SELECT "v_bloat"."tablename",
            "v_bloat"."tbloat",
            "v_bloat"."wastedbytes"
           FROM "meta"."v_bloat"
          WHERE (("v_bloat"."schemaname" = 'public'::"name") AND ("v_bloat"."wastedbytes" > (0)::numeric))
          GROUP BY "v_bloat"."tablename", "v_bloat"."tbloat", "v_bloat"."wastedbytes") "tbl"
  ORDER BY "tbl"."wastedbytes" DESC;
