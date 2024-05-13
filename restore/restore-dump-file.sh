#!/bin/bash
PG_RESTORE=/usr/pgsql-14/bin/pg_restore
PORT=5432
BACKUP_LOCATION=/backup/dump
LOGFILE=$BACKUP_LOCATION/dbBackup.log
DB_NAME=db1
BACKUP_USER=postgres
BACKUP_PASS='xxxxxxxxxx'
HOST=xx.xx.xx.xx

DUMP_FILE=/backup/dump/db1.dump

# Perform Backup
echo "$(date) : DB restoration is STARTED" >> $LOGFILE;

PGPASSWORD=$BACKUP_PASS $PG_RESTORE --host $HOST --port $PORT --username $BACKUP_USER -c -v --dbname $DB_NAME $DUMP_FILE

echo "$(date) : DB restoration is FINISHED" >> $LOGFILE;
