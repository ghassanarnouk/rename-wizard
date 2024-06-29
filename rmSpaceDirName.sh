#!/bin/bash

#
#
#
#
#
#
# specify the directory path
echo "Please specify the directory path:"
read dirPath

# check if the directory path is valid
if [[ ! -d "$dirPath" ]]; then
  echo "ERROR: directory not found!"
  exit 1
fi

# Use find to get a list of directories and subdirectories

# It starts modifying the subdirectories first
find "$dirPath" -depth -type d -print0 | while IFS= read -r -d '' dir; do
  # Extract the parent directory and directory name
  parentDir=$(dirname "$dir")
  baseName=$(basename "$dir")

  # Remove spaces from the directory name
  new_dir_name=$(echo "$baseName" | tr -d ' ')

  # Check if the name needs to be changed
  if [[ "$baseName" != "$new_dir_name" ]]; then
    # Rename the directory
    mv "$dir" "$parentDir/$new_dir_name"
    echo "Removed spaces from:$dir"
  fi
  # TODO: add a return code variable (rc) with a value.
done

# TODO: add a condition to print another message if no spaces were removed. If rc = VALUE, then print the message below. Otherwise, print nothing happened
echo "Spaces removed from directory names in $dirPath and its subdirectories."
