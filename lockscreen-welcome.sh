#!/bin/bash

hostname=$(hostname)

sudo defaults write /Library/Preferences/com.apple.loginwindow \
         LoginwindowText "Welcome to 
$hostname"