#!/bin/bash

function exitError() {
  echo $1
  exit
}

function debugDump() {
  echo "MARCO_PATH Set to $MARCO_PATH"
  echo "BRO_PATH Set to $BRO_PATH"
  echo "PCAPITATE_PATH Set to $PCAPITATE_PATH"
  echo "LOG_PATH Set to $LOG_PATH"
  echo "PCAP_WINDOW Set to $PCAP_WINDOW"
  echo "TEMP_PATH Set to $TEMP_PATH"
  echo "RESULT_PATH Set to $RESULT_PATH"
}
 
MARCO_PATH=$(cat ./brolo.conf | grep "MARCO_PATH" | cut -d "=" -f 2)
BRO_PATH=$(cat ./brolo.conf | grep "BRO_PATH" | cut -d "=" -f 2)
PCAPITATE_PATH=$(cat ./brolo.conf | grep "PCAPITATE_PATH" | cut -d "=" -f 2)
LOG_PATH=$(cat ./brolo.conf | grep "LOG_PATH" | cut -d "=" -f 2)
PCAP_WINDOW=$(cat ./brolo.conf | grep "PCAP_WINDOW" | cut -d "=" -f 2)
TEMP_PATH=$(cat ./brolo.conf | grep "TEMP_PATH" | cut -d "=" -f 2)
RESULT_PATH=$(cat ./brolo.conf | grep "RESULT_PATH" | cut -d "=" -f 2)
 
if [ -z MARCO_PATH ]; then
  if [ -z $(ls ./ | grep "marco") ]; then
    exitError "ERROR: No marco path specified and marco not found. Check path in brolo.conf"
  else
    MARCO_PATH="./"
  fi
fi

if [ -z $BRO_PATH ]; then
  exitError "ERROR: No Bro path specified. Check path in brolo.conf"
fi

if [ -z $PCAPITATE_PATH ]; then
  exitError "ERROR: No Pcapitate Path specified. Check path in brolo.conf"
elif [ -z $(ls $PCAPITATE_PATH | grep pcapitate) ]; then
  exitError "ERROR: Pcapitate.sh not found. Verify proper path in brolo.conf"
fi

if [ -z $LOG_PATH ]; then
  $LOG_PATH="./"
fi

if [ -z PCAP_WINDOW ]; then
  PCAP_WINDOW=240
fi

if [ -z $TEMP_PATH ]; then
  TEMP_PATH="/tmp/"
fi

if [ -z $RESULT_PATH ]; then
  if [ -z $(ls ../ | grep "investigations" ]; then
    exitError "No result path specified. Check path in brolo.conf"
  fi
fi

function initQ() {
  echo "place holder"
}

function getTime() {
  currentTime=$(date +%s)
  ((startTime=$currentTime - 3600))
  startHour=$(date -d @${startTime} +%H)
  endHour=$(date -d @${currentTime} +%H)
}

function getDate() {
  logDate=$(date +%s)
  ((previousHourDate=$logDate - 3600))
  logDate-$(date -d @${previousHourDate} +"%Y-%m-%d")
}

function makePath() {
  currentTarget=$BRO_PATH
  getDate
  currentTarget="${currentTarget}${logDate}/"
  getTime
  currentTarget="${currentTarget}${startHour}:00:00-${endHour}:00:00.log.gz"
}

makePath

exit
