#!/bin/bash

main_folder="task_alert_*/"
launcher="startup.sh"
settings_file="./task_alert_*/settings/settings.env"
proceed="y"
task_title="" # Initialize variable to store user input

assistant_tool() {
    # The task title is passed as the first argument
    task="$1"

    if [ ! -d $main_folder ]; then
        sleep 0.9
        echo "The folder does not exist. Please run setup_environment.sh first."
        echo " "
        exit 1
    else
        sed -i "s/ASSIGNMENT=\".*\"/ASSIGNMENT=\"$task_title\"/" $settings_file

        echo "Processing '$task' task"

        cd $main_folder
        if [ ! -f $launcher ]; then
            echo "Error: $launcher not found."
            exit 1
        else
            ./$launcher
            cd ..
        fi
    fi
}

while [[ "$proceed" == "y" || "$proceed" == "Y" ]]; do
    echo " "
    echo "Which task would you like to check?"
    echo "Example options:
Shell Navigation
Shell Basics
Git"

    # Read user input directly into task_title
    read -p "Enter the task title: " task_title

    # Call the function, passing the task title
    assistant_tool "$task_title"

    echo " "
    read -p "Do you want to analyze another task (y/n): " proceed
done

echo -e "Exiting"

