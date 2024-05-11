#!/bin/bash
PSQL=/usr/pgsql-14/bin/psql
PORT=5432
BACKUP_LOCATION=/backup/dump
LOGFILE=$BACKUP_LOCATION/dbBackup.log
DB_NAME=db1
BACKUP_USER=postgres
BACKUP_PASS='xxxxxxxxxx'
HOST=xx.xx.xx.xx

DUMP_FILE=/backup/dump/db1.sql

# Perform Backup
echo "$(date) : DB restoration is STARTED" >> $LOGFILE;

PGPASSWORD=$BACKUP_PASS $PSQL --host $HOST --port $PORT  --username $BACKUP_USER  --dbname $DB_NAME -f $DUMP_FILE

echo "$(date) : DB restoration is FINISHED" >> $LOGFILE;
