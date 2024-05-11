#!/bin/bash

LOC=/backup/dump;
LOGLOC=$LOC;
LOGFILE=$LOGLOC/removeBackup.log;
DBNAME=db1;
touch $LOGFILE;

FILES=`find $LOC/ -type f -mtime +15 | grep $DBNAME | sort`;

for n in $FILES;
do
        /bin/rm -rf $n;
        if [ -f $n ]; then
                echo "File : $n Removed Failed # $(date)" >> $LOGFILE;
        else
                echo "File : $n Removed # $(date)" >> $LOGFILE;
        fi
done

exit
