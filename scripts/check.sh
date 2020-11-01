#!/bin/bash

# check whether or not the path exists and contains the GNL expected sources.
#
# @param	string	the specified path.

function is_gnl_path_correct() {
	if [ ! -d "$1" ]
	then
		fatal_error "Could not use gnl_path: path \"$1\" doesn't exist" $EXIT_INVALID_PATH
	fi
	if [ ! -f $1/get_next_line.c ] || [ ! -f $1/get_next_line_utils.c ] || [ ! -f $1/get_next_line.h ]
	then
		fatal_error "Could not use gnl_path: path exists, but could not found all the required source files." $EXIT_INVALID_PATH
	fi
}
