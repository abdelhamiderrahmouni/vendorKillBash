#!/bin/bash

# Prompt the user for the path to search
echo "Enter the path to search for vendor directories:"
read search_path

# Find all vendor directories within the search path
vendor_dirs=$(find "$search_path" -type d -name "vendor" -maxdepth  2)

# List the vendor directories with their sizes and project names
echo "Found vendor directories:"
while IFS= read -r dir; do
    # Calculate the size of the directory
    size=$(du -sh "$dir" | cut -f1)
    
    # Extract the project name from the path
    project_name=$(basename "$(dirname "$dir")")
    
    # Print the project name, path, and size
    echo "Project: $project_name | Path: $dir | Size: $size"
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
