#!/bin/bash

# Generate the reference GNL output, including the final return value.
#
# @param	string	=>	the reference file path
# @param	number	=>	the number of lines
# @param	number	=>	the expected final return value

test_name=""

function gen_ref() {
	output_file="./out/ref/$test_name.ref"
	if [ $2 -eq -1 ]
	then
		cat $1 > $output_file
	else
		head -$2 $1 > $output_file
	fi
	echo "return value: $3" >> $output_file
}

function run_tests() {
	test_files=("baudelaire1.txt" "baudelaire1.txt" "baudelaire1.txt" "baudelaire2.txt"					\
				)
	test_sources=("test_simple_line" "test_two_simple_lines" "test_full_file_with_newline_at_the_end"	\
					"test_full_file_with_empty_lines"													\
				)
	ref_lnnb=(1 2 -1 -1)
	ref_ret=(1 1 0 0)

	i=0
	for src in "${test_sources[@]}"
	do
		srcpath="./tests/src/$src.c"
		[ ! -f $srcpath ] && fatal_error "Could not run test: source file \033[0;34m$srcpath\033[0m not found."
		test_name=$(basename -s ".c" $srcpath)
		gen_ref "./tests/files/${test_files[i]}" ${ref_lnnb[i]} ${ref_ret[i]}
		comp_test $srcpath
		./testbin.out > ./out/test/$test_name.testout
		[ $? -ne 0 ] && warn "Error found in test \033[0;34m$test_name\033[0m. Ignoring it. Please report that!" && continue
		rm -rf ./testbin.out
		diff -u ./out/ref/$test_name.ref ./out/test/$test_name.testout > ./out/diffs/$test_name.diff
		diff_exit=$?
		# if there's no diff remove the file
		[ $diff_exit -eq 0 ] && rm -rf ./out/diffs/$test_name.diff
		# Produces the OK/KO output and increment the test counters
		assert_test $diff_exit $test_name
		# Register the test in the deepthought file
		register_test $test_name $i
		i=$((i+1))
	done
}
