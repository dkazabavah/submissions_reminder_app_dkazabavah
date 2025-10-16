#!/usr/bin/bash

# When executed, the script will ask for the user's name and generate a folder named task_alert_{username}, replacing {username} with the input.

read -p "Enter your name: " username
# Create the main directory task_alert_{username} along with necessary subdirectories

main_dir="task_alert_${username}"
mkdir -p "$main_dir"

# Create subfolders
mkdir -p "$main_dir/source"
mkdir -p "$main_dir/helpers"
mkdir -p "$main_dir/resources"
mkdir -p "$main_dir/settings"

# Assign folder paths to variables
source_dir="$main_dir/source"
helpers_dir="$main_dir/helpers"
resources_dir="$main_dir/resources"
settings_dir="$main_dir/settings"

# Create settings.env and its contents
cat > "$settings_dir/settings.env" << 'EOF'
# Configuration file
ASSIGNMENT="Shell Navigation"
DAYS_LEFT=2
EOF

# Create notify.sh and its contents
cat > "$source_dir/notify.sh" << 'EOF'
#!/bin/bash

# Load configuration and helper functions
source ./settings/settings.env
source ./helpers/functions.sh

# Submissions file path
submissions_file="$(dirname "$0")/../resources/submissions.txt"

# Display assignment info and check submissions
echo "Assignment: $ASSIGNMENT"
echo "Days left to submit: $DAYS_LEFT days"
echo "-----------------------------------"

check_submissions $submissions_file
EOF

# Create functions.sh and its contents
cat > "$helpers_dir/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and alert for missing submissions
function check_submissions {
    local submissions_file=$1
    echo "Verifying submissions in $submissions_file"

    # Skip header and iterate through lines
    while IFS=, read -r student assignment status; do
        # Trim whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Alert if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Alert: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
EOF

# Create submissions.txt and its contents
cat > "$resources_dir/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Mwiti, Git, submitted
Musando, Git, not submitted
Yvonne, Shell Navigation, not submitted
Antoinne, Shell Basics, submitted
Stephen, Shell Navigation, not submitted
Michael, Git, not submitted
Richard, Shell Basics, submitted
EOF

# Create startup.sh for launching the app
cat > "$main_dir/startup.sh" << 'EOF'
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

EOF

# Set execution permissions for .sh files
chmod +x $source_dir/*
chmod +x $helpers_dir/*
cd $main_dir
chmod +x startup.sh
cd ..

echo "Environment created successfully!"
echo "To test the app, run:"
echo "cd $main_dir && ./startup.sh"

