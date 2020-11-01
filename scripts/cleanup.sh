#!/bin/bash

function prepare_cleanup() {
	rm -rf ./.obj/*
	rm -rf out/diffs/*
	rm -rf out/ref/*
	rm -rf out/test/*
	mkdir -p out/diffs out/ref out/test out/deepthought 2> /dev/null
}

function finish_cleanup() {
	rm -rf ./testbin.out
}
