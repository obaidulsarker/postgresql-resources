
------------------ App Role ------------------------------------------
CREATE ROLE appgroup;
GRANT CONNECT TO appgroup;
GRANT USAGE ON SCHEMA public TO appgroup;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO appgroup;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO appgroup;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO appgroup;

-- Future Objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT,INSERT, UPDATE, DELETE ON TABLES TO appgroup;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO appgroup;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO appgroup;


CREATE ROLE appuser WITH LOGIN PASSWORD 'xxxxxxxxx';
GRANT appgroup TO appuser;

-- -------------Read Only Role ------------------------------------------------------
GRANT USAGE ON SCHEMA public TO readaccess;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readaccess;

-- Grant access to future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readaccess;


CREATE ROLE readuser WITH LOGIN PASSWORD 'xxxxxxxxx';
GRANT readaccess TO readuser;