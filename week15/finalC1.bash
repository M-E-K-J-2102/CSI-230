#!/bin/bash

# URL of the IOC page
URL="http://10.0.17.6/IOC.html"

# Output file
OUTPUT_FILE="IOC.txt"

# Clear the output file to avoid duplicates
> $OUTPUT_FILE

# Get content of page and extract IOCs
curl -s $URL | \

# Extract rows with pattern and description
grep -oP '(?<=<td>).*?(?=</td>)' | \
awk 'NR % 2 == 1' >> $OUTPUT_FILE

# Cat IOC.txt
cat $OUTPUT_FILE
