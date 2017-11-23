#!/usr/bin/env bash
#
# Start ssh-agent if it is not running (by becoming it)
# Intended for use on Bash for Windows using the WSL
#
# Author: Dave Eddy <dave@daveeddy.com>
# Date: October 09, 2017
# License: MIT

# Could be any file - nothing intrinsically valuable about ~/.ssh/environment
envfile=~/.ssh/environment

# Ensure the environment file exists and has its permissions properly set.
# Source the file - if it was created by this script the source will
# effectively be a noop.
mkdir -p "${envfile%/*}"
touch "$envfile"
chmod 777 "$envfile"
. "$envfile"

# Check if the daemon is already running
if [[ -n $SSH_AGENT_PID ]] && kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
    # The PID is up but it could have been recycled - attempt to list keys.
    # This will exit with 2 if the SSH_AUTH_SOCK is broken.
    ssh-add -l &>/dev/null
    if (($? != 2)); then
        echo "SSH-Agent alreading running: $SSH_AGENT_PID"
        exit 1
    fi
fi

# Overwrite what is in the envfile to start a fresh ssh-agent instance
echo "# Started $(date)" > "$envfile"

# For some reason, this line doesn't get emitted by ssh-agent when it is run
# with -d or -D.  Since we are starting the program with exec we already know
# the pid ahead of time though so we can create this line manually
echo "SSH_AGENT_PID=$$; export SSH_AGENT_PID" >> "$envfile"

# we add all our private keys. sleep allows this line to be the last of the file.
(sleep 2 && echo 'ssh-add -l > /dev/null || ssh-add ~/.ssh/id_!(*.pub)' >> "$envfile")&
# we remove the 'Agent Pid' message
(sleep 2 && sed -i 's/^echo/# echo/' "$envfile")&

# Become ssh-agent and run forever
exec ssh-agent -D >> "$envfile"
