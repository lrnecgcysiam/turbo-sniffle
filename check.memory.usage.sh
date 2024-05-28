#!/bin/bash

# Run the 'top' command and use 'grep' to extract the memory usage information
memory_info=$(top -l 1 | grep PhysMem)

# Print the memory information
echo "Memory Usage:"
echo "$memory_info"