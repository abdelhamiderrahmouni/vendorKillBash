#!/bin/bash

# Prompt the user for the path to search
echo "Enter the path to search for vendor directories:"
read search_path

# Find all vendor directories within the search path
vendor_dirs=$(find "$search_path" -type d -name "vendor" -maxdepth  2)

# Define colors for output
GREEN='\033[0;32m'
LIGHT_GRAY='\033[0;37m'
RESET='\033[0m'

# List the vendor directories with their sizes and project names
echo "Found vendor directories:"
while IFS= read -r dir; do
    size=$(du -sh "$dir" | cut -f1)
    project_name=$(basename "$(dirname "$dir")")
    echo -e "${GREEN}${project_name} ${GREEN}size: ${size}${RESET}"
    echo -e "${LIGHT_GRAY}Path: ${dir}${RESET}"
    echo ""
done <<< "$vendor_dirs"

# Prompt the user to select directories to delete
echo "Enter the numbers of the directories to delete, separated by spaces:"
read -a delete_numbers

# Delete the selected directories
for num in "${delete_numbers[@]}"; do
    dir_to_delete=$(echo "$vendor_dirs" | sed -n "${num}p")
    rm -rf "$dir_to_delete"
    echo "Deleted $dir_to_delete"
done
