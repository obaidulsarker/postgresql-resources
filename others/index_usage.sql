SELECT
    pt.tablename AS TableName
    ,t.indexname AS IndexName
    ,to_char(pc.reltuples, '999,999,999,999') AS TotalRows
    ,pg_size_pretty(pg_relation_size(quote_ident(pt.tablename)::text)) AS TableSize
    ,pg_size_pretty(pg_relation_size(quote_ident(t.indexrelname)::text)) AS IndexSize
    ,to_char(t.idx_scan, '999,999,999,999') AS TotalNumberOfScan
    ,to_char(t.idx_tup_read, '999,999,999,999') AS TotalTupleRead
    ,to_char(t.idx_tup_fetch, '999,999,999,999') AS TotalTupleFetched
FROM pg_tables AS pt
LEFT OUTER JOIN pg_class AS pc 
    ON pt.tablename=pc.relname
LEFT OUTER JOIN
( 
    SELECT 
        pc.relname AS TableName
        ,pc2.relname AS IndexName
        ,psai.idx_scan
        ,psai.idx_tup_read
        ,psai.idx_tup_fetch
        ,psai.indexrelname 
    FROM pg_index AS pi
    JOIN pg_class AS pc 
        ON pc.oid = pi.indrelid
    JOIN pg_class AS pc2 
        ON pc2.oid = pi.indexrelid
    JOIN pg_stat_all_indexes AS psai 
        ON pi.indexrelid = psai.indexrelid 
)AS T
    ON pt.tablename = T.TableName
WHERE pt.schemaname='public'
ORDER BY 1;