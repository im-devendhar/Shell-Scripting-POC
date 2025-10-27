#!/bin/bash

# Your S3 bucket name
BUCKET_NAME="logs-devapp"

# Folder where your logs are stored
LOG_FOLDER="/var/log/nginx"

# AWS region of your bucket
REGION="us-east-1"

# Get today's date in format DDMMYYYY
DATE=$(date +%d%m%Y)

# Hostname of your EC2 instance
HOSTNAME=$(hostname)

# Upload each .log file in the folder to S3
for file in "$LOG_FOLDER"/*.log; do
  if [ -f "$file" ]; then
    aws s3 cp "$file" "s3://$BUCKET_NAME/logs/$HOSTNAME/$DATE/$(basename "$file")" --region "$REGION"
    echo "Uploaded $file to S3"
  fi
done
