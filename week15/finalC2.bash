#!/bin/bash

# Check arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <log_file> <ioc_file>"
    exit 1
fi

# Assign arguments to variables
LOG_FILE=$1
IOC_FILE=$2
REPORT_FILE="report.txt"

# Delete old data
> $REPORT_FILE

# Loop through each pattern and search in the log file
while IFS= read -r IOC; do
    # Ensure the IOC pattern is not empty
    if [ -n "$IOC" ]; then
        # Extract matching lines from the log file
        grep -i "$IOC" "$LOG_FILE" | \
        # processs the log
        awk '{
            # Extract IP address
            ip=$1;
            # Formatting
            timestamp=substr($4, 2, length($4)-2);
            gsub(/[+-][0-9]{4}/, "", timestamp);

	    # Extract the page accessed
            page = substr($0, index($0, "\"GET ") + 5, index($0, " HTTP/1.1") - index($0, "\"GET ") - 5);

            # Output the formatted result
            print ip "\t" timestamp "\t" page;
        }' >> "$REPORT_FILE"
    fi
done < "$IOC_FILE"

# Cat the report
cat "$REPORT_FILE"
