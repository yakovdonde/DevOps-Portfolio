# How to run this script?
# ./passwordless-sudo.sh host1 host2 host3

#!/bin/bash

# Check if at least one host is provided as an argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 host1 [host2 ... hostN]"
    exit 1
fi

# Commands to be run on each host
commands='sudo echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER'

# Iterate over each provided host
for host in "$@"; do
    echo "Running commands on $host"
    ssh "$host" "$commands"
done
