#!/bin/bash

function valcheck() {
	bin=$1
	report=$(valgrind $bin 2>&1 | grep -i "definitely lost")
	echo $report| grep -i "0 bytes in 0 blocks" &>/dev/null
	[ $? -eq 0 ] && report=""
	echo -e "\n----------[ \033[0;34mVALCHECK\033[0m ]----------\n"
	if [ ! -z "$report" ]
	then
		warn "LEAKS FOUND!"
		echo "$report"
	else
		info "No leak!"
	fi
	echo -e "---------------------------\n"
}
