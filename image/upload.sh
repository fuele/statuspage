#!/bin/bash

if [ -z "$PAGE_ID" ]; then
	echo "Mandatory environment variable PAGE_ID not set. Exiting.">&2
	exit 1
fi
if [ -z "$TOKEN" ]; then
	echo "Mandatory environment variable TOKEN not set. Exiting.">&2
	exit 1
fi
if [ -z "$METRIC_ID" ]; then
	echo "Mandatory environment variable METRIC_ID not set. Exiting.">&2
	exit 1
fi

if [ -p /dev/stdin ]; then
	read METRIC
else
	echo "Metric must be piped into STDIN of this script.">&2
	exit 2
fi

re='^[0-9]+([.][0-9]+)?$'
if ! [[ $METRIC =~ $re ]] ; then
	echo "error: STDIN not a number" >&2 
	echo "STDIN='${METRIC}'"
	exit 3
fi

EPOCH_TIME=`date +%s`

echo -n `date`

curl --silent "https://api.statuspage.io/v1/pages/${PAGE_ID}/metrics/data" \
	-X POST \
       	-H "Authorization: OAuth ${TOKEN}" \
	-d "data[${METRIC_ID}][][timestamp]=${EPOCH_TIME}" \
	-d "data[${METRIC_ID}][][value]=${METRIC}"

echo ""
