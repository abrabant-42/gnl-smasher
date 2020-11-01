#!/bin/bash

DEEPTHOUGHT="deepthought-$(date +%s)"
DT_PATH="./out/deepthought"

while [ $# -gt 0 ]
do
	key=$1
	case $key in
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
		--purge)
			rm -rf ./out/deepthought/*
			info "Purged \033[0;35m./out/deepthoughts\033[0m"
			shift
			;;
		*)
			warn "Unknown command line argument \033[0;32m$1\033[0m: ignored."
			shift
			;;
	esac
done

echo



# parse the configuration file
#
# @param	string	

function parse_config() {
	[ ! -f $1 ] && fatal_error "Could not retrieve config file, expected location was: $1" EXIT_PARSE_ERROR
	#horrible use of eval, absolutely unprotected: do not do this at home!
	eval gnl_path=$(grep "gnl_path" $1 | cut -d= -f2)
	[ $? -ne 0 ] && fatal_error "Error while parsing the config file." EXIT_PARSE_ERROR
}
