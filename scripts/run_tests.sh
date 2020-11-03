#!/bin/bash

test_name=""

# Generate the reference GNL output, including the final return value.
#
# @param	string	=>	the reference file path
# @param	number	=>	the number of lines
# @param	number	=>	the expected final return value

function gen_ref() {
	output_file="./out/ref/$test_name.ref"
	if [ $2 -eq -1 ]
	then
		cat $1 >> $output_file
	else
		head -$2 $1 >> $output_file
	fi
	[ $3 -ne -2 ] && echo "return value: $3" >> $output_file
}

# Generate the test output

function	gen_out() {
	comp_test $1
	./testbin.out >> ./out/test/$test_name.testout
	[ $? -ne 0 ] && warn "Error found in test \033[0;34m$test_name\033[0m. Ignoring it."
	rm -rf ./testbin.out
}

# Check if the test fails or passes

function check_test() {
	diff -u ./out/ref/$test_name.ref ./out/test/$test_name.testout > ./out/diffs/$test_name.diff
	diff_exit=$?
	# if there's no diff remove the file
	[ $diff_exit -eq 0 ] && rm -rf ./out/diffs/$test_name.diff
	# Produces the OK/KO output and increment the test counters
	assert_test $diff_exit $test_name
	# Register the test in the deepthought file
}

function run_tests() {
	test_files=("baudelaire1.txt" "baudelaire1.txt" "baudelaire1.txt" "baudelaire2.txt"					\
					"no_newline.txt" "empty_lines.txt" "empty.txt" "bigline.txt" "many_biglines.txt"	\
					"baudelaire1.txt" "baudelaire1.txt" "baudelaire1.txt"
				)
	test_sources=("test_simple_line" "test_two_simple_lines" "test_full_file_with_newline_at_the_end"	\
					"test_full_file_with_empty_lines" "test_no_newline"									\
					"test_full_file_empty_lines_only" "test_empty_file" "test_one_big_line" 			\
					"test_many_big_lines" "test_directory_fd" "test_negative_fd" "test_NULL_line"		\
				)
	ref_lnnb=(1 2 -1 -1 -1 -1 -1 -1 -1 0 0 0)
	ref_ret=(1 1 0 0 -2 0 0 0 0 -1 -1 -1)

	i=0
	printf "\n"
	for src in "${test_sources[@]}"
	do
		srcpath="./tests/src/$src.c"
		[ ! -f $srcpath ] && fatal_error "Could not run test: source file \033[0;34m$srcpath\033[0m not found."
		test_name=$(basename -s ".c" $srcpath)

		gen_ref "./tests/files/${test_files[i]}" ${ref_lnnb[i]} ${ref_ret[i]}
		gen_out $srcpath
		check_test

		# Register to deepthought
		[ $NODT == "no" ] && register_test $test_name $i
		i=$((i+1))
	done
}

function	run_multi_fd_test() {
	files=("baudelaire1.txt" "baudelaire2.txt" "empty.txt" "empty_lines.txt")
	ref_llnb=(2 7 3 6)
	ref_ret=(1 1 0 1)

	test_name="test_multi_fd"
	srcpath="./tests/src/test_multi_fd.c"
	
	i=0
	for file in ${files[@]}
	do
		gen_ref "./tests/files/$file" ${ref_llnb[i]} ${ref_ret[i]}
		i=$((i+1))
	done

	gen_out $srcpath

	check_test

	[ $NODT == "no" ] && register_test $test_name "bonus"
}
