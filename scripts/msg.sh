#!/bin/bash

# prints a fatal error on stdout and exit the program.
#
# @param	string	the fatal error message.
# @param	number	the non-zero exit code.

function fatal_error() {
	echo -e "[\033[32mFATAL\033[0m] $1"
	echo -e "[FATAL] $1" >> $DT_PATH/$DEEPTHOUGHT
	finish_cleanup
	exit $2
}

# prints a warning on stdout.
#
# @param	string	the warning message.

function warn() {
	echo -e "[\033[34mWARNING\033[0m] $1"
}

function info() {
	echo -e "[\033[35mINFO\033[0m] $1"
}


function assert_test() {
	if [ $1 -eq 0 ]
	then
		test_passed=$((test_passed+1))
		printf "%-40s[\033[0;32mOK\033[0m]\n" $2
	else
		test_failed=$((test_failed+1))
		printf "%-40s[\033[0;31mKO\033[0m]\n" $2
	fi
}

function summary() {
	printf "\n----------[ \033[35mTEST SUMMARY\033[0m ]----------\n"
	printf "Tested: %d\n" $(($test_passed+$test_failed))
	printf "Passed: \033[32m%d\033[0m\n" $test_passed
	printf "Failed: \033[31m%d\033[0m\n" $test_failed
	printf "\nLogs and deepthought have been saved in the \033[0;34mout\033[0m directory.\n"
}
