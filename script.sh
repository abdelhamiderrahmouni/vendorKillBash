#!/bin/bash

# Use the provided path or the current directory if none was provided
search_path="${1:-$PWD}"

# Find all vendor directories within the search path
vendor_dirs=$(find "$search_path" -maxdepth   2 -type d -name "vendor")

# Define colors for output
GREEN='\033[0;32m'
LIGHT_GRAY='\033[0;37m'
RESET='\033[0m'

# total size of vendor folders
total_size=0
while IFS= read -r dir; do
    size=$(du -sh "$dir" | cut -f1)
    total_size=$((total_size + $(du -s "$dir" | cut -f1)))
done <<< "$vendor_dirs"

# the sum of all vendor folders sizes in megabytes
total_size_in_mb=$(echo "scale=2; $total_size /  1024" | bc)

# Check if the size is greater than  1024 MB (1 GB)
if (( $(echo "$total_size_in_mb >  1024" | bc -l) )); then
    total_size_in_gb=$(echo "scale=2; $total_size_in_mb /  1024" | bc)
    total_size_unit="G"
else
    total_size_unit="M"
fi

# List the vendor directories with their sizes and project names
printf "\nFound %s vendor directories: %s%s \n" $(echo "$vendor_dirs" | wc -l) "$total_size_in_gb" "$total_size_unit"
echo "--------------------------------------------------------------------------------"
echo ""

counter=1
while IFS= read -r dir; do
    size=$(du -sh "$dir" | cut -f1)
    project_name=$(basename "$(dirname "$dir")")
    printf "${GREEN}%s: %-40s Size: %s${RESET}\n" "$counter" "$project_name" "$size"
    echo "Path: $dir"
    echo "--------------------------------------------------------------------------------"
    echo ""
    ((counter++))
done <<< "$vendor_dirs"

# List the vendor directories with their sizes and project names
printf "\nFound %s vendor directories: %s%s \n" $(echo "$vendor_dirs" | wc -l) "$total_size_in_gb" "$total_size_unit"
echo "--------------------------------------------------------------------------------"
echo ""

# Prompt the user to select directories to delete
echo "Enter the numbers of the directories to delete, separated by spaces:"
read -a delete_numbers

# Delete the selected directories
for num in "${delete_numbers[@]}"; do
    dir_to_delete=$(echo "$vendor_dirs" | sed -n "${num}p")
    rm -rf "$dir_to_delete"
    echo "Deleted $dir_to_delete"
done
