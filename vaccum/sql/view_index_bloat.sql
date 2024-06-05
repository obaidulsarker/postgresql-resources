
CREATE OR REPLACE VIEW meta.index_bloat
 AS
 SELECT "current_database"() AS "current_database",
    "relation_stats"."nspname" AS "schemaname",
    "relation_stats"."tblname",
    "relation_stats"."idxname",
    ("relation_stats"."bs" * (("relation_stats"."relpages")::bigint)::numeric) AS "real_size",
    ("relation_stats"."bs" * (((("relation_stats"."relpages")::double precision - "relation_stats"."est_pages"))::bigint)::numeric) AS "extra_size",
    (((100)::double precision * (("relation_stats"."relpages")::double precision - "relation_stats"."est_pages")) / ("relation_stats"."relpages")::double precision) AS "extra_pct",
    "relation_stats"."fillfactor",
        CASE
            WHEN (("relation_stats"."relpages")::double precision > "relation_stats"."est_pages_ff") THEN (("relation_stats"."bs")::double precision * (("relation_stats"."relpages")::double precision - "relation_stats"."est_pages_ff"))
            ELSE (0)::double precision
        END AS "bloat_size",
    (((100)::double precision * (("relation_stats"."relpages")::double precision - "relation_stats"."est_pages_ff")) / ("relation_stats"."relpages")::double precision) AS "bloat_pct",
    "relation_stats"."is_na"
   FROM ( SELECT COALESCE(((1)::double precision + "ceil"(("rows_hdr_pdg_stats"."reltuples" / "floor"((((("rows_hdr_pdg_stats"."bs" - ("rows_hdr_pdg_stats"."pageopqdata")::numeric) - ("rows_hdr_pdg_stats"."pagehdr")::numeric))::double precision / (((4)::numeric + "rows_hdr_pdg_stats"."nulldatahdrwidth"))::double precision))))), (0)::double precision) AS "est_pages",
            COALESCE(((1)::double precision + "ceil"(("rows_hdr_pdg_stats"."reltuples" / "floor"(((((("rows_hdr_pdg_stats"."bs" - ("rows_hdr_pdg_stats"."pageopqdata")::numeric) - ("rows_hdr_pdg_stats"."pagehdr")::numeric) * ("rows_hdr_pdg_stats"."fillfactor")::numeric))::double precision / ((100)::double precision * (((4)::numeric + "rows_hdr_pdg_stats"."nulldatahdrwidth"))::double precision)))))), (0)::double precision) AS "est_pages_ff",
            "rows_hdr_pdg_stats"."bs",
            "rows_hdr_pdg_stats"."nspname",
            "rows_hdr_pdg_stats"."tblname",
            "rows_hdr_pdg_stats"."idxname",
            "rows_hdr_pdg_stats"."relpages",
            "rows_hdr_pdg_stats"."fillfactor",
            "rows_hdr_pdg_stats"."is_na"
           FROM ( SELECT "rows_data_stats"."maxalign",
                    "rows_data_stats"."bs",
                    "rows_data_stats"."nspname",
                    "rows_data_stats"."tblname",
                    "rows_data_stats"."idxname",
                    "rows_data_stats"."reltuples",
                    "rows_data_stats"."relpages",
                    "rows_data_stats"."idxoid",
                    "rows_data_stats"."fillfactor",
                    ((((((("rows_data_stats"."index_tuple_hdr_bm" + ("rows_data_stats"."maxalign")::numeric) -
                        CASE
                            WHEN (("rows_data_stats"."index_tuple_hdr_bm" % ("rows_data_stats"."maxalign")::numeric) = (0)::numeric) THEN ("rows_data_stats"."maxalign")::numeric
                            ELSE ("rows_data_stats"."index_tuple_hdr_bm" % ("rows_data_stats"."maxalign")::numeric)
                        END))::double precision + "rows_data_stats"."nulldatawidth") + ("rows_data_stats"."maxalign")::double precision) - (
                        CASE
                            WHEN ("rows_data_stats"."nulldatawidth" = (0)::double precision) THEN 0
                            WHEN ((("rows_data_stats"."nulldatawidth")::integer % "rows_data_stats"."maxalign") = 0) THEN "rows_data_stats"."maxalign"
                            ELSE (("rows_data_stats"."nulldatawidth")::integer % "rows_data_stats"."maxalign")
                        END)::double precision))::numeric AS "nulldatahdrwidth",
                    "rows_data_stats"."pagehdr",
                    "rows_data_stats"."pageopqdata",
                    "rows_data_stats"."is_na"
                   FROM ( SELECT "n"."nspname",
                            "ct"."relname" AS "tblname",
                            "i"."idxname",
                            "i"."reltuples",
                            "i"."relpages",
                            "i"."idxoid",
                            "i"."fillfactor",
                            ("current_setting"('block_size'::"text"))::numeric AS "bs",
                                CASE
                                    WHEN (("version"() ~ 'mingw32'::"text") OR ("version"() ~ '64-bit|x86_64|ppc64|ia64|amd64'::"text")) THEN 8
                                    ELSE 4
                                END AS "maxalign",
                            24 AS "pagehdr",
                            16 AS "pageopqdata",
                                CASE
                                    WHEN ("max"(COALESCE("s"."stanullfrac", (0)::real)) = (0)::double precision) THEN (2)::numeric
                                    ELSE ((2)::numeric + (((32 + 8) - 1) / 8))
                                END AS "index_tuple_hdr_bm",
                            "sum"((((1)::double precision - COALESCE("s"."stanullfrac", (0)::real)) * (COALESCE("s"."stawidth", 1024))::double precision)) AS "nulldatawidth",
                            ("max"(
                                CASE
                                    WHEN ("a"."atttypid" = ('"name"'::"regtype")::"oid") THEN 1
                                    ELSE 0
                                END) > 0) AS "is_na"
                           FROM ((((( SELECT "idx_data_cross"."idxname",
                                    "idx_data_cross"."reltuples",
                                    "idx_data_cross"."relpages",
                                    "idx_data_cross"."tbloid",
                                    "idx_data_cross"."idxoid",
                                    "idx_data_cross"."fillfactor",
CASE
 WHEN ("idx_data_cross"."indkey"["idx_data_cross"."i"] = 0) THEN "idx_data_cross"."idxoid"
 ELSE "idx_data_cross"."tbloid"
END AS "att_rel",
CASE
 WHEN ("idx_data_cross"."indkey"["idx_data_cross"."i"] = 0) THEN "idx_data_cross"."i"
 ELSE "idx_data_cross"."indkey"["idx_data_cross"."i"]
END AS "att_pos"
                                   FROM ( SELECT "idx_data"."idxname",
    "idx_data"."reltuples",
    "idx_data"."relpages",
    "idx_data"."tbloid",
    "idx_data"."idxoid",
    "idx_data"."fillfactor",
    "idx_data"."indkey",
    "generate_series"(1, ("idx_data"."indnatts")::integer) AS "i"
   FROM ( SELECT "ci"."relname" AS "idxname",
      "ci"."reltuples",
      "ci"."relpages",
      "i_1"."indrelid" AS "tbloid",
      "i_1"."indexrelid" AS "idxoid",
      COALESCE((("substring"("array_to_string"("ci"."reloptions", ' '::"text"), 'fillfactor=([0-9]+)'::"text"))::smallint)::integer, 90) AS "fillfactor",
      "i_1"."indnatts",
      ("string_to_array"("textin"("int2vectorout"("i_1"."indkey")), ' '::"text"))::integer[] AS "indkey"
     FROM ("pg_index" "i_1"
       JOIN "pg_class" "ci" ON (("ci"."oid" = "i_1"."indexrelid")))
    WHERE (("ci"."relam" = ( SELECT "pg_am"."oid"
       FROM "pg_am"
      WHERE ("pg_am"."amname" = 'btree'::"name"))) AND ("ci"."relpages" > 0))) "idx_data") "idx_data_cross") "i"
                             JOIN "pg_attribute" "a" ON ((("a"."attrelid" = "i"."att_rel") AND ("a"."attnum" = "i"."att_pos"))))
                             JOIN "pg_statistic" "s" ON ((("s"."starelid" = "i"."att_rel") AND ("s"."staattnum" = "i"."att_pos"))))
                             JOIN "pg_class" "ct" ON (("ct"."oid" = "i"."tbloid")))
                             JOIN "pg_namespace" "n" ON (("ct"."relnamespace" = "n"."oid")))
                          GROUP BY "n"."nspname", "ct"."relname", "i"."idxname", "i"."reltuples", "i"."relpages", "i"."idxoid", "i"."fillfactor", ("current_setting"('block_size'::"text"))::numeric,
                                CASE
                                    WHEN (("version"() ~ 'mingw32'::"text") OR ("version"() ~ '64-bit|x86_64|ppc64|ia64|amd64'::"text")) THEN 8
                                    ELSE 4
                                END, 24::integer) "rows_data_stats") "rows_hdr_pdg_stats") "relation_stats"
  WHERE ("relation_stats"."nspname" = 'public'::"name")
  ORDER BY
        CASE
            WHEN (("relation_stats"."relpages")::double precision > "relation_stats"."est_pages_ff") THEN (("relation_stats"."bs")::double precision * (("relation_stats"."relpages")::double precision - "relation_stats"."est_pages_ff"))
            ELSE (0)::double precision
        END DESC;