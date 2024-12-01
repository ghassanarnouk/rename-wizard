
#!/bin/bash

oper_chk() {
  # function to check the Return Code of an operation. if operation
  # fails, code!=0, then print an error message and exit the script.
  if [[ $1 -ne 0 ]]; then
    echo $2
    exit 1
  fi
}

usage="Usage: sh rw.sh /path/to/directory [-h|--help] [--examples] [-f <file_case>] [-d <dir_case>]"
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

# TODO INFO func to append the extra string in front of the message
opt_input_valid() {
  local case="$1"
  if [[ $case != "PascalCase" && $case != "camelCase" && $case != "snake_case" ]]; then
    # TODO print to console & log file
    # TODO add a time stamp and log stamp to the verbose messages: date, time, INFO, WARN, ERROR
    [ "$v" = "true" ] && echo "case: $case" >> rw.log
    echo "ERROR - invalid opt arg: $case"
    exit 1
  fi
}

dir_valid() {
  local dirPath="$1"
  if [[ ! -d "$dirPath" ]]; then
    # TODO print to console & log file
    # TODO add a time stamp and log stamp to the verbose messages: date, time, [INFO, WARN, ERROR]
    [ "$v" = "true" ] && echo "dir dirPath: $dirPath" >> rw.log
    echo "ERROR - directory not found!"
    echo ""
    exit 1
  fi
}
