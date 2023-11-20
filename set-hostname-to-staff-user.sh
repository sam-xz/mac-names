#!/bin/bash
# Samuel Marino 20/Nov/2023

#Get List of users
users=$(dscl . -list /Users | grep -v '^_')

#Extract staff user and set first/last name variables
for user in $users; do
    if [[ $user =~ ^([^.]+)\.([^.]+)$ && $user != "it.admin" ]]; then
        firstname=${BASH_REMATCH[1]}
        lastname=${BASH_REMATCH[2]}
        break
    fi
done

#Extract Model
model=$(system_profiler SPHardwareDataType | awk -F': ' '/Model Name/ {print $2}')

#Set name and model
scutil --set ComputerName "$firstname.$lastname's $model"
scutil --set HostName "$firstname.$lastname's $model"
scutil --set LocalHostName "$firstname.$lastname's $model"