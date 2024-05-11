#!/bin/bash
# Send Email using this function
send_email_transfer()
{

secondString=" "
#MSG = "${1/"ERROR:"/$secondString}"
FILE_NAME=$1
FILE_SIZE=$2
SOURCE_FILE_SIZE=$3

SUBJECT="Backup Transfer: BRAC ERP"
EMAILS="abc@xyz.com"
SENDER="no-reply@xyz.com"

SMTP_SERVER="xxx.xxx.xxx.xx"
SMTP_PORT=xxxx

MESSAGE="Dear All, \n\nDatabase backup has been arrived to local server.\n\nBackup Name: $FILE_NAME \n\nSource File Size: $SOURCE_FILE_SIZE\n\nDestination File Size: $FILE_SIZE \n\nRegards\nDatabase Services"
for EMAIL in $(echo $EMAILS | tr "," " "); do
     echo -e "$MESSAGE" | mail -s "$SUBJECT" -S smtp=smtp://$SMTP_SERVER:$SMTP_PORT -r $SENDER  $EMAIL
     echo "Alert sent to $EMAIL"
done
}
