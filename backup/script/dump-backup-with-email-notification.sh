#!/bin/bash

source /backup/script/send_email.sh
source /backup/script/send_email_transfer.sh

PGDUMP=/usr/edb/as15/bin/pg_dump
PGSQL=/usr/edb/as15/bin/psql

BACKUP_LOCATION=/backup/dump
LOGFILE=$BACKUP_LOCATION/dbBackup.log

BACKUP_FILENAME=$DB_NAME-$(date +%F_%H-%M-%S).dump

HOST=localhost
DB_NAME=db1
PORT=5432
BACKUP_USER=postgres
BACKUP_PASS='xxxxxxx'
SCHEMA=public

# Perform Backup
echo "$(date) : DB backup STARTED" >> $LOGFILE;
START_TIME="$(date +'%F %H:%M:%S %p')"

# Stoped Recovery
PGPASSWORD=$BACKUP_PASS $PGSQL --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -c "SELECT pg_wal_replay_pause()" 2>> $LOGFILE;

sleep 5m;

PGPASSWORD=$BACKUP_PASS $PGDUMP --username $BACKUP_USER  --host $HOST --port $PORT -Fc --lock-wait-timeout=600 --no-sync  --schema $SCHEMA -f $BACKUP_LOCATION/$BACKUP_FILENAME $DB_NAME 2>> $LOGFILE;


sleep 2m;

# Start Recovery
PGPASSWORD=$BACKUP_PASS $PGSQL --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -c "SELECT pg_wal_replay_resume()" 2>> $LOGFILE;

# Get source file size
str=`ls -lh $BACKUP_LOCATION | grep $BACKUP_FILENAME`;
IFS=' ' # space is set as delimiter
read -ra arr <<< "$str" # str is read into an array as tokens separated by IFS

BACKUP_SIZE=${arr[4]}
BACKUP_FILE=${arr[8]}

END_TIME="$(date +'%F %H:%M:%S %p')"

echo "BACKUP FILE: $BACKUP_FILE" >> $LOGFILE;
echo "BACKUP SIZE: $BACKUP_SIZE" >> $LOGFILE;

echo "$(date) : DB backup FINISHED" >> $LOGFILE;

sleep 2m;

# Send Email for backup completion
send_email_backup "$BACKUP_FILE" "$BACKUP_SIZE" "$START_TIME" "$END_TIME"

# Transfer backup to remote server
echo "$(date) : Backup transfer is STARTED." >> $LOGFILE;
SSH_PORT=22
SOURCE_FILE=$BACKUP_LOCATION/$BACKUP_FILENAME
DEST_SVR="root@xx.xx.xx.xx"
DEST_LOC="/backup/livedb/"
scp -P $SSH_PORT $SOURCE_FILE $DEST_SVR:$DEST_LOC 2>> $LOGFILE;

sleep 2m;

# get source file size
str=`ssh -p $SSH_PORT -n $DEST_SVR ls -lh $DEST_LOC/$BACKUP_FILENAME`
IFS=' ' # space is set as delimiter
read -ra arr <<< "$str" # str is read into an array as tokens separated by IFS
DEST_BACKUP_SIZE=${arr[4]}

echo "$(date) : Destination Server: $DEST_SVR" >>$LOGFILE;
echo "$(date) : Destination File: $DEST_LOC/$BACKUP_FILENAME" >>$LOGFILE;
echo "$(date) : Destination File Size: $DEST_BACKUP_SIZE" >>$LOGFILE;

echo "$(date) : Backup transfer is COMPLETED." >> $LOGFILE;
echo "*********************************************************************************"

sleep 2m;

# Email notfication of backup transfer
send_email_transfer $BACKUP_FILE $DEST_BACKUP_SIZE $BACKUP_SIZE;
