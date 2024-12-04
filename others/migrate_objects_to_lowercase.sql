CREATE OR REPLACE FUNCTION migrate_objects_to_lowercase(schema_name TEXT)
RETURNS void LANGUAGE plpgsql AS $$
DECLARE
    obj RECORD;
    col RECORD;
    new_obj_name TEXT;
    new_col_name TEXT;
BEGIN
    -- Process Tables
    FOR obj IN
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = schema_name AND table_type = 'BASE TABLE'
    LOOP
  		
		-- Convert table name to lowercase with underscores
        new_obj_name := regexp_replace(obj.table_name, '([A-Z])', '_\1', 'g');
        new_obj_name := lower(new_obj_name);
        new_obj_name := TRIM(LEADING '_' FROM new_obj_name);
		
        EXECUTE format('ALTER TABLE %I.%I RENAME TO %I', schema_name, obj.table_name, new_obj_name);
        
        -- Process columns in the table
        FOR col IN
            SELECT column_name
            FROM information_schema.columns
            WHERE table_schema = schema_name AND table_name = new_obj_name
        LOOP
            -- Convert column name to lowercase with underscores
            new_col_name := regexp_replace(col.column_name, '([A-Z])', '_\1', 'g');
            new_col_name := lower(new_col_name);
            new_col_name := TRIM(LEADING '_' FROM new_col_name);
			
            IF new_col_name <> col.column_name THEN
                EXECUTE format('ALTER TABLE %I.%I RENAME COLUMN %I TO %I', schema_name, new_obj_name, col.column_name, new_col_name);
            END IF;
        END LOOP;
		
		
    END LOOP;

    -- Process Views
    FOR obj IN
        SELECT table_name
        FROM information_schema.views
        WHERE table_schema = schema_name
    LOOP
        -- Convert view name to lowercase with underscores
        new_obj_name := regexp_replace(obj.table_name, '([A-Z])', '_\1', 'g');
        new_obj_name := lower(new_obj_name);
        new_obj_name := TRIM(LEADING '_' FROM new_obj_name);
		
        EXECUTE format('ALTER VIEW %I.%I RENAME TO %I', schema_name, obj.table_name, new_obj_name);
    END LOOP;

    -- Process Procedures
    FOR obj IN
        SELECT routine_name
        FROM information_schema.routines
        WHERE routine_schema = schema_name
    LOOP
        -- Convert procedure name to lowercase with underscores
        new_obj_name := regexp_replace(obj.routine_name, '([A-Z])', '_\1', 'g');
        new_obj_name := lower(new_obj_name);
        new_obj_name := TRIM(LEADING '_' FROM new_obj_name);
		
        EXECUTE format('ALTER FUNCTION %I.%I RENAME TO %I', schema_name, obj.routine_name, new_obj_name);
    END LOOP;
	
	-- Convert all constraints
    FOR obj IN
        SELECT conname, conrelid::regclass::text AS table_name
        FROM pg_constraint
        WHERE connamespace = (SELECT oid FROM pg_namespace WHERE nspname = schema_name)
    LOOP
		new_obj_name := regexp_replace(obj.conname, '([A-Z])', '_\1', 'g');
        new_obj_name := lower(new_obj_name);
        new_obj_name := TRIM(LEADING '_' FROM new_obj_name);
		
        -- Rename the constraint if the name changes
        IF new_obj_name != obj.conname THEN
            EXECUTE format('ALTER TABLE %I.%I RENAME CONSTRAINT %I TO %I', schema_name, obj.table_name, obj.conname, new_obj_name);
        END IF;
    END LOOP;
	
    RAISE NOTICE 'Migration completed for schema: %', schema_name;
END;
$$;
