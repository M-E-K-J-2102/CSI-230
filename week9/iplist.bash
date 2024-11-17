#!/bin/bash

# List all the ips in the  given network prefix
# /24 only

# Usage: Bash IPList.bash 10.0.17
[ "$#" -ne 1 ] && echo "Usage: $0 <prefix>" && exit 1

# Prefix is the first input taken
prefix=$1

# Verify input length
[ "${#prefix}" -ne 7 ] && \
printf "Prefix length is too short or too long \nPrefix example: 10.0.17\n" && \
exit 1
for i in {1..254}
do
	if
	 ping -c 1 -W 1 "$prefix.$i" | grep -q 'bytes from'; then
        echo "$prefix.$i is active"
fi
done
