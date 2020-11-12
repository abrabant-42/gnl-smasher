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
		head -$2 $1 >> $output_file 2> /dev/null
	fi
	[ $3 -ne -2 ] && echo "return value: $3" >> $output_file
}

# Generate the test output

function	gen_out() {
	comp_test $1
	[ $VALCHECK == "yes" ] && valcheck ./testbin.out
	./testbin.out > ./out/test/$test_name.testout
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
	# The files that are going to be used
	test_files=("baudelaire1.txt" "baudelaire1.txt" "baudelaire1.txt" "baudelaire2.txt"					\
					"no_newline.txt" "empty_lines.txt" "empty.txt" "bigline.txt" "many_biglines.txt"	\
					"baudelaire1.txt" "baudelaire1.txt" "baudelaire1.txt"
				)
	# The source files of each test that is going to be run
	test_sources=("test_simple_line" "test_two_simple_lines" "test_full_file_with_newline_at_the_end"	\
					"test_full_file_with_empty_lines" "test_no_newline"									\
					"test_full_file_empty_lines_only" "test_empty_file" "test_one_big_line" 			\
					"test_many_big_lines" "test_directory_fd" "test_negative_fd" "test_NULL_line"		\
				)
	# The number of lines we need to read for each test. -1 means read the entire file
	ref_lnnb=(1 2 -1 -1 -1 -1 -1 -1 -1 0 0 0)
	# The expected final return value of the GNL. -2 means no return value is expected.
	ref_ret=(1 1 0 0 -2 0 0 0 0 -1 -1 -1)

	printf "\n"

	i=0
	# Loop over each source file and apply the same testing logic
	for src in "${test_sources[@]}"
	do
		# Defines the path of the source file, given only the file name
		srcpath="./tests/src/$src.c"
		# Checks if the source path exists, exit if not (should not happen unless you did garbage)
		[ ! -f $srcpath ] && fatal_error "Could not run test: source file \033[0;34m$srcpath\033[0m not found."
		test_name=$(basename -s ".c" $srcpath)

		# Generates reference output
		gen_ref "./tests/files/${test_files[i]}" ${ref_lnnb[i]} ${ref_ret[i]}
		# Generates user test outputed
		gen_out $srcpath

		# Checks if correct with diff -u
		check_test

		# Register test to the deepthought file if enabled
		[ $NODT == "no" ] && register_test $test_name $i

		i=$((i+1))
	done
}

# Run the single multi fd test available. This should be enought to determine
# if the multi-fd handling is great. See the source file for more informations
# about how the test is done.

function	run_multi_fd_test() {
	# The files that are going to be used
	files=("baudelaire1.txt" "baudelaire2.txt" "empty.txt" "empty_lines.txt")
	# The first X lines to read for each files, respectively.
	ref_llnb=(2 7 3 6)
	# The expected return values of the final call to GNL
	ref_ret=(1 1 0 1)

	test_name="test_multi_fd"
	output_file="./out/ref/$test_name.ref"
	srcpath="./tests/src/test_multi_fd.c"

	# First loop, writes the first ${ref_llnb[i]} lines of the file
	i=0
	for file in ${files[@]}
	do
		head -${ref_llnb[i]} ./tests/files/$file >> $output_file
		i=$((i+1))
	done

	# Final loop, writes the next line of each file to ensure multi-fd is
	# indeed working as expected.
	i=0
	for file in ${files[@]}
	do
		sed -n $((${ref_llnb[i]} + 1))p ./tests/files/$file >> $output_file
		echo "return value: ${ref_ret[i]}" >> $output_file
		i=$((i+1))
	done

	# generates the user test output
	gen_out $srcpath

	# checks if correct with a diff -u
	check_test

	# registers the test in deepthought if enabled
	[ $NODT == "no" ] && register_test $test_name "bonus"
}
