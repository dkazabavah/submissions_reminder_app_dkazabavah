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
