#!/bin/bash

source ./common.sh


check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGS_FILE
VALIDATE $? "Copying Mongo Repo"

dnf install mongodb-org -y 
VALIDATE $? "Installing MongoDB server"

systemctl enable mongod &>> $LOGS_FILE
VALIDATE $? "Enable MongoDB"

systemctl start mongod &>> $LOGS_FILE
VALIDATE $? "Starting MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $LOGS_FILE
VALIDATE $? "Allowing remote connections"

systemctl restart mongod &>> $LOGS_FILE
VALIDATE $? "Restarted MongoDB"

print_total_time