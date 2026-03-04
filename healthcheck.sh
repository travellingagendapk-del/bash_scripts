

#!/bin/bash

LOGFILE="/home/ubuntu/health_report.log"

TIME_STAMP=$(date "+%Y-%m-%d %H:%M:%S")
CPU_LOAD=$(cat /proc/loadavg | awk '{ print $1 }')
MEM_USAGE=$(free -m | awk '/Mem:/ { print $3 "MB used / " $2 " MB total" }')
DISK_USAGE=$(df -h / | awk 'NR==2 { print $5 }')

if systemctl is-active --quiet ssh; then
    SSH_STATUS="Running"
else
    SSH_STATUS="Stopped"
fi

{
    echo "Date: $TIME_STAMP"
    echo "CPU LOAD: $CPU_LOAD"
    echo "Memory Usage: $MEM_USAGE"
    echo "Disk Usage: $DISK_USAGE"
    echo "SSH Service: $SSH_STATUS"
    echo "-----------------------------"
} >> "$LOGFILE"

echo "Health report generated in $LOGFILE"
