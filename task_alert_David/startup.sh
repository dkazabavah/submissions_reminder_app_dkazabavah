#!/bin/bash

# Absolute path of the script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to notify.sh
notify_script="$script_dir/source/notify.sh"

# Check if settings file exists
if [ ! -f "$script_dir/settings/settings.env" ]; then
    echo "Error: settings.env not found. Run this script from $script_dir"
    exit 1
fi

# Run the notification script
bash "$notify_script"

