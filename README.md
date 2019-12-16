# rsync_remote.sh

rsync_remote.sh is a very simple script originated from the skeleton found on:

https://superuser.com/questions/297342/rsync-files-newer-than-1-week/297343

It uses rsync to synchronize files newer that X days from a remote server via
ssh to the local directory.
It must be run from the directory where you would like to rsync files to.

Some notes:

- Remote directory to be rsynced: defined inside the script.
- Remote host and credentials: defined inside the script.
