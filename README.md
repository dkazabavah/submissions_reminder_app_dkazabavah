Submission Reminder App

This project helps check which students have not submitted their assignments.  
You can also change the assignment name to check a different one.

---

How to Run the App

Step 1: Setup the Environment

Run this command to create all folders and files:
./
./ create_environment.sh
You will be asked to enter your name.
A folder called submission_reminder_{YourName} will be created with all needed files.

Step 2: Check or Change Assignment
To check another assignment, run this command:
./ copilot_shell_script.sh
Enter the new assignment name when asked.
The program will update and show students who have not submitted it.


./ create_environment.sh
Enter your name: David
Environment created successfully!

cd submission_reminder_David
./startup.sh
Assignment: Shell Navigation
Days remaining to submit: 2
--------------------------------------------
Checking submissions in assets/submissions.txt
Reminder: Chinemerem has not submitted the Shell Navigation assignment!
Reminder: Divine has not submitted the Shell Navigation assignment!
Reminder: Yvonne has not submitted the Shell Navigation assignment!
Reminder: Stephen has not submitted the Shell Navigation assignment!

./copilot_shell_script.sh
Enter the assignment name: Git
Processing 'Git' assignment
Assignment updated successfully!

