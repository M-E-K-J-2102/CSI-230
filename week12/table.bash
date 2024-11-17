#! /bin/bash
clear

# Website that the code will scrape
link="10.0.17.6/Assignment.html"

# Get it with curl
fullPage=$(curl -sL "$link")

# Use xmlstarlet to extract ctable from the page
toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"//html//body//table//tr")

# Processing HTML with sed
# 1- Replacing every </tr> with a line break
echo "$toolOutput" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g' \
		      > weather.txt

