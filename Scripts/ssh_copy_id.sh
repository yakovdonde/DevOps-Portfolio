# How to run this script?
# ./ssh_copy_id.sh -p your_ssh_password host1 host2 host3

#!/bin/bash

# Check if sshpass is installed
if ! command -v sshpass &> /dev/null; then
    echo "sshpass is not installed. Please install it first."
    exit 1
fi

# Usage message
usage() {
    echo "Usage: $0 [-p password] host1 host2 ... hostN"
    echo "  -p password   Provide password for sshpass"
    echo "  host1 host2 ... hostN   List of hosts to set up passwordless SSH"
    exit 1
}

# Parse options
while getopts ":p:" opt; do
    case ${opt} in
        p)
            password="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Ensure hosts are provided
if [ $# -eq 0 ]; then
    echo "Error: No hosts specified."
    usage
fi

# Set up passwordless SSH for each host
for host in "$@"; do
    echo "Setting up passwordless SSH for $host..."

    # Use sshpass to copy SSH key to remote host
    if [ -n "$password" ]; then
        sshpass -p "$password" ssh-copy-id -o StrictHostKeyChecking=no "$host"
    else
        ssh-copy-id -o StrictHostKeyChecking=no "$host"
    fi

    # Check if passwordless SSH works
    if ssh -o BatchMode=yes "$host" true; then
        echo "Passwordless SSH set up successfully for $host."
    else
        echo "Failed to set up passwordless SSH for $host."
    fi
done
