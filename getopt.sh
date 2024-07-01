#!/bin/bash
# set -x  # enable debugging
v="false"
usage="Usage: sh rw.sh [-h|--help] [--examples] [-f <file_case>] [-d <dir_case>]"
dirCase="PascalCase"
fileCase="snake_case"
# TODO add utility functions to util.sh & source it in this file
oper_chk(){
  # function to check the Return Code of an operation. if operation
  # fails, code!=0, then print an error message and exit the script.
  if [[ $1 -ne 0 ]]; then
    echo $2
    exit 1
  fi
}
opt_input_valid(case) {
  if [[ $case != "PascalCase" && $case != "camelCase" && $case != "snake_case" ]]; then
    # TODO print to console & log file
    # TODO add a time stamp and log stamp to the verbose messages: date, time, INFO, WARN, ERROR
    [ "$v" = "true" ] && echo "case: $case" >> rw.log
    echo "ERROR - invalid opt arg: $case"
    exit 1
  fi
}
dir_valid(path){
  if [[ ! -d "$path" ]]; then
    # TODO print to console & log file
    # TODO add a time stamp and log stamp to the verbose messages: date, time, [INFO, WARN, ERROR]
    [ "$v" = "true" ] && echo "dir path: $dirPath" >> rw.log
    echo "ERROR - directory not found!"
    echo ""
    exit 1
  fi
}
# TODO add a verbose (v) falg to help/usage menu
# TODO add a time stamp and log stamp to the verbose messages: date, time, INFO, WARN, ERROR
usage() {
  # function to print the usage of the script
  echo "renameWizard:"
  echo "              Eliminates whitespace from file and directory names, renaming directories in PascalCase and files in snake_case"
  echo "              $usage"
  echo ""
  exit 0
}
[ "$v" = "true" ] && echo "num of args: $#" >> rw.log
if [ $# -eq 1 ]; then
  [ "$v" = "true" ] && echo "arg1: $1" >> rw.log
  if [ $1 = "-h" -o $1 = "--help" -o $1 = "-help" ]; then
    usage
    echo ""
    exit 0
  elif [ $1 = "--examples" ]; then
    echo "Examples:"
    echo "          sh rw.sh --help"
    echo "          sh rw.sh /path/to/directory -d camelCase"
    echo "          sh rw.sh /path/to/directory -f PascalCase -d snake_case"
    echo ""
    exit 0
  else
    echo $usage
    echo ""
    exit 1
  fi
elif [ $# -eq 2 ]; then
  [ "$v" = "true" ] && echo "arg1: $1" && echo "arg2: $2" >> rw.log
  if [ $1 = "-f" ]; then
    fileCase=$2
    opt_input_valid "$fileCase"
  elif [ $1 = "-d" ]; then
    dirCase=$2
    opt_input_valid "$dirCase"
  else
    echo $usage
    echo ""
    exit 1
  fi
elif [ $# -eq 4 ]; then
  [ "$v" = "true" ] && echo "arg1: $1" && echo "arg2: $2" && echo "arg3: $3" && echo "arg4: $4" >> rw.log
  if [ $1 = "-f" -a $3 = "-d" ]; then
    fileCase=$2
    dirCase=$4
    opt_input_valid "$fileCase"
    opt_input_valid "$dirCase"
  elif [ $1 = "-d" -a $3 = "-f" ]; then
    fileCase=$4
    dirCase=$2
    opt_input_valid "$fileCase"
    opt_input_valid "$dirCase"
  else
    echo $usage
    echo ""
    exit 1
  fi
else
  echo $usage
  echo ""
  exit 1
fi
read -p "please specify the directory path: " dirPath
[ "$v" = "true" ] && echo "file case: $fileCase" >> rw.log
# find "$dirPath" -depth -type d -print0 | while IFS= read -r -d '' dir; do
#   parentDir=$(dirname "$dir")
#   baseName=$(basename "$dir")
#   newDirName=$(echo "$baseName" | tr -d ' ')
#   if [[ "$baseName" != "$newDirName" ]]; then
#     mv "$dir" "$parentDir/$newDirName"
#     echo "Removed spaces from:$dir"
#   fi
#   # TODO: add a return code variable (rc) with a value.
# done
# # TODO: add a condition to print another message if no spaces were removed. If rc = VALUE, then print the message below. Otherwise, print nothing happened
