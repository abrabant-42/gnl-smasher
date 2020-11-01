#!/bin/bash

# Compile get_next_line.o and get_next_line_utils.o

CC=gcc
CLFAGS='-Werror -Wextra -Wall'

# Compile the project object files.
#
# @param	string	the verified gnl path.
# @param	number	the BUFFER_SIZE to use.


function compile_proj_objs() {
	rm -rf ./obj/get_next_line.o ./obj/get_next_line_utils.o
	mkdir .obj 2> /dev/null

	${CC} ${CFLAGS} -D BUFFER_SIZE=$2 $1/get_next_line.c -c -o .obj/get_next_line.o
	${CC} ${CFLAGS} -D BUFFER_SIZE=$2 $1/get_next_line_utils.c -c -o .obj/get_next_line_utils.o

	[ ! -f ./.obj/get_next_line.o ] || [ ! -f ./.obj/get_next_line_utils.o ] && fatal_error "Could not compile YOUR project!" $EXIT_COMPILATION_ERROR
}

# Compile the test binary with the passed source.
#
# @param	string	=> source path

function comp_test() {
	${CC} ${CFLAGS} ./.obj/get_next_line.o ./.obj/get_next_line_utils.o $1 -o testbin.out
	[ $? -ne 0 ] && fatal_error "Could not compile the test binary." $EXIT_COMPILATION_ERROR
}
