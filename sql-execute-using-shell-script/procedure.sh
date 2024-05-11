#!/bin/bash

PGDUMP=/usr/edb/as15/bin/psql
SCRIPT_LOCATION=/sql-execute-using-shell-script
LOGFILE=$SCRIPT_LOCATION/execute.log
HOST=localhost
PORT=5432
DB_NAME=db1
BACKUP_USER=postgres
BACKUP_PASS='xxxxxxxxxxxxx'
PROC1="EXEC public.database_growth()"

# Perform Backup
echo "$(date) : [$PROC1] IS STARTED" >> $LOGFILE;
# FOR PROC1
PGPASSWORD=$BACKUP_PASS $PGDUMP --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -c "$PROC1" 2>> $LOGFILE
echo "$(date) : [$PROC1] IS  FINISHED" >> $LOGFILE;
exit
