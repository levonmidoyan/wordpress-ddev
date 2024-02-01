#!/bin/bash

######
# Color Variables
######
DEFAULT_COLOR="\033[0;0m"
GREEN="\033[0;32m"
RED="\033[0;31m"
BOLD_WHITE="\033[1;37m"
BOLD_GREEN="\033[1;32m"
BOLD_READ="\033[1;31m"

######
# Functions
######

# Display a starting message.
function startMessage {
  printf "${BOLD_GREEN}\n-------------------------------------------------------------------\n| %s\n-------------------------------------------------------------------${DEFAULT_COLOR}\n" "${1}"
}

# Display a progress message.
function progressMessage {
  printf "\n${BOLD_WHITE}%s${DEFAULT_COLOR}\n" "${1}"
}

# Display a success message.
function successMessage {
  printf "\n${GREEN}%s${DEFAULT_COLOR}\n" "${1}"
}

# Display an error message.
function faileMessage {
  printf "\n${BOLD_READ}%s${DEFAULT_COLOR}\n\n" "${1}"
  exit
}
