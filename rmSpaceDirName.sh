#!/bin/bash

# Specify the directory path
echo "Please specify the directory path:"
read dir_path

# Check if the directory path is valid
if [[ ! -d "$dir_path" ]]; then
  echo "ERROR: directory not found!"
  exit 1
fi

# Use find to get a list of directories and subdirectories
# It starts modifying the subdirectories first
find "$dir_path" -depth -type d -print0 | while IFS= read -r -d '' dir; do
  # Extract the parent directory and directory name
  parent_dir=$(dirname "$dir")
  base_name=$(basename "$dir")

  # Remove spaces from the directory name
  new_dir_name=$(echo "$base_name" | tr -d ' ')

  # Check if the name needs to be changed
  if [[ "$base_name" != "$new_dir_name" ]]; then
    # Rename the directory
    mv "$dir" "$parent_dir/$new_dir_name"
    echo "Removed spaces from:$dir"
  fi
done

# TODO: add a condition to print another message if no spaces were removed
echo "Spaces removed from directory names in $dir_path and its subdirectories."
