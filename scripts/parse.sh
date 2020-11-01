#!/bin/bash

DEEPTHOUGHT="deepthought-$(date +%s)"
DT_PATH="./out/deepthought"
NODT="no"
BUFFER_SIZE=32
RUN="no"

# Parse the command line arguments

[ $# -eq 0 ] && display_help && exit 0

while [ $# -gt 0 ]
do
	key=$1
	case $key in
		purge)
			rm -rf ./out/deepthought/*
			info "Purged \033[0;35m./out/deepthoughts\033[0m"
			exit 0
			shift
			;;
		run)
			shift
			RUN="yes"
			;;
		help)
			display_help
			exit 0
			;;
		version)
			printf "gnl-smasher version \033[0;35m$VERSION\033[0m\n"
			exit 0
			;;
		--dt-name=*|--deepthought-name=*)
			DEEPTHOUGHT=$(echo $1 | cut -d= -f2)
			info "deepthought name set to \033[0;34m$DEEPTHOUGHT\033[0m."
			shift
			;;
		--dt-path=*|deepthought-path=*)
			DT_PATH=$(echo $1 | cut -d= -f2)
			info "deepthought path set to \033[0;34m$DT_PATH\033[0m."
			shift
			;;
		--nodt|--no-deepthought)
			NODT="yes"
			info "No deepthought will be generated."
			shift
			;;
		--bfz=*|--BUFFER_SIZE=*)
			BUFFER_SIZE=$(echo $1 | cut -d= -f2)
			info "BUFFER_SIZE set to \033[0;35m$BUFFER_SIZE\033[0m."
			shift
			;;
		*)
			fatal_error "Invalid usage, argument $1 is not handled. Run \033[0;35m./smasher help \033[0mfor help !"
			shift
			;;
	esac
done

[ $RUN == "no" ] && fatal_error "Options may have been specified, but no command has been found. See help for more infos." $EXIT_INVALID_USAGE

# parse the configuration file
#
# @param	string	

function parse_config() {
	[ ! -f $1 ] && fatal_error "Could not retrieve config file, expected location was: $1" EXIT_PARSE_ERROR
	#horrible use of eval, absolutely unprotected: do not do this at home!
	eval gnl_path=$(grep "gnl_path" $1 | cut -d= -f2)
	[ $? -ne 0 ] && fatal_error "Error while parsing the config file." EXIT_PARSE_ERROR
}
