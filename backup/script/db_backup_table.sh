#!/bin/bash

PGDUMP=/usr/edb/as15/bin/pg_dump
BACKUP_LOCATION=/backup/dump
LOGFILE=$BACKUP_LOCATION/dbBackup.log
DB_NAME=db1
SCHEMA_NAME=public
TABLE_NAME=table1
BACKUP_FILENAME=$TABLE_NAME-$(date +%F_%H-%M-%S).dump
BACKUP_USER=postgres
BACKUP_PASS='xxxxxxx'
HOST=localhost
PORT=5432

# Perform Backup
echo "$(date) : TABLE ($TABLE_NAME) backup is STARTED" >> $LOGFILE;
PGPASSWORD=$BACKUP_PASS $PGDUMP --username $BACKUP_USER  --host $HOST --port $PORT  -Fc --table $TABLE_NAME -f $BACKUP_LOCATION/$BACKUP_FILENAME $DB_NAME 2>> $LOGFILE
echo "$(date) : TABLE ($TABLE_NAME) backup is FINISHED" >> $LOGFILE;