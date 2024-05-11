#!/bin/bash
BACKUP_LOCATION=/restore
source $BACKUP_LOCATION/send-email.sh

PG_PSQL=/usr/edb/as11/bin/psql
PG_RESTORE=/usr/edb/as11/bin/pg_restore
RESTORE_LOC=$BACKUP_LOCATION

#BACKUP_LOCATION=/script/restore
LOGFILE=$BACKUP_LOCATION/logs/restore-$(date +%F_%H-%M-%S).log
PERMISSION_FILE=$BACKUP_LOCATION/permission.sql

HOST=xx.xx.xx.xx
PORT=5432
BACKUP_USER=postgres
BACKUP_PASS="xxxxxxxxxx"
SERVER_IP="xx.xx.xx.xx"

# Dev User
DEV_USER=user1
DEV_USER_PASS="xxxxx;

DB_NAME="";
BACKUP_LOC="";
BACKUP_FILE="";
EMAIL="mno@xyz.com";

echo "$(date) : ************************************************" >> $LOGFILE;
echo "$(date) :          RESTORATION is STARTED                 " >> $LOGFILE;
echo "$(date) : ************************************************" >> $LOGFILE;

#Check Disk Spac
#STORAGE=( $(du -sh $RESTORE_LOC) )
STORAGE=( $(df -Ph $RESTORE_LOC | tail -1 | awk '{print $4}'))
echo "Available storage in [$RESTORE_LOC] directory is $STORAGE."
echo "$(date) : Available storage in [$RESTORE_LOC] directory is $STORAGE." >> $LOGFILE;
read -p "Do you want to continue (Y/N)?" yn
    case $yn in
         [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac


# get backup file location
echo "Enter backup file location:"
read BACKUP_LOC;

echo "Enter backup file name:"
read BACKUP_FILE;

DUMP_FILE=$BACKUP_LOC/$BACKUP_FILE;

if [ ! -f "$DUMP_FILE" ]; then
  echo "[$DUMP_FILE] file does not exist, please try again."
  exit
fi

# get backup file location
echo "Enter email address who wants to get notfication other than infra.support:"
read EMAIL;

until [ ! -z "$DB_NAME" ]
 do
        echo "Enter database name:"
        read DB_NAME

        # check database name is not empty
        if  [ ! -z "$DB_NAME" ]
        then

          # Check database exist
         DB=( $(PGPASSWORD=$BACKUP_PASS $PG_PSQL --host $HOST --port $PORT  -U $BACKUP_USER -d postgres -c "SELECT datname FROM pg_database WHERE datname='$DB_NAME' LIMIT 1;"))

          # Check DB existence
          if [ ${#DB[@]} == 5 ]
          then
                echo "[$DB_NAME] database is existed, please enter new name.";
                echo "$(date) : ERROR - [$DB_NAME] database is existed, please enter new name." >> $LOGFILE;
                DB_NAME="";
          else
                # create database
                 PGPASSWORD=$BACKUP_PASS $PG_PSQL --host $HOST --port $PORT  -U $BACKUP_USER -d postgres -c "CREATE DATABASE $DB_NAME" 2>> $LOGFILE;
                echo "[$DB_NAME] database is created."
                echo "$(date) : [$DB_NAME] database is created." >> $LOGFILE;
                # Restore DB
                PGPASSWORD=$BACKUP_PASS $PG_RESTORE --host $HOST --port $PORT  -U $BACKUP_USER -c -v -d $DB_NAME $DUMP_FILE 2>> $LOGFILE;
                echo "$(date) : [$DB_NAME] database is restored." >> $LOGFILE;

                # Set DB Unque ID
                PGPASSWORD=$BACKUP_PASS $PG_PSQL --host $HOST --port $PORT  -U $BACKUP_USER -d postgres -c "ALTER DATABASE $DB_NAME SET cluster.unique_db_id TO 1;" 2>> $LOGFILE;
                echo "Unique ID is set to [$DB_NAME]";
                echo "$(date) : Unique ID is set to [$DB_NAME]" >> $LOGFILE;

                # GRANT PERMISSION TO appgroup & REMOVE confidential data
               PGPASSWORD=$BACKUP_PASS $PG_PSQL --host $HOST --port $PORT  -U $BACKUP_USER -d $DB_NAME -a -f $PERMISSION_FILE 2>> $LOGFILE;
               echo "Permissions are granted by [$BACKUP_USER]";
               echo "$(date) : Permissions are granted by [$BACKUP_USER]" >> $LOGFILE;
               sleep 5;

               PGPASSWORD=$DEV_USER_PASS $PG_PSQL --host $HOST --port $PORT  -U $DEV_USER -d $DB_NAME -a -f $PERMISSION_FILE 2>> $LOGFILE;
              echo "Permissions are granted by [$DEV_USER]";
              echo "$(date) : Permissions are granted by [$DEV_USER]" >> $LOGFILE;

              # Send Email
              SERVER_INFO="${SERVER_IP}:${PORT}"
              send_email $EMAIL $SERVER_INFO $DB_NAME $DUMP_FILE
             fi

        fi

 done

echo "$(date) : +++++++++++++++++++++++++++++++++++++++++++++++++" >> $LOGFILE;
echo "$(date) :          RESTORATION is FINISHED                 " >> $LOGFILE;
echo "$(date) : +++++++++++++++++++++++++++++++++++++++++++++++++" >> $LOGFILE;