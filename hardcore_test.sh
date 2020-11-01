#!/bin/bash

testnb=30
[ $1 -ne 0 ] && testnb=$1

for i in $(seq 1 $testnb)
do
	./test.sh --bfz=$RANDOM --dt-name=hardcore-run-$(date +%s)
done
