#!/bin/bash
# Send Email using this function
send_email_backup()
{

secondString=" "
#MSG = "${1/"ERROR:"/$secondString}"
FILE_NAME=$1
FILE_SIZE=$2
START_TIME=$3
END_TIME=$4

SUBJECT="BRAC ERP - Dump Backup"
EMAILS="abc@xyz.com"
SENDER="no-reply@xyz.com"
SMTP_SERVER="xxx.xxx.xxx.xxx"
SMTP_PORT=xxxx

MESSAGE="Dear All, \n\nDatabase Dump backup has been completed.\n\nBackup Name: $FILE_NAME \n\nBackup Size: $FILE_SIZE\n\nBackup Period: $START_TIME  To $END_TIME \n\nRegards\nDatabase Services"
for EMAIL in $(echo $EMAILS | tr "," " "); do
     echo -e "$MESSAGE" | mail -s "$SUBJECT" -S smtp=smtp://$SMTP_SERVER:$SMTP_PORT -r $SENDER  $EMAIL
     echo "Alert sent to $EMAIL"
done
}
