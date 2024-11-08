WITH RECURSIVE table_depth AS (
    -- Base case: Start with all tables in the schema, with depth level 0 and an empty path
    SELECT 
        t.table_name,
        0 AS depth_level,
        ARRAY[t.table_name] AS path  -- Initialize path with the current table
    FROM 
        information_schema.tables AS t
    WHERE 
        t.table_schema = 'public'

    UNION ALL

    -- Recursive case: Find child tables through foreign key relationships
    SELECT 
        fk.table_name,
        td.depth_level + 1 AS depth_level,
        td.path || fk.table_name  -- Append current table to the path
    FROM 
        information_schema.table_constraints AS fk_tc
    JOIN 
        information_schema.key_column_usage AS fk
    ON 
        fk_tc.constraint_name = fk.constraint_name
    JOIN 
        information_schema.referential_constraints AS rc
    ON 
        fk_tc.constraint_name = rc.constraint_name
    JOIN 
        information_schema.key_column_usage AS pk
    ON 
        rc.unique_constraint_name = pk.constraint_name
    JOIN 
        table_depth AS td
    ON 
        pk.table_name = td.table_name
    WHERE 
        fk_tc.table_schema = 'public'
        AND fk_tc.constraint_type = 'FOREIGN KEY'
        AND fk.table_name != td.table_name
        AND fk.table_name != ALL(td.path)  -- Avoid revisiting tables already in the path
)

-- Final selection: Get the maximum depth level for each table
SELECT 
    t.table_name,
    COALESCE(MAX(td.depth_level), 0) AS max_depth_level
FROM 
    information_schema.tables AS t
LEFT JOIN 
    table_depth AS td 
ON 
    t.table_name = td.table_name
WHERE 
    t.table_schema = 'public'
GROUP BY 
    t.table_name
ORDER BY 
    max_depth_level DESC;
