#!/bin/bash
source ./config.inc &&
    for cluster in elastic-conf/*
    do
	echo "Populating ${cluster}..."
	for s in ${cluster}/script/*.sh
	do
	    echo "...$s"
	    $s 2>&1 | sed -e 's/^/\t/'
	done
    done
	
