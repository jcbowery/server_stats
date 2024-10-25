#!/bin/bash

# Get total CPU usage and display it
cpu_total=$(top -bn1 | grep "Cpu(s)" | awk '{printf "CPU: %.2f%%", $2 + $4}')
echo "$cpu_total"
echo ""

# Get memory usage and display it with percentages formatted to two decimal places
free --mega | grep Mem: | awk '{
    used_percent = (($2 - $7) / $2) * 100;
    free_percent = ($7 / $2) * 100;
    printf "Memory:\n\tPercent Used: %.2f%%\n\tPercent Free: %.2f%%\n\tUsed: %sMB\n\tFree: %sMB\n", used_percent, free_percent, $3, $4
}'
echo ""

# Get disk usage and display it with percentages formatted to two decimal places
df -h --total | grep total | awk '{print "Disk:\n" "\tPercentage Used: " $5 "\n\tFree: " $4 "\n\tUsed: " $3 "\n\tTotal: " $2 }'
echo ""

# Display top 5 processes by CPU usage in a table format
echo "Top 5 Processes by CPU:"
echo -e "\tUSER       PID    %CPU   COMMAND"
ps aux --sort=-%cpu | head -6 | awk 'NR>1 {printf "\t%-10s %-6s %-6s %s\n", $1, $2, $3, $11}'
echo ""

# Display top 5 processes by mem usage in a table format
echo "Top 5 Processes by MEM:"
echo -e "\tUSER       PID    %MEM   COMMAND"
ps aux --sort=-%mem | head -6 | awk 'NR>1 {printf "\t%-10s %-6s %-6s %s\n", $1, $2, $4, $11}'
echo ""
