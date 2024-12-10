#!/bin/bash
# Must run with sudo!!
# Define the output HTML file
HTML_REPORT="report.html"

# Start the HTML structure (without CSS)
echo "<!DOCTYPE html>" > $HTML_REPORT
echo "<html lang='en'>" >> $HTML_REPORT
echo "<head>" >> $HTML_REPORT
echo "<meta charset='UTF-8'>" >> $HTML_REPORT
echo "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" >> $HTML_REPORT
echo "<title>IOC Report</title>" >> $HTML_REPORT
echo "</head>" >> $HTML_REPORT
echo "<body>" >> $HTML_REPORT
echo "<h1>Indicators of Compromise (IOC) Report</h1>" >> $HTML_REPORT
echo "<table border='1'>" >> $HTML_REPORT
echo "<tr><th>IP Address</th><th>Date/Time</th><th>Page Accessed</th></tr>" >> $HTML_REPORT

# Convert the report into HTML table rows
while IFS=$'\t' read -r ip timestamp page; do
    echo "<tr><td>$ip</td><td>$timestamp</td><td>$page</td></tr>" >> $HTML_REPORT
done < "report.txt"

echo "</table>" >> $HTML_REPORT
echo "</body>" >> $HTML_REPORT
echo "</html>" >> $HTML_REPORT

# Move the HTML report to /var/www/html/
sudo mv $HTML_REPORT /var/www/html/

# Code Works
echo "HTML report has been generated and moved to /var/www/html/."
