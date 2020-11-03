#!/bin/bash

source scripts/check.sh
source scripts/constants.sh
source scripts/msg.sh
source scripts/compile.sh
source scripts/run_tests.sh
source scripts/cleanup.sh

config_path="./gnl_smasher.config"
gnl_path="./gnl"
test_curname="tests/test_simple.c"
test_failed=0
test_passed=0
test_ignored=0

prepare_cleanup

# Parse and check
source scripts/parse.sh
parse_config $config_path
is_gnl_path_correct $gnl_path
[ $DT_PATH != "./out/deepthought" ] && is_dt_path_correct

# Init deepthought
source scripts/deepthought.sh

# Compile project
compile_proj_objs $gnl_path

run_tests
[ $BONUS == "yes" ] && run_multi_fd_test

summary

finish_cleanup

# Clean everything at the end of the tests if --nolog is specified
[ $LOG == "no" ] && prepare_cleanup
