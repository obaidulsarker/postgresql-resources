#!/bin/bash
# Send Email using this function
send_email()
{

OTHER_EMAIL=$1;
SERVER_IP=$2;
DB_NAME=$3
BACKUP_NAME=$4;

SUBJECT="Database Restoration"
EMAILS="abc@xyz.com"
SENDER="abc@xyz.com"
SMTP="xx.xx.xx.xx:xx"

# Check other is empty or not
if [ ! -z "$OTHER_EMAIL" -a "$OTHER_EMAIL" != " " ]; then
EMAILS="$EMAILS, $OTHER_EMAIL"
fi

MESSAGE="Dear All, \n Following database has been restored sucessfully.\n\nServer Info: ${SERVER_IP} \nDatabase: ${DB_NAME} \nBackup Name: ${BACKUP_NAME} \n\nRegards,\nDatabase Services"
for EMAIL in $(echo $EMAILS | tr "," " "); do
     echo -e "$MESSAGE" | mail -s "$SUBJECT" -S smtp=smtp://$SMTP -r $SENDER  $EMAIL
     echo "Alert sent to $EMAIL"
done
}
