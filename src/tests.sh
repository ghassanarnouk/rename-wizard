#!/bin/bash

sh rw.sh -h
sh rw.sh -help
sh rw.sh --help
sh rw.sh --examples
sh rw.sh -asdf          # negative test
sh rw.sh                # negative test

sh rw.sh /path/to/directory
sh rw.sh /path/to/directory -d PascalCase -f snake_case     # <------- default values
sh rw.sh /path/to/directory -d camelCase -f PascalCase
sh rw.sh /path/to/directory -d snake_case -f camelCase

sh rw.sh /path/to/directory -d snake_case -d asdf           # negative test
sh rw.sh /path/to/directory -f camelCase -f asdf            # negative test