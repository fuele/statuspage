#!/bin/sh

if [ -z "$TARGET_HOST" ]; then
	echo "Mandatory environment variable TARGET_HOST not set. Exiting.">&2
	exit 1
fi
ping -c 5 $TARGET_HOST | tail -n 1 | cut -d/ -f5
