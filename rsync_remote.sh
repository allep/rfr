#!/bin/bash
#
# 2019-12-16: scripts created after some changes applied to this skeleton:
# https://superuser.com/questions/297342/rsync-files-newer-than-1-week/297343
# Note: it rsyncs files from REMOTE target dir into local dir. So you need to
# call this script from the dir where you want to put files into.
#
# 2020-08-17: added -P option to rsync to show the progress bar during the
# transfer.
#

#------------------------------------------------------
# inputs
PROGRAM=$0
TIME=$1
DRYRUN=$2

# variables
cur_dir=

#------------------------------------------------------

#------------------------------------------------------
# constants
USER="remote-user"
# it MUST be a path (i.e., starting from the root dir)
DIRECTORY="/path/to/remote/directory/"
HOST="remote-host"
#------------------------------------------------------

#------------------------------------------------------
# Functions
#------------------------------------------------------
function usage()
{
  echo "Usage:"
  echo "$0 tdays [dry]"
  echo
  echo "rsyncs remote files newer than 'tdays' in the current directiory."
  echo "- Remote directory to be rsynced: defined inside the script."
  echo "- Remote host and credentials: defined inside the script."
}

#------------------------------------------------------
function print_params()
{
  echo "Rsync: $USER@$HOST:$DIRECTORY into $cur_dir".
  echo
}

#------------------------------------------------------
# Actual script
#------------------------------------------------------
if [[ -z $TIME ]]; then
  echo "Error: no time argument."
  echo

  usage

  exit 1
fi

if [[ $DRYRUN = "dry" ]]; then
  DRYRUNCMD="--dry-run"
  echo "Dry run initiated..."
fi

cur_dir=$(pwd)

print_params

rsync -avzP $DRYRUNCMD --no-relative --files-from=<(ssh \
    $USER@$HOST "find $DIRECTORY \
    -mtime -$TIME -type f \
    -exec ls $(basename {}) \;") \
    $USER@$HOST:/ .
