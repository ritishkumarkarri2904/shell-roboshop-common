#!/bin/bash


USERID=$(id -u)
LOGS_FOLDER="/var/logs/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[34m"

START_TIME=$(date +%S)

mkdir -p $LOGS_FOLDER #create logs folder if not exists

echo -e " $(date +"%d-%m-%Y %H:%M:%S") $0 script execution started .... $Y" | tee -a $LOGS_FILE

check_root () {
    if [ $USERID -ne 0 ]; then
        echo -e " $R Please run this script as root or with sudo privileges. $N" | tee -a $LOGS_FILE
        exit 1
    fi
}




VALIDATE () {
if [ $1 -ne 0 ]; then
    echo -e "$(date +"%d-%m-%Y %H:%M:%S")" $2 .... $R FAILURE $N" | tee -a $LOGS_FILE
    exit 1
else
    echo -e "$(date +"%d-%m-%Y %H:%M:%S")" $2 .... $G SUCCESS $N" | tee -a $LOGS_FILE
fi

}

print_total_time () {
    END_TIME=$(date +%S)
    TOTAL_TIME=$((END_TIME - START_TIME))
    echo -e " $(date +"%d-%m-%Y %H:%M:%S") | Total time taken to execute the script: $TOTAL_TIME seconds $Y" | tee -a $LOGS_FILE
}