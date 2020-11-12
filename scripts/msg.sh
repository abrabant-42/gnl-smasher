#!/bin/bash

function display_help() {
	printf "\ngnl-smasher \033[0;32m$VERSION\033[0m by \033[0;34m$AUTHORS\033[0m\n\n"
	printf "Usage: smasher <command> [options]\n\n"
	printf '\033[0;34m%-15s \033[0mDisplay this help menu.\n' "help"
	printf '\033[0;34m%-15s \033[0mPurge the deepthought directory.\n' "purge"
	printf '\033[0;34m%-15s \033[0mOnly display the version of gnl-smasher.\n' "version"
	printf '\033[0;34m%-15s \033[0mRun the tests\n' "run"
	printf '%15s %-20s run the bonus test (will expect _bonus.c files).\n' "" "--bonus"
	printf '%15s %-20s Remove the temporary generated files (.diff, .ref, .testout)\n' "" "--nolog"
	printf '%15s %-20s Change the name of the deepthought file.\n' "" "--dt-name=n"
	printf '%15s %-20s Change the path of the deepthought file.\n' "" "--dt-path=p"
	printf '%15s %-20s Specify a custom BUFFER_SIZE (default is 32).\n' ""  "--bfz=n"
	printf '%15s %-20s No deepthought will be generated.\n' ""  "--nodt"
	printf '%15s %-20s Check leaks using valgrind (if available)\n' ""  "--valcheck"
}

# prints a fatal error on stdout and exit the program.
#
# @param	string	the fatal error message.
# @param	number	the non-zero exit code.

function fatal_error() {
	echo -e "[\033[31mFATAL\033[0m] $1"
	[ $NODT == "no" ] && [ -d $DT_PATH ] && echo -e "[FATAL] $1" >> $DT_PATH/$DEEPTHOUGHT
	finish_cleanup
	exit $2
}

# prints a warning on stdout.
#
# @param	string	the warning message.

function warn() {
	echo -e "[\033[33mWARNING\033[0m] $1"
}

function info() {
	echo -e "[\033[35mINFO\033[0m] $1"
}

# Find out if test passes or fails and print a message accordingly.
#
# @param	number	the exit code of the diff
# @param	string	the test name

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
}
