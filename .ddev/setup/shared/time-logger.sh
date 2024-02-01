#!/bin/bash

# Used to time how long tasks take to run.
# 1. Include this file when you want to start timing (usually at the top):
#    source "${PROJECT_ROOT}/.docksal/includes/time-logger.sh"
# 2. Output this code where you want to display the message:
#    displayTime "Init"

# Get the global file.
source ".ddev/setup/shared/global.sh"

# Set the start time.
START_TIME=`date +%s`

# Calculate and display the total time.
function displayTime {

  if [ "${2}" != "" ] ; then
    CUR_START=${2}
  else
    CUR_START=${START_TIME}
  fi

  local END_TIME=`date +%s`
  local T=$((${END_TIME}-${CUR_START}))
  local MESSAGE="${1} completed in"
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))

  printf "${BOLD_GREEN}\n"
  echo "-------------------------------------------------------------------"
  printf "| ${MESSAGE} "
  (( ${D} > 0 )) && printf '%d days ' ${D}
  (( ${H} > 0 )) && printf '%d hours ' ${H}
  (( ${M} > 0 )) && printf '%d minutes ' ${M}
  (( ${D} > 0 || ${H} > 0 || ${M} > 0 )) && printf 'and '
  printf "%d seconds!\n" ${S}
  echo "-------------------------------------------------------------------"
  printf "${DEFAULT_COLOR}\n"
}
