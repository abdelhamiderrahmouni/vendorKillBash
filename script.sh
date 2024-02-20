#!/bin/bash

# Prompt the user for the path to search
echo "Enter the path to search for vendor directories:"
read search_path

# Find all vendor directories within the search path
vendor_dirs=$(find "$search_path" -type d -name "vendor")

# List the vendor directories
echo "Found vendor directories:"
echo "$vendor_dirs"

# Prompt the user to select directories to delete
echo "Enter the numbers of the directories to delete, separated by spaces:"
read -a delete_numbers

# Delete the selected directories
for num in "${delete_numbers[@]}"; do
    dir_to_delete=$(echo "$vendor_dirs" | sed "${num}q;d")
    rm -rf "$dir_to_delete"
    echo "Deleted $dir_to_delete"
done
