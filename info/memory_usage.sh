#!/bin/bash

# Get total and available memory
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEM_AVAILABLE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

# Calculate used memory
MEM_USED=$((MEM_TOTAL - MEM_AVAILABLE))

# Calculate percentage of used memory
MEM_USED_PERCENT=$((MEM_USED * 100 / MEM_TOTAL))

# Output the result
echo "Memory: ${MEM_USED_PERCENT}%"
