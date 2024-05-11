
CREATE OR REPLACE VIEW meta.v_data_growth_report
 AS
 SELECT "c"."snapshot_date" AS "dt",
    "c"."table_name",
    "c"."row_estimate" AS "current_month_row_count",
    "p"."row_estimate" AS "last_month_row_count",
    "c"."table" AS "current_month_data_size",
    "p"."table" AS "last_month_data_size",
    "c"."index" AS "current_month_index_size",
    "p"."index" AS "last_month_index_size",
    "c"."total" AS "current_month_total_size",
    "p"."total" AS "last_month_total_size"
   FROM (( SELECT "table_growth_public_schema"."snapshot_date",
            "table_growth_public_schema"."table_schema",
            "table_growth_public_schema"."table_name",
            "table_growth_public_schema"."row_estimate",
            "table_growth_public_schema"."total",
            "table_growth_public_schema"."index",
            "table_growth_public_schema"."toast",
            "table_growth_public_schema"."table"
           FROM "meta"."table_growth_public_schema"
          WHERE (("year"("table_growth_public_schema"."snapshot_date") = "year"(("now"() - '1 day'::interval))) AND ("month"("table_growth_public_schema"."snapshot_date") = "month"(("now"() - '1 day'::interval))) AND ("day"("table_growth_public_schema"."snapshot_date") = "day"(("now"() - '1 day'::interval))))) "c"
     LEFT JOIN ( SELECT "table_growth_public_schema"."snapshot_date",
            "table_growth_public_schema"."table_schema",
            "table_growth_public_schema"."table_name",
            "table_growth_public_schema"."row_estimate",
            "table_growth_public_schema"."total",
            "table_growth_public_schema"."index",
            "table_growth_public_schema"."toast",
            "table_growth_public_schema"."table"
           FROM "meta"."table_growth_public_schema"
          WHERE (("year"("table_growth_public_schema"."snapshot_date") = "year"(("now"() - '30 days'::interval))) AND ("month"("table_growth_public_schema"."snapshot_date") = "month"(("now"() - '30 days'::interval))) AND ("day"("table_growth_public_schema"."snapshot_date") = "day"(("now"() - '30 days'::interval))))) "p" ON (("c"."table_name" = "p"."table_name")));
