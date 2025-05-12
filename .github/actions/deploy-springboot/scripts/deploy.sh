#!/bin/bash

set -e

EC2_HOST=$1
EC2_USER=$2
SSH_KEY=$3
JAR_FILE=$4

JAR_NAME=$(basename $JAR_FILE)
SERVICE_NAME=springboot-app

echo "📦 Copying $JAR_NAME to $EC2_USER@$EC2_HOST..."

# Copy jar file to EC2 home directory
scp -i $SSH_KEY -o StrictHostKeyChecking=no $JAR_FILE $EC2_USER@$EC2_HOST:/home/$EC2_USER/

echo "🚀 Deploying on EC2..."

# SSH and set up the service
ssh -i $SSH_KEY -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << EOF
  sudo mv /home/$EC2_USER/$JAR_NAME /opt/$JAR_NAME
  sudo bash -c 'cat > /etc/systemd/system/$SERVICE_NAME.service' << EOL
[Unit]
Description=Spring Boot App
After=network.target

[Service]
User=$EC2_USER
ExecStart=/usr/bin/java -jar /opt/$JAR_NAME
SuccessExitStatus=143
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOL

  sudo systemctl daemon-reexec
  sudo systemctl daemon-reload
  sudo systemctl enable $SERVICE_NAME
  sudo systemctl restart $SERVICE_NAME
  echo "✅ Service '$SERVICE_NAME' deployed and started."
EOF
