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
