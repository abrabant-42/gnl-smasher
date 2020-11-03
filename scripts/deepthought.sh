#!/bin/bash

echo -e "deepthought issued at $(date)\n" > $DT_PATH/$DEEPTHOUGHT

# Register the test in the deepthought file
#
# @param	string	the test name
# @param	number	the test number

function register_test() {
	echo "========== Test $2 =========" >> $DT_PATH/$DEEPTHOUGHT
	if [ ! -f ./out/diffs/$1.diff ]
	then
		echo "Diff OK :)" >> $DT_PATH/$DEEPTHOUGHT
	else
		cat -e ./out/diffs/$1.diff >> $DT_PATH/$DEEPTHOUGHT
		echo "Diff KO :(" >> $DT_PATH/$DEEPTHOUGHT
		echo >> $DT_PATH/$DEEPTHOUGHT
	fi
}
