#!/bin/bash

# Measure - logs system performance data from user accounts and processes; ties PID to actual applications all into organized columns in a detailed UTF-8 compliant csv file saved by time date stamp to /Users/shared/

# Set the date and time format for the filename
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Set the output CSV file path
output_file="/Users/Shared/system_performance_log_${timestamp}.csv"

# Write the CSV header
echo "Timestamp,User,UID,PID,ProcessName,CPUPercentage,MemPercentage,MemUsage" > "$output_file"

# Get the list of processes with performance data
ps -eo pid,user,uid,pcpu,pmem,rsz,comm -c | awk 'NR>1' | while read -r line
do
    # Get process data from the line
    pid=$(echo "$line" | awk '{print $1}')
    user=$(echo "$line" | awk '{print $2}')
    uid=$(echo "$line" | awk '{print $3}')
    pcpu=$(echo "$line" | awk '{print $4}')
    pmem=$(echo "$line" | awk '{print $5}')
    mem_usage=$(echo "$line" | awk '{print $6}')
    process_name=$(echo "$line" | awk '{print $7}')

    # Get the current timestamp
    current_timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Write the data to the CSV file
    echo "${current_timestamp},${user},${uid},${pid},${process_name},${pcpu},${pmem},${mem_usage}" >> "$output_file"
done
