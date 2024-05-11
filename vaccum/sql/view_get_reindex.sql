
CREATE OR REPLACE VIEW meta.v_get_reindex
 AS
 SELECT "index_bloat"."current_database",
    "index_bloat"."schemaname",
    "index_bloat"."tblname",
    "index_bloat"."idxname",
    "index_bloat"."real_size",
    "index_bloat"."extra_size",
    "index_bloat"."extra_pct",
    "index_bloat"."fillfactor",
    "index_bloat"."bloat_size",
    "index_bloat"."bloat_pct",
    (('REINDEX INDEX '::"text" || ("index_bloat"."idxname")::"text") || ';'::"text") AS "re_index"
   FROM "meta"."index_bloat"
  ORDER BY "index_bloat"."bloat_size" DESC;
