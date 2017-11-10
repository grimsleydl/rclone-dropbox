#!/bin/bash
COMPUTER_NAME=$(hostname -s)
USER_NAME=$(whoami)
# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
# SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_PATH="${1}"
DESTINATION_PATH="dropbox:backups/${COMPUTER_NAME}/${USER_NAME}"
ARCHIVE_DESTINATION_PATH="dropbox:backups/${COMPUTER_NAME}/${USER_NAME}_archive"
rclone sync $SOURCE_PATH $DESTINATION_PATH \
       --backup-dir $ARCHIVE_DESTINATION_PATH \
       --exclude-from $SCRIPT_DIR/exclude.txt \
       --delete-excluded \
       -v \
       --bwlimit 700 \
       `# --stats 3m` \
       `# --stats-log-level NOTICE` \
       `# --dry-run`
