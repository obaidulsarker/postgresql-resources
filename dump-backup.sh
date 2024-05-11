#!/bin/bash
PGDUMP=/usr/pgsql-14/bin/pg_dump
PSQL=/usr/pgsql-14/bin/psql
PORT=5432
BACKUP_LOCATION=/backup
LOGFILE=$BACKUP_LOCATION/dbBackup.log
DB_NAME=db1
BACKUP_FILENAME=$DB_NAME-$(date +%F_%H-%M-%S).dump
BACKUP_USER=postgres
BACKUP_PASS='xxxxxxxxxx'
HOST=xx.xx.xx.xx

# Perform Backup
echo "$(date) : DB backup STARTED" >> $LOGFILE;
PGPASSWORD=$BACKUP_PASS $PGDUMP --username $BACKUP_USER  --host $HOST --port $PORT --schema public -Fc  -f $BACKUP_LOCATION/$BACKUP_FILENAME $DB_NAME 2>> $LOGFILE

echo "$(date) : DB backup FINISHED" >> $LOGFILE;
