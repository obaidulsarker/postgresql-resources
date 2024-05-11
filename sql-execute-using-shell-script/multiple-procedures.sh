#!/bin/bash

PGDUMP=/usr/edb/as15/bin/psql
SCRIPT_LOCATION=/sql-execute-using-shell-script
LOGFILE=$SCRIPT_LOCATION/execute.log
HOST=localhost
PORT=5432
DB_NAME=db1
BACKUP_USER=postgres
BACKUP_PASS='xxxxxxxxxxxxx'

PROC1="call example_proc1()"
# Perform Backup
echo "$(date) : [$PROC1] IS STARTED" >> $LOGFILE;
# FOR PROC1
PGPASSWORD=$BACKUP_PASS $PGDUMP --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -c "$PROC1" 2>> $LOGFILE
echo "$(date) : [$PROC1] IS  FINISHED" >> $LOGFILE;

PROC2="call example_proc2()"
echo "$(date) : [$PROC2] IS STARTED" >> $LOGFILE;
# FOR PROC2
PGPASSWORD=$BACKUP_PASS $PGDUMP --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -c "$PROC2" 2>> $LOGFILE
echo "$(date) : [$PROC2] IS  FINISHED" >> $LOGFILE;

PROC3="call example_proc3()"

# Perform Backup
echo "$(date) : [$PROC3] IS STARTED" >> $LOGFILE;
# FOR PROC3
PGPASSWORD=$BACKUP_PASS $PGDUMP --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -c "$PROC3" 2>> $LOGFILE
echo "$(date) : [$PROC3] IS  FINISHED" >> $LOGFILE;


PROC4="call example_proc4();"
echo "$(date) : [$PROC4] IS STARTED" >> $LOGFILE;
#FOR PROC4
PGPASSWORD=$BACKUP_PASS $PGDUMP --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -c "$PROC4" 2>> $LOGFILE
echo "$(date) : [$PROC4] IS  FINISHED" >> $LOGFILE;

exit
