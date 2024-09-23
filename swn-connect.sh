#!/bin/sh
# swn-connect.sh USERNAME PASSWORD - connect to SWN@SSOE network

NETCHECK='http://connectivitycheck.grapheneos.network/generate_204'

USERNAME="$1"
PASSWORD="$2"

while
	endpoint="$(curl -s "$NETCHECK" | grep -o 'https://login.swn.moe.edu.sg[^"]*')"
	[ -n "$endpoint" ]
do
	echo >&2 "$endpoint"
	curl -s "$endpoint" >/dev/null
	curl \
	--data-urlencode username="$USERNAME" \
	--data-urlencode password="$PASSWORD" \
	--data-urlencode magic="${endpoint#*\?}" \
	"${endpoint}"
done
