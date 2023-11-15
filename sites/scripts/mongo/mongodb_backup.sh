#!/bin/bash

# Variables
CONTAINER_NAME="novu-mongodb"

# Generate a human-readable timestamp e.g. 2023-08-24_14-30-22
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")

BACKUP_PATH="$(pwd)/mongodb_backup_$TIMESTAMP.gz"
TEMP_PATH="/tmp/backup_$TIMESTAMP.gz"

# Backup MongoDB
echo "Starting MongoDB backup..."
docker exec $CONTAINER_NAME mongodump --archive=$TEMP_PATH --gzip
echo "MongoDB backup completed inside container."

# Copy backup to host
docker cp $CONTAINER_NAME:$TEMP_PATH $BACKUP_PATH
echo "Backup copied to host at $BACKUP_PATH."

# Cleanup
docker exec $CONTAINER_NAME rm $TEMP_PATH
echo "Cleanup completed inside container."

echo "MongoDB backup script finished!"
