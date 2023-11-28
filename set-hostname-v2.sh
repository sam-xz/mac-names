#!/bin/bash
# Samuel Marino 20/Nov/2023

# Get the most recent logged-in user
last_user=$(last -1 | awk '{print $1}')

# Extract staff user and set first/last name variables
if [[ $last_user =~ ^([^.]+)\.([^.]+)$ && $last_user != "it.admin" ]]; then
    firstname=${BASH_REMATCH[1]}
    lastname=${BASH_REMATCH[2]}
else
    echo "Last user is it.admin. Exiting."
    exit 1
fi

# Function to capitalize first letter
capitalize() {
    echo "$1" | awk '{print toupper(substr($0, 1, 1)) substr($0, 2)}'
}

# Capitalize first letter of firstname and lastname
firstname=$(capitalize "$firstname")
lastname=$(capitalize "$lastname")

# Extract Model
model=$(system_profiler SPHardwareDataType | awk -F': ' '/Model Name/ {print $2}')

# Sanitize hostname
sanitized_hostname=$(echo "$firstname$lastname-$model" | tr -cd '[:alnum:]-')

# Set name and model
sudo scutil --set ComputerName "$sanitized_hostname"
sudo scutil --set HostName "$sanitized_hostname"
sudo scutil --set LocalHostName "$sanitized_hostname"

hostname=$(hostname)
localhostname=$(scutil --get LocalHostName)
computername=$(networksetup -getcomputername)
echo Hostname = "$hostname"
echo LocalHostName = "$localhostname"
echo ComputerName = "$computername"