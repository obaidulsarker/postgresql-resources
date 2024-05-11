#!/bin/bash

PGDUMP=/usr/edb/as15/bin/psql

WORK_DIR=/vaccum
SCRIPT_LOCATION=$WORK_DIR/script
LOGFILE=$SCRIPT_LOCATION/vacuum_analyze_reindex.log
HOST=localhost
PORT=5432
DB_NAME=db1
BACKUP_USER=postgres
BACKUP_PASS='xxxxxxxxx'

FILE_NAME1=$SCRIPT_LOCATION/vacumm_tables.sql

# FOR VACCUM & ANALYZE
echo "$(date) : VACUUM IS STARTED ****************************" >> $LOGFILE;
PGPASSWORD=$BACKUP_PASS $PGDUMP --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -a -f $FILE_NAME1 2>&1 >> $LOGFILE
echo "$(date) : VACUUM IS FINISHED **************************" >> $LOGFILE;

#sql file clear
:>$FILE_NAME1;

exit
