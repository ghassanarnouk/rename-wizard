#!/bin/bash

operationCheck(){
  # function to check the Return Code of an operation. if operation
  # fails, code!=0, then print an error message and exit the script.
  if [[ $1 -ne 0 ]]; then
    echo $2
    exit 1
  fi
}
usage() {
  # function to print the usage of the script
  echo "renameWizard:"
  echo "              Eliminates whitespace from file and directory names, renaming directories in PascalCase and files in snake_case"
  echo "              $usage"
  echo ""
  exit 0
}
usage="Usage: sh getopt.sh path [-h] [-f <file_case>] [-d <dir_case>]"
if [ $# -eq 0 ]; then
  # if no arguments are provided, print the usage and exit the script
  echo $usage
  echo ""
  exit 1
elif [ $# -eq 1 ]; then
  if [ $1 = "-h" -o $1 = "--help" ]; then
    # if the only argument is -h or --help, print the usage and exit the script
    usage
    echo ""
    exit 0
  elif [ ! -d $1 ]; then
    # if the path provided is not a directory, print an error message & usage and exit the script
    echo "ERROR - path provided is not a directory"
    echo $usage
    echo ""
    exit 1
  fi
fi
while getopts ":f:d:" opt; do
  echo "opt: $opt"
  echo "OPTARG: $OPTARG"
  case $opt in
    f)
      echo "Option -f passed with argument $OPTARG"
      ;;
    d)
      echo "Option -d passed with argument $OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done