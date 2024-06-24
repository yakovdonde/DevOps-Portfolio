# How to run this script?
# ./timezone-locale -t "America/New_York" -l "en_US.UTF-8" host1 host2 host3
# for Asia/Baku and en_GB.UTF-8 run ./timezone-locale.sh -t "Asia/Baku" -l "en_GB.UTF-8" host1 host2 host3

#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -t <timezone> -l <locale> <host1> <host2> ... <hostN>"
    exit 1
}

# Check if at least 4 arguments are passed (script name, -t, -l, and at least one host)
if [ "$#" -lt 4 ]; then
    usage
fi

# Parse command-line arguments
while getopts ":t:l:" opt; do
    case "${opt}" in
        t)
            TIMEZONE=${OPTARG}
            ;;
        l)
            LOCALE=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if TIMEZONE and LOCALE variables are set
if [ -z "${TIMEZONE}" ] || [ -z "${LOCALE}" ]; then
    usage
fi

# Remaining arguments are the hosts
HOSTS=("$@")

# Set timezone and locale on each host
for HOST in "${HOSTS[@]}"; do
    echo "Setting timezone and locale on host: ${HOST}"
    ssh "${HOST}" << EOF
        # Set the timezone
        sudo timedatectl set-timezone "${TIMEZONE}"

        # Set the locale
        sudo locale-gen "${LOCALE}"
        sudo update-locale LANG="${LOCALE}"

        # Verify settings
        echo "Timezone set to: \$(timedatectl | grep "Time zone")"
        echo "Locale set to: \$(locale | grep LANG)"
EOF
done

echo "Timezone and locale have been set on all specified hosts."
