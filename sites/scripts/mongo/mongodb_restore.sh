#!/bin/bash

# Check for input file
if [ "$#" -ne 1 ]; then
    echo "Usage: ./mongodb_restore.sh <path_to_backup_file>"
    exit 1
fi

BACKUP_FILE=$1

# Variables
CONTAINER_NAME="novu-mongodb"
TEMP_PATH="/tmp/restore.gz"
DATABASE_NAME="novu-db"

# Copy backup file from host to container
docker cp $BACKUP_FILE $CONTAINER_NAME:$TEMP_PATH
echo "Backup copied to container."

# Drop the database
echo "Dropping database..."
docker exec $CONTAINER_NAME mongosh $DATABASE_NAME --eval "db.dropDatabase()"
echo "Database dropped."

# Restore MongoDB from backup
echo "Starting MongoDB restore..."
docker exec $CONTAINER_NAME mongorestore --archive=$TEMP_PATH --gzip
echo "MongoDB restore completed."

# Cleanup
docker exec $CONTAINER_NAME rm $TEMP_PATH
echo "Cleanup completed inside container."

echo "MongoDB restore script finished!"
