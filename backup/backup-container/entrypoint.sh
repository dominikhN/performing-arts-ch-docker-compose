#!/bin/sh

BACKUP_FILE_NAME="${BACKUP_NAME}-$(date "+%Y-%m-%d_%H-%M-%S").tar.gz"
BACKUP_FILE_PATH="${BACKUP_BASE_PATH}/${BACKUP_FILE_NAME}"

tar -zcvf "${BACKUP_FILE_PATH}" "${FOLDERS_TO_BACKUP}"

if [ -z "${S3_BUCKET_URL}" ]; then
	echo "No S3 BUCKET specified. Skipping S3 backup."
fi
if [ -n "${S3_BUCKET_URL}" ]; then
	echo "Uploading backup archive ${BACKUP_FILE_PATH} to S3 ${S3_BUCKET_URL}"
	aws s3 cp "${BACKUP_FILE_PATH}" "${S3_BUCKET_URL}" --endpoint-url "${ENDPOINT_URL}"
fi

if [ -n "${KEEP_BACKUP_DAYS}" ]; then
	echo "Removing old backups. Only keeping backups created in the last ${KEEP_BACKUP_DAYS} days."
	find "${BACKUP_BASE_PATH}" -mtime "+${KEEP_BACKUP_DAYS}" -type f -delete;
else
	echo "NUMBER_OF_BACKUPS_TO_KEEP was not set. Not removing any old backups."
fi
