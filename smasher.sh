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

# Init deepthought
source scripts/deepthought.sh

# Compile project
compile_proj_objs $gnl_path

run_tests

summary

finish_cleanup
