#!/bin/bash

# Download the webpage into website.txt
wget -q -O website.txt http://10.0.17.6/Assignment.html

# Extract temperature data (temperature and date-time) from the #temp table
temp_data=$(xmllint --html --xpath '//table[@id="temp"]//tr/td[1]/text()' website.txt 2>/dev/null)
temp_time=$(xmllint --html --xpath '//table[@id="temp"]//tr/td[2]/text()' website.txt 2>/dev/null)

# Combine the temperature data and time into a single line for each
echo "$temp_data" | paste -d " " - <(echo "$temp_time") > weather.txt

# Extract pressure data (pressure and date-time) from the #press table
pressure_data=$(xmllint --html --xpath '//table[@id="press"]//tr/td[1]/text()' website.txt 2>/dev/null)
pressure_time=$(xmllint --html --xpath '//table[@id="press"]//tr/td[2]/text()' website.txt 2>/dev/null)

# Combine the pressure data and time into a single line for each
echo "$pressure_data" | paste -d " " - <(echo "$pressure_time") > pressure.txt

# Combine both files based on the date-time and store it in combined_data.txt
paste weather.txt pressure.txt > combined_data.txt

# Format output and display it
awk '{print $1 " " $3 " " $2}' combined_data.txt | column -t
