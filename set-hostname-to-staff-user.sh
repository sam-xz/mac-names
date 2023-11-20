#!/bin/bash
# Samuel Marino 20/Nov/2023

# Get List of users
users=$(dscl . -list /Users | grep -v '^_')

# Extract staff user and set first/last name variables
for user in $users; do
    if [[ $user =~ ^([^.]+)\.([^.]+)$ && $user != "it.admin" ]]; then
        firstname=${BASH_REMATCH[1]}
        lastname=${BASH_REMATCH[2]}
        break
    fi
done

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
sudo scutil --set ComputerName "$firstname $lastname $model"
sudo scutil --set HostName "$sanitized_hostname"
sudo scutil --set LocalHostName "$sanitized_hostname"