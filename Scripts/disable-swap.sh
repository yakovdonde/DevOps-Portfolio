# How to run this script?
# ./disable-swap.sh host1 host2 host3

#!/bin/bash

# Check if at least one host is provided as an argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 host1 [host2 ... hostN]"
    exit 1
fi

# Function to disable swap on a single host
disable_swap() {
    local host=$1

    echo "Disabling swap on $host..."

    # Disable swap
    ssh "$host" "sudo swapoff -a"

    # Comment out the swap entry in /etc/fstab
    ssh "$host" "sudo sed -i.bak '/swap/ s/^\(.*\)$/#\1/g' /etc/fstab"

    echo "Swap disabled on $host."
}

# Loop through all provided hosts and disable swap
for host in "$@"; do
    disable_swap "$host"
done

echo "Swap disabled on all provided hosts."
